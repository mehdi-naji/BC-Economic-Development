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

options(shiny.autoreload = TRUE)

# Downloading processed data
url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Research_and_Development_1.csv"
df <- read.csv(url, header = TRUE)
df <- na.omit(df)

# User Interface -----

library(shiny)
library(ggplot2)

# Define the UI
ui <- fluidPage(
  # Title
  titlePanel("Shiny App with 5 Boxes"),
  
  # Layout
  fluidRow(
    # First column with line plot
    column(4,
           plotlyOutput("line_plot")
    ),
    # Second column with inputs
    column(2,
           selectInput("geo", "GEO", choices = unique(df$GEO)),
           selectInput("funder", "Funder", choices = unique(df$Funder)),
           selectInput("performer", "Performer", choices = unique(df$Performer)),
           selectInput("science_type", "Science Type", choices = unique(df$Science.type)),
           selectInput("prices", "Prices", choices = unique(df$Prices)),
    ),
    column(6,
           textOutput(("text_box_1")))
  ),
  fluidRow(
    # Third column with text box
    column(4,
           textOutput("text_box_2")
    ),
    # Fourth column with text box
    column(4,
           textOutput("text_box_3")
    ),
    # Fifth column with text box
    column(4,
           textOutput("text_box_4")
    )
  )
)

# Define the server
server <- function(input, output) {
  # Filter the data based on the inputs
  filtered_data <- reactive({
    df %>%
      filter(GEO == input$geo,
             Funder == input$funder,
             Performer == input$performer,
             Science.type == input$science_type,
             Prices == input$prices)
  })
  
  # Render the line plot
  output$line_plot <- renderPlotly({
    df1 <- filtered_data()
    p1 <- df1 |> 
            plot_ly(x = ~Year, y = ~VALUE, type = 'scatter', mode = 'lines') |>
            layout(title = "Time Series with Rangeslider",
             xaxis = list(rangeslider = list(visible = T)))
    
  p1 <- ggplotly(p1)
  })
  
  
  
  # Render the text boxes
  output$text_box_1 <- renderText({
    paste("This is the first text box.")
  })
  
  output$text_box_2 <- renderText({
    paste("This is the second text box.")
  })
  
  output$text_box_3 <- renderText({
    paste("This is the third text box.")
  })
  
  output$text_box_4 <- renderText({
    paste("This is the fourth text box.")
  })
}

# Run the app
shinyApp(ui = ui, server = server)

