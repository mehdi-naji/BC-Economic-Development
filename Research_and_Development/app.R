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
ui <- fluidPage(
  
  # Title
  titlePanel("Shiny App with 5 Boxes"),
  
  # Layout
  fluidRow(
    # First column with line plot
    column(6,
           plotlyOutput("line_plot"),
           fluidRow(
             column(4,
                    selectInput("geo", "GEO", choices = unique(df$GEO)), style = "font-size: 12px"),
             column(4,
                    selectInput("prices", "Prices", choices = unique(df$Prices)), style = "font-size: 12px"),
             column(4,
                    selectInput("science_type", "Science Type", choices = unique(df$Science.type)), style = "font-size: 12px")
           ),
           fluidRow(
             column(6,
                    selectInput("funder", "Funder", choices = unique(df$Funder)), style = "font-size: 12px;"),
             column(6,
                    selectInput("performer", "Performer", choices = unique(df$Performer)), style = "font-size: 12px")
           )
    ),
    column(6,
           plotlyOutput("sankey_diagram"))
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
  
  sankey_data <- reactive({
    df |>
      filter(GEO == input$geo,
             Science.type == input$science_type,
             Prices == input$prices,
             Funder != "Funder: total, all sectors",
             Performer != "Performer: total, all sectors") 
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
  
  
  # Render the Sankey diagram
  output$sankey_diagram <- renderPlotly({
    df1 <- sankey_data()
    df1 <- df1 |> filter (Funder != "Funder: total, all sectors",
                          Performer != "Performer: total, all sectors")
    nodes <- data.frame(name = c(as.character(df1$Funder), as.character(df1$Performer)))
    nodes <- unique(nodes)
    links <- data.frame(source = match(df1$Funder, nodes$name) - 1,
                        target = match(df1$Performer, nodes$name) - 1,
                        value = df1$VALUE)
    node_colors <- c("Funder: total, all sectors" = "grey",
                     "Funder: federal government sector" = "red", 
                     "Funder: provincial governments sector" = "orange", 
                     "Funder: provincial research organizations sector" = "yellow",
                     "Funder: business enterprise sector" = "green",
                     "Funder: higher education sector" = "violet", 
                     "Funder: private non-profit sector" = "blue", 
                     "Funder: foreign sector" = "brown", 
                     "Performer: total, all sectors" = "grey",
                     "Performer: federal government sector" = "red", 
                     "Performer: provincial governments sector" = "orange", 
                     "Performer: provincial research organizations sector" = "yellow",
                     "Performer: business enterprise sector" = "green",
                     "Performer: higher education sector" = "violet", 
                     "Performer: private non-profit sector" = "blue")
    
    
    nodes$color <- node_colors[nodes$name]
    
    
    
    # Use the colors vector for the color attribute
    fig <- plot_ly(
      type = "sankey",
      domain = list(
        x = c(0,1),
        y = c(0,1)
      ),
      orientation = "h",
      valueformat = ".0f",
      valuesuffix = "TWh",
      node = list(
        label = nodes$name,
        color = nodes$color,  # Use the node_colors vector here
        pad = 15,
        thickness = 20,
        line = list(
          color = "grey",
          width = 0.5
        )
      ),
      link = list(
        source = links$source,
        target = links$target,
        value = links$value
      )
    ) 
    
    fig <- fig %>% layout(
      title = "Sankey Diagram",
      font = list(
        size = 10
      )
    )
    
    fig
  })
  
  # Render the text boxes
  
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

