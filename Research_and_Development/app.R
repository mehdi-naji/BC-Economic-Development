# Libraries ----
library(shiny)
library(ggplot2)
library(tidyr)
library(tidyverse)
library(tidyquant)
library(lubridate)
library(plotly)
library(leaflet)
library(cowplot)
library(grid)
library(gtable)
library(shinydashboard)
options(shiny.autoreload = TRUE)

# Downloading processed data ----
url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Research_and_Development_1.csv"
df <- read.csv(url, header = TRUE)
df <- na.omit(df)


url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Research_and_Development_Growth_1.csv"
df_growth <- read.csv(url, header = TRUE)
df_growth <- na.omit(df_growth)

url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Research_and_Development_3.csv"
df_comp <- read.csv(url, header = TRUE)
df_comp <- na.omit(df_comp)

# User Interface -----
## ui_components ----
### line plot ----
ui_lineplot <- column(6,plotlyOutput("line_plot"))

### table ----
ui_table <-  column(3, DT::dataTableOutput("table"))

### barplot ----
ui_barplot <- column(4, plotlyOutput("barplot"))

### sankey graph ----
ui_sankey <- column(5,plotlyOutput("sankey_diagram"))

### tabs ----
ui_text_tabs <- column(4, tabsetPanel(
  tabPanel("Analysis", 
           uiOutput("analysis")),
  tabPanel("Considerations", 
           uiOutput("consideration"))))


