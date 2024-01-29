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
url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/VA_Exporsts_1.csv"
df <- read.csv(url, header = TRUE)
df <- na.omit(df)


# Static inputs ----
modal_title1 <- "Private sector investment in innovation"
modal_text1 <- paste("The amount spent on research and development by the business enterprise sector (not adjusted for inflation) in") 
modal_title2 <- "Value-added exports"
modal_title3 <- "Non-residential structures, machinery and equipment and IP investment as share of GDP"
modal_title4 <- "Labour Productivity"
modal_title5 <- "Exports as % of GDP"

# User Interface -----
## ui_components ----
### line plot ----
ui_lineplot <- column(6,plotlyOutput("line_plot"))

### barplot ----
ui_barplot <- column(7, plotlyOutput("barplot"))

### Pie Chart ----
ui_pie <- column(5,plotlyOutput("pie"))

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
      tags$span("Value-added in Goods & Services Exports", style = " color: black;font-size: 130%; "),
      href='https://strongerbc.shinyapps.io/research_and_development/',
    ),titleWidth = 700
  ),
  dashboardSidebar(
    collapsed = TRUE,
    sidebarMenu(
      menuItem("Inputs", tabName = "inputs", icon = icon("dashboard")),
        selectInput("geo", "Region", choices = unique(df$GEO), selected = "British Columbia"), 
        selectInput("industry", "Industry", choices = unique(df$Industry), selected = "Total industries"), 
        selectInput("year", "Year", choices = unique(df$Year), selected = 2019)
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
      ui_pie, ui_barplot),
    fluidPage(
      textOutput("source")
    )
    ))


# Server ----
server <- function(input, output, session) {

# Data ----
## line plot data----  
  line_plot_data <- reactive({
    df %>%
      filter(GEO == input$geo,
             Industry == "Total industries")
  })

## bar line data----  
  filtered_data_bar <- reactive({
    df |> 
      filter (Year == input$year,
              Industry == input$industry)|>
      mutate (EXP_GDP = 100 * VA_EXP / (GDP*1000))
    })

## Pie Chart data----
  pie_data <- reactive({
    df |>
      filter(Industry != "Total industries",
             GEO == input$geo,
             Year == input$year)
  })

# Rendering ----

  # output$title <- renderText({
  #   if (input$funder == " business enterprise sector") {
  #     "Private Sector Investment in Innovation"
  #   } else if (input$funder == " federal government sector") {
  #     "Federal Government Investment in Innovation"
  #   } else if (input$funder == " provincial governments sector") {
  #     "Provincial Government Investment in Innovation"
  #   } else if (input$funder == " provincial research organizations sector") {
  #     "Provincial Research Organizations Investment in Innovation"
  #   } else if (input$funder == " foreign sector") {
  #     "Foreign Investment in Innovation"
  #   } else if (input$funder == " higher education sector") {
  #     "Higher Education Investment in Innovation"
  #   } else {"Investment in Innovation"}
  # })
  
## line plot ----
  output$line_plot <- renderPlotly({
    df1 <- line_plot_data()
    p1 <- df1 |> 
            plot_ly(x = ~Year, y = ~VA_EXP*1000, type = 'scatter', mode = 'lines') |>
            layout(title = list(text = paste("Value-added Exports in", input$geo)),
                   xaxis = list(
                     title = "", 
                     rangeslider = list(
                       visible = T,
                       thickness = 0.03,  
                       bgcolor = "darkgrey"  
                     )
                   ),
             yaxis = list(title = paste ("$ ")))
  validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
    
  p1 <- ggplotly(p1)
  })   
  
  
  ## Pie Chart diagram ----
  output$pie <- renderPlotly({
    df1 <- pie_data()
    sorted_data <- df1 |>
      arrange(desc(VA_EXP))

    # Create a pie chart
    fig <- plot_ly(sorted_data, labels = ~Industry, values = ~VA_EXP, type = 'pie', textposition = 'inside')
    fig <- fig %>% layout(showlegend = FALSE)
    fig <- fig %>% layout(title = paste("Industries Value Added in", input$geo), showlegend = FALSE)
    
    
    fig
      })
  
  # Render the text boxes
  
  output$text_box_2 <- renderText({
    paste("This is the second text box.")
  })
  

  ## bar plot ----
  output$barplot <- renderPlotly({
    df2 <- filtered_data_bar()
    df2$GEO <- reorder(df2$GEO, df2$EXP_GDP)
    df2$formatted_VALUE <- sprintf("%.2f%%", df2$EXP_GDP)
    df2$adjusted_VALUE <- df2$EXP_GDP + max(df2$EXP_GDP) / 10
    p2 <- df2 |>
      plot_ly(x = ~EXP_GDP, y=~GEO, color=~GEO, type = 'bar',
              showlegend = FALSE)  |>
      add_text(x = ~adjusted_VALUE,text = ~formatted_VALUE, textposition = 'outside') |>
      layout(title = paste("Value added in Exports as Percent of GDP in", input$year),
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

