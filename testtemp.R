library(shiny)
library(shinydashboard)
library(plotly)

ui <- dashboardPage(
  dashboardHeader(title = "Icon on Chart Example"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    # Link to the external CSS file
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
    ),
    fluidRow(
      box(
        width = 12,
        div(
          class = "plot-container",
          div(
            class = "icon-container",
            icon("chart-bar", "fa-4x")
          ),
          plotlyOutput("plot")
        )
      )
    )
  )
)

server <- function(input, output) {
  output$plot <- renderPlotly({
    plot_ly(
      data = mtcars,
      x = ~mpg,
      y = ~wt,
      type = 'scatter',
      mode = 'markers'
    )
  })
}

shinyApp(ui, server)