## design -----
ui <- dashboardPage(
  dashboardHeader(
    title = "StrongerBC: Research and Development",titleWidth = 450
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Inputs", tabName = "inputs", icon = icon("dashboard")),
        selectInput("geo", "GEO", choices = unique(df$GEO)), 
        selectInput("prices", "Prices", choices = unique(df$Prices)), 
        selectInput("science_type", "Science Type", choices = unique(df$Science.type)), 
        selectInput("funder", "Funder", choices = unique(df$Funder)), 
        selectInput("performer", "Performer", choices = unique(df$Performer)),
        selectInput("year", "Year", choices = unique(df$Year), selected = 2022)
    )
  ),
  dashboardBody(
    tags$style(HTML("
      .skin-blue .main-header .navbar, 
      .skin-blue .main-header .logo,
      .skin-blue .main-header .logo:hover,
      .skin-blue .main-header .navbar .sidebar-toggle,
      .skin-blue .main-header .navbar .sidebar-toggle:hover,
      .skin-blue .content-header, 
      .skin-blue .wrapper, 
      .content-wrapper, 
      .right-side   { 
                      background-color: white; 
                      color: black;
      }


      .skin-blue .main-header .navbar .sidebar-toggle {
                      position: fixed;
                      left:0;
                    }
    ")),
    fluidRow(
      ui_lineplot, ui_text_tabs),
    fluidRow(
      ui_barplot, ui_table, ui_sankey)))


# Server ----
server <- function(input, output) {

# Data ----
## line plot data----  
  filtered_data <- reactive({
    df %>%
      filter(GEO == input$geo,
             Funder == input$funder,
             Performer == input$performer,
             Science.type == input$science_type,
             Prices == input$prices)
  })

## growth table data----
  filtered_data_growth <- reactive({
    df_growth %>%
      filter (GEO %in% c("British Columbia", "Ontario", "Quebec", "Alberta", "Canada"),
                     Funder == input$funder,
                     Performer == input$performer,
                     Science.type == input$science_type,
                     Prices == input$prices)|>
               select (GEO, GR_15_20, GR_17_20)|>
      mutate(GR_15_20 = paste0(round(GR_15_20*100,1),"%"),
             GR_17_20 = paste0(round(GR_17_20*100,1),"%"))|>
      mutate(GEO = factor(GEO, levels = c("British Columbia", "Ontario", "Quebec", "Alberta", "Canada")))|>
      arrange(GEO)|>
      rename(Region = GEO,
             "3-year growth <br>(2015-2020)" = GR_15_20,
             "5-year growth <br>(2017-2020)" = GR_17_20)
  })

## bar line data----  
  filtered_data_bar <- reactive({
    df_comp |> 
      filter (Year == input$year,
              GEO %in% c("British Columbia", "Ontario", "Quebec", "Alberta", "Canada", 
                         "France", "Germany", "Italy", "Japan", "United Kingdom", "United States")
              )|>
      arrange(desc(VALUE)) %>%
      mutate(GEO = factor(GEO, levels = GEO))
  })

## sankey plot data----
  sankey_data <- reactive({
    df |>
      filter(Year == input$year,
             GEO == input$geo,
             Science.type == input$science_type,
             Prices == input$prices,
             Funder != " total, all sectors",
             Performer != " total, all sectors") |>
      mutate(Funder = paste(Funder, "(F)", sep = " "),
             Performer = paste(Performer, "(P)", sep = " "))
  })

# Rendering ----
## line plot ----
  output$line_plot <- renderPlotly({
    df1 <- filtered_data()
    p1 <- df1 |> 
            plot_ly(x = ~Year, y = ~VALUE, type = 'scatter', mode = 'lines') |>
            layout(title = list(text = paste("Research and Development in <b>" , 
                                 input$science_type, "</b>", 
                                 " in <b>",input$geo , "</b>",
                                 "\n", "Funder:<b>", input$funder, "</b>", 
                                 "\n", "Performer:<b>", input$performer, "</b>"),
                                x=0.1, y=0.78,font = list(size = 14)),
                   xaxis = list(
                     title = "", 
                     rangeslider = list(
                       visible = T,
                       thickness = 0.02,  
                       bgcolor = "darkgrey"  
                     )
                   ),
             yaxis = list(title = paste ("million $ (", "<b>", input$prices, "</b>)")))

  p1 <- ggplotly(p1)
  })   
  
  
  ## Sankey diagram ----
  output$sankey_diagram <- renderPlotly({
    df1 <- sankey_data()
    nodes <- data.frame(name = c(as.character(df1$Funder), as.character(df1$Performer)))
    nodes <- unique(nodes)
    links <- data.frame(source = match(df1$Funder, nodes$name) - 1,
                        target = match(df1$Performer, nodes$name) - 1,
                        value = df1$VALUE)
    node_colors <- c(                      " total, all sectors (F)" = "grey",
                                    " federal government sector (F)" = "red", 
                                " provincial governments sector (F)" = "orange", 
                     " provincial research organizations sector (F)" = "yellow",
                                   " business enterprise sector (F)" = "green",
                                      " higher education sector (F)" = "violet", 
                                    " private non-profit sector (F)" = "blue", 
                                               " foreign sector (F)" = "brown",
                                           " total, all sectors (P)" = "grey",
                                    " federal government sector (P)" = "red", 
                                " provincial governments sector (P)" = "orange", 
                     " provincial research organizations sector (P)" = "yellow",
                                   " business enterprise sector (P)" = "green",
                                      " higher education sector (P)" = "violet", 
                                    " private non-profit sector (P)" = "blue")
    
    
    nodes$color <- node_colors[nodes$name]
    
    links$source_name <- nodes$name[links$source + 1]
    links$target_name <- nodes$name[links$target + 1]

   fig <- plot_ly(
      type = "sankey",
      domain = list(
        x = c(0,1),
        y = c(0,1)
      ),
      orientation = "h",
      valueformat = "$,.0f",
      valuesuffix = "M",
      node = list(
        label = nodes$name,
        color = nodes$color,
        pad = 15,
        thickness = 30,
        line = list(
          color = "grey",
          width = 0.5
        ),
        hovertemplate = '%{label}<br>Total Value: %{value}<extra></extra>'
        
      ),
      
      
      link = list(
        source = links$source,
        target = links$target,
        value = links$value
      ))
    
  
    fig <- fig |> layout(
      title = "The Flow from Funders (Left) to Performenrs (Right)",
      font = list(
        size = 12
      )
    )
    
    fig
  })
  
  # Render the text boxes
  
  output$text_box_2 <- renderText({
    paste("This is the second text box.")
  })
  
  ## growth table ----
  output$table <- DT::renderDataTable({
    data <- filtered_data_growth()
    DT::datatable(data, options = list(dom = 't'), escape = FALSE, rownames = FALSE, 
                  caption = htmltools::tags$caption(style = "caption-side: top; font-size: 130%;", 
                                                    "Research and Development Spending Growth"))
  })


  
  ## bar plot ----
  output$barplot <- renderPlotly({
    my_colors <- c("grey", "red", "orange", "yellow", "green", "violet",
                   "blue", "pink", "brown", "navy")
    geo_colors <- c("Ontario" = "grey",
                    "United Kingdom" = "red", 
                    "United States" = "orange", 
                    "Japan" = "yellow",
                    "British Columbia" = "green",
                    "Germany" = "violet", 
                    "Alberta" = "blue", 
                    "France" = "brown",
                    "Quebec" = "pink",
                    "Canada" = "navy", 
                    "Italy" = "brown")

    df2 <- filtered_data_bar()
    df2$color <- geo_colors[df2$GEO]
    p2 <- df2 |> 
      plot_ly(y = ~VALUE, color=~GEO, type = 'bar',marker = list(color = ~color))  |>
      layout(title = "Research and Development in Selected Provices",
             xaxis = list(title = ""),
             yaxis = list(title = ""),
             legend = list(orientation = "h", xanchor = "center", x = 0.5, y = -0.2))
    
    return(p2)
  })
  
  
  output$analysis <- renderUI({
    HTML("
  <ul style='text-align: justify;'>
    <li>Spending on research and development promotes scientific and technological advancement while fostering economic progress through growth, productivity, adaptation, and market resilience.</li>
    <li>Private sector in B.C. performed $2,333 million R&D in 2020, a 179 percent growth from $835 million in 2000.</li>
    <li>Private sector accounted for 45 percent of overall R&D spending in the province in 2020.</li>
    <li>B.C.’s private sector has seen a sharp increase in R&D spending in 2018, with an annual growth rate at 26.1 percent, the highest in the past 20 years.</li>
    <li>B.C. surpassed Alberta in private sector R&D spending in 2016 and have remained third in Canada, following Ontario and Quebec.</li>
  </ul>
  ")
  })
  
  
  
  output$consideration <- renderUI({
    HTML("
  <ul style='text-align: justify;'>
    <li>Some selections might lack sufficient data.</li>
  </ul>
  ")
  })
  
  
}

# Run the app
shinyApp(ui = ui, server = server)

