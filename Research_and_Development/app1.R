# Load the shiny and shinydashboard packages
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(
    title = tags$a(
      tags$img(src='https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/main/logo.png', height='40', width='200', style="padding-left: 25px;float: left;") , 
      tags$span("Research and Development", style = " color: black;font-size: 130%; "),
      href='https://strongerbc.shinyapps.io/research_and_development/',
    ),titleWidth = 600
  ),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    tags$style(HTML("
      .skin-blue .main-header .navbar, 
      .skin-blue .main-header .logo,
      .skin-blue .main-header .logo:hover,
      .skin-blue .content-header, 
      .skin-blue .wrapper, 
      .content-wrapper, 
      .right-side   { 
                      background-color: white; 
                      color: black;
      }
      .box.box-solid.box-success>.box-header {
                      color: #00a65a;
                      background: white;
      }
      .box.box-solid.box-success {
                      border: 1px solid #00a65a;
      }
      .box-title {
                      font-size: 18px;
                      font-weight: bold;
                      color: #00a65a;
      }
      .special-box>.box-header .box-title {
                      color: white;
                      font-size: 20px;
      }
    ")),
    tags$style(type="text/css",
               ".shiny-output-error-validation {
     font-size: 15px;
    }"
    ),
    fluidPage(
      h3(textOutput("title"))
    ),
    fluidRow(
      box(width = 5, height = 400),
      box(width = 2, height = 400 ,title = "Box Title", "Short text", tags$h2("$3.028 billion")),
      box(width = 2, height = 400 ,title = "Private sector investment in innovation", "$3.028 billion"),
      box(width = 2, height = 400 ,title = "Private sector investment in innovation", "$3.028 billion"),
      box(width = 1, height = 400 ,background = "green")
      ),
    fluidRow(
      box(width = 5, height = 400, title = "Fostering Innovation Across Economy", background = "green", class = "special-box"),
      box(width = 3, height = 400, title = "Private sector investment in innovation", "$3.028 billion"),
      box(width = 3, height = 400, title = "Private sector investment in innovation", "$3.028 billion"),
      box(width = 1, height = 400)
    )
    )
  
)

server <- function(input, output) {
}

# Run the shiny app
shinyApp(ui = ui, server = server)
