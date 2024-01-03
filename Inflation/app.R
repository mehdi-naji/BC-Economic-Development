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
url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Price_Index_1.csv"
df <- read.csv(url, header = TRUE)
df <- na.omit(df)

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
    title = "StrongerBC: Inflation",titleWidth = 450
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Inputs", tabName = "inputs", icon = icon("dashboard")),
        selectInput("geo", "Region", choices = unique(df$GEO)), 
        selectInput("products", "Product Type", choices = unique(df$Products.and.product.groups))
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
             Products.and.product.groups == input$products)
  })

## growth table data----
  

## bar line data----  
  

## sankey plot data----
  

# Rendering ----
## line plot ----
  output$line_plot <- renderPlotly({
    df1 <- filtered_data()
    p1 <- df1 |> 
            plot_ly(x = ~YearMonth, y = ~VALUE, type = 'scatter', mode = 'lines')
  #   |>
  #           layout(title = list(text = paste("Research and Development in <b>" , 
  #                                input$science_type, "</b>", 
  #                                " in <b>",input$geo , "</b>",
  #                                "\n", "Funder:<b>", input$funder, "</b>", 
  #                                "\n", "Performer:<b>", input$performer, "</b>"),
  #                               x=0.1, y=0.78,font = list(size = 14)),
  #                  xaxis = list(
  #                    title = "", 
  #                    rangeslider = list(
  #                      visible = T,
  #                      thickness = 0.02,  
  #                      bgcolor = "darkgrey"  
  #                    )
  #                  ),
  #            yaxis = list(title = paste ("million $ (", "<b>", input$prices, "</b>)")))
  # validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
  #   
  p1 <- ggplotly(p1)
  })   
  
  
  ## Sankey diagram ----
  
  
  # Render the text boxes
  

  
  ## growth table ----
  # output$table <- DT::renderDataTable({
  #   data <- filtered_data_growth()
  #   DT::datatable(data, options = list(dom = 't'), escape = FALSE, rownames = FALSE, 
  #                 caption = htmltools::tags$caption(style = "caption-side: top; font-size: 130%;", 
  #                                                   "Research and Development Spending Growth"))
  # })


  
  ## bar plot ----
  # output$barplot <- renderPlotly({
  #   my_colors <- c("#ea5545", "#f46a9b", "#ef9b20", "#edbf33",
  #                  "#ede15b", "#bdcf32", "#87bc45", "#27aeef",
  #                  "#b33dc6", "#e60049", "#50e991")
  # 
  #   df2 <- filtered_data_bar()
  #   
  #   df2$color <- my_colors[df2$GEO]
  #   p2 <- df2 |> 
  #     plot_ly(y = ~VALUE, color=~GEO, type = 'bar',marker = list(color = ~color))  |>
  #     layout(title = paste("Research and Development as percentage of GDP \n in", input$year),
  #            xaxis = list(title = "", showticklabels = FALSE),
  #            yaxis = list(title = "Percent"),
  #            legend = list(orientation = "h"),
  #            bargroupgap = 0.2)
  # 
  #   validate(need(nrow(df2) > 0, "The data for this year is inadequate. To obtain a proper visualization, please modify the year selection in the sidebar."))
  #   return(p2)
  # })
  # 
  
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

