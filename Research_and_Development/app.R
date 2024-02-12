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
library(RColorBrewer)

options(shiny.autoreload = TRUE)

# Downloading processed data ----
url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Non_Residential_Investment_1.csv"
df <- read.csv(url, header = TRUE)
df <- na.omit(df)

# url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Research_and_Development_Modal_data.csv"
# Modal_df <- read.csv(url, header = TRUE)

# Static inputs ----
# modal_title1 <- "Private sector investment in innovation"
# modal_text1 <- paste("The amount spent on research and development by the business enterprise sector (not adjusted for inflation) in") 
# modal_title2 <- "Value-added exports"
# modal_title3 <- "Non-residential structures, machinery and equipment and IP investment as share of GDP"
# modal_title4 <- "Labour Productivity"
# modal_title5 <- "Exports as % of GDP"

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
ui_text_tabs <- column(6, tabsetPanel(
  tabPanel("Analysis", 
           uiOutput("analysis")),
  tabPanel("Considerations", 
           uiOutput("consideration"))))


## design -----
ui <- dashboardPage(
  dashboardHeader(
    title = tags$a(
      tags$img(src='https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/main/logo.png', height='40', width='200', style="padding-left: 25px;float: left;") , 
      tags$span("Non-residential investment as a share of GDP", style = " color: black;font-size: 130%; "),
      href='https://strongerbc.shinyapps.io/research_and_development/',
    ),titleWidth = 600
  ),
  dashboardSidebar(
    collapsed = TRUE,
    sidebarMenu(
      menuItem("Inputs", tabName = "inputs", icon = icon("dashboard")),
        selectInput("geo", "Region", choices = unique(df$GEO), selected = "British Columbia"), 
        selectInput("prices", "Price type", choices = unique(df$Prices)), 
        selectInput("item", "Item", choices = unique(df$Estimates)), 
        selectInput("year", "Year", choices = unique(df$Year), selected = 2020)
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
    tags$style(type="text/css",
               ".shiny-output-error-validation {
     font-size: 15px;
    }"
    ),
    
    tags$head(tags$style(".modal-dialog { width: 80%; }")),
    tags$head(tags$style(".modal-body { min-height: 700px; }")),
    fluidPage(
      # modalDialog(
      #   easyClose = TRUE, 
      #   size = "l", 
      #   footer = tagList(modalButton("OK")),
      #   fluidRow(
      #     column(4, style = "height: 400px; background-color: white;margin-buttom: 10px;margin-right: 10px;"),
      #     column(2, style = "height: 400px; background-color: white; border: 1px solid darkgreen; margin-right: 10px;margin-buttom: 10px;", 
      #            h4(modal_title1, style = "color: darkgreen; font-weight: bold;"), 
      #            p(modal_text1),
      #            p(Modal_df$Year, 
      #              style = "font-size: 30px; font-family: Arial; color: darkgreen;"),
      #            p(paste0("$", format(Modal_df$PrivateInvestment/1000, big.mark = ",", scientific = FALSE), "billion"), 
      #              style = "font-size: 40px; font-family: Arial; color: black;")),
      #     column(2, style = "height: 400px; background-color: white; border: 1px solid darkgreen; margin-right: 10px;margin-buttom: 10px;", 
      #            h4(modal_title2, style = "color: darkgreen; font-weight: bold;"), 
      #            p("$200,000", style = "color: black;")),
      #     column(2, style = "height: 400px; background-color: white; border: 1px solid darkgreen; margin-right: 10px;margin-buttom: 10px;", 
      #            h4(modal_title3, style = "color: darkgreen; font-weight: bold;"), 
      #            p("$300,000", style = "color: black;")),
      #     column(1, style = "height: 400px; background-color: darkgreen;margin-buttom: 10px;")
      #   ),
      #   fluidRow(
      #     column(4, style = "height: 400px; background-color: darkgreen;margin-right: 10px; margin-top: 10px;", 
      #            h2("Fostering \n Innovation Across Economy", style = "color: white; font-size: 300%;")),
      #     column(3, style = "height: 400px; background-color: white; border: 1px solid darkgreen; margin-right: px; margin-top: 10px;", 
      #            h4(modal_title4, style = "color: darkgreen; font-weight: bold;"), 
      #            p("$400,000", style = "color: black;")),
      #     column(3, style = "height: 400px; background-color: white; border: 1px solid darkgreen; margin-top: 10px;", 
      #            h4(modal_title5, style = "color: darkgreen; font-weight: bold;"), 
      #            p("$500,000", style = "color: black;")),
      #     column(1, style = "height: 400px; background-color: white;")
      #   )
      # ),
      h3(textOutput("title"))
    ),
    fluidRow(
      ui_lineplot, ui_text_tabs),
    fluidRow(
      ui_sankey, ui_table, ui_barplot),
    fluidPage(
      textOutput("source")
    )
    ))


