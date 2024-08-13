library(shiny)
library(ggplot2)

# Define UI for the Shiny app
ui <- fluidPage(
  tags$style(HTML("
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            height: 100vh;
        }
        #main-chart-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 30vh; /* Adjust the height according to your preference */
            background-color: #003366; /* Main chart background color */
            z-index: 10;
            display: flex;
            align-items: center;
            padding: 20px;
            box-sizing: border-box;
            color: white;
        }
        #main-chart {
            flex: 3;
            text-align: center;
        }
        #main-chart-info {
            flex: 1;
            background-color: #004080; /* Adjust as needed */
            padding: 20px;
            box-sizing: border-box;
            height: 100%;
            overflow-y: auto;
        }
        #deep-dive-section {
            margin-top: 30vh; /* Same as main chart height */
            display: flex;
            height: 70vh;
        }
        #deep-dive-charts {
            flex: 1;
            overflow-y: scroll;
            padding: 20px;
            background-color: #f4f4f4; /* Background for the deep-dive charts section */
        }
        .deep-dive-chart {
            margin-bottom: 20px;
            padding: 20px;
            background-color: white;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        #info-box {
            width: 300px;
            background-color: #eaeaea;
            padding: 20px;
            box-shadow: -2px 0 10px rgba(0, 0, 0, 0.1);
            position: fixed;
            top: 30vh; /* Below the main chart */
            right: 0;
            height: 70vh; /* Match the deep-dive section height */
            overflow-y: auto;
        }
    ")),
  
  # Main chart output
  tags$div(
    id = "main-chart-container",
    tags$div(
      id = "main-chart",
      plotOutput("main_chart")
    ),
    tags$div(
      id = "main-chart-info",
      h2("Explanation"),
      p("This is a brief explanation of the main indicator chart.")
    )
  ),
  
  # Deep-dive charts and information box
  tags$div(
    id = "deep-dive-section",
    tags$div(
      id = "deep-dive-charts",
      div(
        class = "deep-dive-chart",
        h2("Deep-Dive Chart 1"),
        plotOutput("deep_dive_chart1")
      ),
      div(
        class = "deep-dive-chart",
        h2("Deep-Dive Chart 2"),
        plotOutput("deep_dive_chart2")
      ),
      div(
        class = "deep-dive-chart",
        h2("Deep-Dive Chart 3"),
        plotOutput("deep_dive_chart3")
      )
    ),
    tags$div(
      id = "info-box",
      h2("Information Box"),
      p("Detailed information about the deep-dive charts.")
    )
  )
)

# Define server logic required to draw charts
server <- function(input, output) {
  # Main chart
  output$main_chart <- renderPlot({
    ggplot(mpg, aes(displ, hwy)) +
      geom_point() +
      ggtitle("Main Indicator Chart") +
      theme_minimal() +
      theme(
        plot.background = element_rect(fill = "#003366", color = NA),
        plot.title = element_text(color = "white", size = 16, face = "bold"),
        axis.text = element_text(color = "white"),
        axis.title = element_text(color = "white")
      )
  })
  
  # Deep-dive charts
  output$deep_dive_chart1 <- renderPlot({
    ggplot(mpg, aes(class, hwy)) +
      geom_boxplot() +
      ggtitle("Deep-Dive Chart 1")
  })
  
  output$deep_dive_chart2 <- renderPlot({
    ggplot(mpg, aes(manufacturer, cty)) +
      geom_bar(stat = "identity") +
      ggtitle("Deep-Dive Chart 2")
  })
  
  output$deep_dive_chart3 <- renderPlot({
    ggplot(mpg, aes(year, hwy)) +
      geom_line() +
      ggtitle("Deep-Dive Chart 3")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
