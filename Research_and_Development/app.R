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


url_GDPEMPL <- "https://github.com/mehdi-naji/BC-Econ-Dashboard/raw/main/data/processed/GDPEMPL_Industry_dash.csv"

df <- read.csv(url_GDPEMPL, header = TRUE)

dff <- na.omit(df)

# User Interface -----

library(shiny)
library(ggplot2)

# Define the UI
ui <- fluidPage(
  # Title
  titlePanel("Shiny App with 5 Boxes"),
  
  # Layout
  fluidRow(
    # First column with line plot and inputs
    column(6,
           plotOutput("line_plot"),
           selectInput("geo", "GEO", choices = unique(df1$GEO)),
           radioButtons("funder", "Funder", choices = unique(df1$Funder)),
           radioButtons("performer", "Performer", choices = unique(df1$Performer)),
           radioButtons("science_type", "Science Type", choices = unique(df1$Science_Type)),
           selectInput("prices", "Prices", choices = unique(df1$Prices)),
           sliderInput("year_range", "Year range", min = min(df1$Year), max = max(df1$Year), value = c(min(df1$Year), max(df1$Year)))
    ),
    # Second column with text box
    column(6,
           textOutput("text_box_1")
    )
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
    df1 %>%
      filter(GEO == input$geo,
             Funder == input$funder,
             Performer == input$performer,
             Science_Type == input$science_type,
             Prices == input$prices,
             Year >= input$year_range[1],
             Year <= input$year_range[2])
  })
  
  # Render the line plot
  output$line_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = Year, y = VALUE)) +
      geom_line() +
      labs(title = "Line Plot of VALUE over Year",
           x = "Year",
           y = "VALUE")
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