# Server ----
server <- function(input, output, session) {

# Data ----
## line plot data----  
  filtered_data <- reactive({
    df |>
      filter(GEO == input$geo,
             Estimates == input$item,
             Performer == input$performer,
             Science.type == input$science_type,
             Prices == input$prices)
  })

## growth table data----
  
  filtered_data_growth <- reactive({
    
    df_growth <- df |>
      arrange(GEO, Funder, Performer, Science.type, Prices, Year) |>
      filter(Year %in% c(as.numeric(as.character(input$year)) -5, 
                         as.numeric(as.character(input$year))-3, 
                         as.numeric(as.character(input$year)))) |>
      group_by(GEO, Funder, Performer, Science.type, Prices) |>
      mutate(Maxyear = input$year,
             GR5 = ifelse(all(c(as.numeric(as.character(input$year))-5, 
                                as.numeric(as.character(input$year))) %in% Year), 
                          (VALUE[Year == as.numeric(as.character(input$year))] / VALUE[Year == as.numeric(as.character(input$year))-5]) - 1, NA),
             GR3 = ifelse(all(c(as.numeric(as.character(input$year))-3, 
                                as.numeric(as.character(input$year))) %in% Year), 
                          (VALUE[Year == as.numeric(as.character(input$year))] / VALUE[Year == as.numeric(as.character(input$year))-3]) - 1, NA))|>
      select(GEO, Funder, Performer, Science.type, Prices, GR5, GR3, Maxyear, Year)|>
      distinct(.keep_all = TRUE) |>
      filter (GEO %in% c("British Columbia", "Ontario", "Quebec", "Alberta", "Canada"),
              Year == as.numeric(as.character(input$year)),
              Funder == input$funder,
              Performer == input$performer,
              Science.type == input$science_type,
              Prices == input$prices)|>
      ungroup()|>
      select (GEO, GR3, GR5, Maxyear) |>
      mutate(GR5 = paste0(round(GR5*100,1),"%"),
             GR3 = paste0(round(GR3*100,1),"%"))|>
      mutate(GEO = factor(GEO, levels = c("British Columbia", "Ontario", "Quebec", "Alberta", "Canada")))|>
      arrange(GEO)|>
      rename(Region = GEO) |>
      rename_with(~paste0("3-year growth <br>(", as.numeric(as.character(input$year))-3, "-", as.numeric(as.character(input$year)) ,")") , GR3)|>
      rename_with(~paste0("5-year growth <br>(", as.numeric(as.character(input$year))-5, "-", as.numeric(as.character(input$year)) ,")") , GR5)|>
      select(-Maxyear)
    
  })

## bar line data----  
  filtered_data_bar <- reactive({
    df_comp |> 
      filter (Year == input$year,
              GEO %in% c("British Columbia", 
                         "Ontario", 
                         "Quebec", 
                         "Alberta", 
                         "Canada", 
                         "France", 
                         "Germany", 
                         "Italy", 
                         "Japan", 
                         "United Kingdom", 
                         "United States")
              )|>
      arrange(VALUE) %>%
      mutate(GEO = factor(GEO, levels = GEO),
             color = case_when(
               GEO == "Ontario" ~ "lightblue1" ,
               GEO == "Quebec" ~ "lightskyblue1" ,
               GEO == "Alberta" ~ "lightskyblue2" ,
               GEO == "British Columbia" ~ "steelblue3",
               GEO == "Canada" ~ "royalblue4",
               GEO == "United States" ~ "#00868B",
               TRUE ~ "darkgrey"))
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

  output$title <- renderText({
    if (input$funder == " business enterprise sector") {
      "Private Sector Investment in Innovation"
    } else if (input$funder == " federal government sector") {
      "Federal Government Investment in Innovation"
    } else if (input$funder == " provincial governments sector") {
      "Provincial Government Investment in Innovation"
    } else if (input$funder == " provincial research organizations sector") {
      "Provincial Research Organizations Investment in Innovation"
    } else if (input$funder == " foreign sector") {
      "Foreign Investment in Innovation"
    } else if (input$funder == " higher education sector") {
      "Higher Education Investment in Innovation"
    } else {"Investment in Innovation"}
  })
  
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
  validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
    
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
                                    " federal government sector (F)" = "#8DB6CD", 
                                " provincial governments sector (F)" = "#00EEEE", 
                     " provincial research organizations sector (F)" = "#edbf33",
                                   " business enterprise sector (F)" = "#4F94CD",
                                      " higher education sector (F)" = "#27408B", 
                                    " private non-profit sector (F)" = "#27aeef", 
                                               " foreign sector (F)" = "#BFEFFF",
                                           " total, all sectors (P)" = "grey",
                                    " federal government sector (P)" = "#8DB6CD", 
                                " provincial governments sector (P)" = "#00EEEE", 
                     " provincial research organizations sector (P)" = "#edbf33",
                                   " business enterprise sector (P)" = "#4F94CD",
                                      " higher education sector (P)" = "#27408B", 
                                    " private non-profit sector (P)" = "#27aeef")
    
    
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
      title = paste("The Flow from Funders (Left) to Performenrs (Right) \n in" , input$year),
      font = list(family = 'Arial', size = 12),
      font = list(
        size = 12
      )
    )
    validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the 'Year',  'Price type', or 'Region' selection in the sidebar."))
    
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
                  caption = htmltools::tags$caption("Research and Development Spending Growth",
                                                    style = "font-family: Arial; font-size: 12px;"))
  })


  
  ## bar plot ----
  output$barplot <- renderPlotly({

    df2 <- filtered_data_bar()
    df2$formatted_VALUE <- sprintf("%.1f%%", df2$VALUE)
    df2$adjusted_VALUE <- df2$VALUE + 0.2
    p2 <- df2 |> 
      plot_ly(x = ~VALUE,y=~GEO, color=~GEO, type = 'bar',
              colors = ~color, showlegend = FALSE)  |>
      add_text(x = ~adjusted_VALUE,text = ~formatted_VALUE, textposition = 'outside') |>
      layout(title = paste("Research and Development as percentage of GDP \n in", input$year),
             font = list(family = 'Arial', size = 12),
             yaxis = list(title = ""),
             xaxis = list(title = "Percent"),
             bargroupgap = 0.3)
 
    validate(need(nrow(df2) > 0, "The data for this year is inadequate. To obtain a proper visualization, please modify the year selection in the sidebar."))
    return(p2)
  })
  
  
  output$analysis <- renderUI({
    HTML("
  <ul style='text-align: justify;'>
    <li>Spending on research and development promotes scientific and technological advancement while fostering economic progress through growth, productivity, adaptation, and market resilience.</li>
    <li>Between 2020 and 2021, private sector R&D spending in British Columbia grew by $341 million to $3.028 billion. It increased by 263 percent from $835 million in 2000.</li>
    <li>Private sector accounted for 50.5 percent of overall R&D spending in the province in 2021, highest in Canada.</li>
    <li>B.C.’s private sector has seen a sharp increase in R&D spending in 2018, with an annual growth rate at 26.1 percent, the highest in the past 20 years.</li>
    <li>B.C. surpassed Alberta in private sector R&D spending in 2016 and have remained third in Canada, following Ontario and Quebec.</li>
    <li>Canada’s R&D intensity remained at 1.9 percent, below the G7 average (2.6) in 2020. In 2020, B.C.’s R&D spending was 1.7 percent of its GDP, placing it third in Canada.</li>
  </ul>
  ")
  })
  
  
  
  output$consideration <- renderUI({
    HTML("
  <ul style='text-align: justify;'>
    This dashboard was developed under the supervision of the Economic Strategy Branch, Sustainable Economy Division of the Ministry of Jobs, Economic Development and Innovation.
    <br>
    ---
    <br>
    <b>Data Source:</b>
    <li>The information displayed on this dashboard is derived from StatCan's tables:
      <ul>
        <li>Table 27-10-0273-01: Gross Domestic Expenditures on Research and Development, by Science Type and by Funder and Performer Sector</li>
        <li>Table 27-10-0273-02: Expenditures on Research and Development (R&D) by Performing Sector</li>
        <li>Table 27-10-0359-01: Total Domestic Expenditures on Research and Development (R&D) as Percentage of Gross Domestic Product (GDP), Canada and Provinces, and G-7 Countries</li>
      </ul>
    </li>
  </ul>
")
  })
  
  output$source <- renderText({
    "2024 Ministry of Jobs, Economic Development and Innovation, Sustainable Economy Devision. All rights reserved. "
  })
  
  
}

# Run the app
shinyApp(ui = ui, server = server)

