# Main Chart UI----
ui_main_chart <- function(title, chart_name, button_name, source, summary  ){
  fluidPage(
    fluidRow(
      style = "background-color: white; color:black; margin: 40px",
      column(9,
             style = "background-color: #003366; color:white;",
             fluidRow(
               h1(title, style = "margin-left: 45px; font-family: 'Century Gothic'; font-size: 40px; font-weight: bold;")
             ),
             fluidRow(
               plotlyOutput(chart_name)
             ),
             fluidRow(
               column(10, paste0("Source:", source) , style = "margin-left: 45px;"),
               style = "background-color: #003366; height: 100px; display: flex; justify-content: center; align-items: center;",
               tags$style(HTML(".btn-custom {
                          background-color: transparent;
                          border: none;
                          color: white;
                        }
                        .btn-custom .fa-cloud-download-alt {
                          color: white;
                        }
        ")),
               column(2,
                      downloadButton(button_name , label = NULL, class = "btn-custom", icon = icon("cloud-download-alt"))
               )
             )
      ),
      column(3,
             style = "height: 480px; display: flex; align-items: center;",
             div(
               style = "width: 100%; display: flex; justify-content: center;",
               div(
                 style = "background-color: #f0f0f0; border-radius: 15px; padding: 20px; width: 100%;",
                 h3("Summary"),
                 uiOutput(summary)
               )
             )
      )
    )
  )}




# Line Plot ----
dash_lineplot <- function(data_func, df , input, y_label=""){
  df1 <- data_func(df)
  tickvals <- seq(from = 2000, to = max(df1$Year), by = 5)
  
  p1 <- df1 |> 
    plot_ly(x = ~Year, y = ~VALUE, type = 'scatter', mode = 'lines',
            line = list(color = "#FEB70D", width = 4)) |>
    layout(xaxis = list(
      title = "",
      tickvals = tickvals,
      ticktext = tickvals,
      rangeslider = list(
        visible = T,
        thickness = 0.02,  
        bgcolor = "white"  
      ),
      tickfont = list(color = "white"),
      showgrid = FALSE,
      gridcolor = "white"
    ),
    yaxis = list(
      title = y_label,
      titlefont = list(color = "white"), 
      tickfont = list(color = "white"),
      gridcolor = "white"
    ),
    annotations = list(
      list(
        x = df1$Year[1],
        y = df1$VALUE[1],
        text = paste(format(df1$VALUE[1], big.mark=",")),
        showarrow = TRUE,
        arrowcolor = "white",
        font = list(color = "white")
      ),
      list(
        x = df1$Year[length(df1$Year)],
        y = df1$VALUE[length(df1$VALUE)],
        text = paste(format(df1$VALUE[length(df1$VALUE)], big.mark=","), "\n" , "<span style='font-size:7px;'>(" , df1$Year[length(df1$VALUE)], ")", "</span>"),
        showarrow = TRUE,
        arrowcolor = "white",
        font = list(color = "white")
      )
    ),
    plot_bgcolor = 'rgba(0,0,0,0)',  
    paper_bgcolor = 'rgba(0,0,0,0)'  
    )
  validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
  
  p1 <- ggplotly(p1)
  return(p1)
  
}


## Summary number----
get_growth_arrow <- function(value) {
  if (value > 0) {
    return(HTML("<span style='color:#2ecc71;font-size:36px;'>&#9650;</span>"))  # Upward triangle
  } else if (value < 0) {
    return(HTML("<span style='color: #e74c3c;font-size:36px; '>&#9660;</span>"))  # Downward triangle
  } else {
    return(HTML("<span style='color:#f1c40f; font-size:36px; '>&#8213;</span>"))  
  }
}

Extract_Status <- function(df, input){
  most_recent_value <- df$VALUE[nrow(df)]
  most_recent_year <- df$Year[nrow(df)]
  previous <- df$VALUE[nrow(df) - 1]
  growth <- round((most_recent_value - previous) / previous * 100,1)
  abs_growth <- abs(growth)
  
  
  HTML(paste(HTML(paste("<span style='font-size: larger;'><b>" , get_growth_arrow(growth), "</b></span>")),
             HTML(paste("<span style='font-size: larger;'><i>", most_recent_value, "</i></span>")),
             HTML(paste("<span style='font-size: large;'><i>", input, "</i></span>")),
             HTML(paste("<span style='font-size: small;'><i>", "in", most_recent_year, "</i></span>"))
             
  # HTML(
  #   paste(
  #     HTML(paste("<span style='font-size: larger;'><b>", most_recent_value," ", "</b></span>")),
  #     HTML(paste("<span style='font-size:  large;'><b>", input, "</b></span>" )),
  #     HTML(paste("<span style='font-size: larger;'><b>", get_growth_arrow(growth))),
  #     HTML(paste("<span style='font-size: small;'><i>", "in", most_recent_year, "</i></span>"))
             
             ))
}


# actionButton("m6_RnD_Button",
#              label = HTML(Extract_Status(df_m6_RnD, "Million Dollars")),
#              style = style1),
# "Investment in Innovation"
# ),




# Mission Homepage UI----
# # mission-homepage-ui("m6_home", "Fostering Innovation Across the Economy")
# mission-homepage-ui <- function(tabname, maintitle,  ){
#   tabItem(tabName = tabname,
#     fluidPage(
#     ## design----  
#     tags$head(
#       tags$style(HTML("
#         .main-title {
#           font-weight: bold;
#           color: black;
#           font-size: 40px;
#           text-align: center;
#           margin-top: 20px;
#           margin-bottom: 20px;
#         }
#         .custom-box {
#           background-color: #f2f2f2;
#           border-left: 16px solid #FEB70D;
#           padding: 10px;
#           margin-bottom: 20px; /* Space between rows of boxes */
#           height: 220px; /* Increased height to accommodate labels */
#           position: relative; /* Positioning context for absolute positioning */
#         }
#         .custom-title {
#           font-weight: bold;
#           text-align: center;
#           margin-bottom: 30px; /* Space below the title */
#           cursor: pointer; /* Change cursor to pointer on hover */
#           color: black; 
#           text-decoration: none; /* Remove default underline */
#           line-height: 1.5;
#         }
#         .custom-title:hover {
#           text-decoration: underline; /* Underline on hover */
#         }
#         .indicator-content {
#           display: flex;
#           flex-direction: row; /* Align items in a row */
#           align-items: center; /* Align items in the center vertically */
#           justify-content: flex-start; /* Align items to the left */
#           height: 100%; /* Occupy full height */
#           position: relative; /* Positioning context for absolute positioning */
#           bottom:50px;
#           left:25px;
#         }
#         .trend-triangle {
#           width: 15px; /* Smaller width for the triangle */
#           height: 15px; /* Smaller height for the triangle */
#           border-left: 10px solid transparent;
#           border-right: 10px solid transparent;
#           margin-left: 5px; /* Space to the left of the triangle */
#           position: absolute; /* Positioning context within .indicator-content */
#           top: 35%; /* Adjust vertical position to center */
#           transform: translateY(-50%); /* Center vertically */
#           right: 35px; /* Adjust right position */
#         }
#         .green-triangle {
#           border-bottom: 15px solid #4EA72E; /* Green color for upward trend */
#         }
#         .yellow-triangle {
#           right:30px;
#           border-left: 15px solid #FEB70D; /* Yellow color for neutral trend */
#           border-top: 10px solid transparent;
#           border-bottom: 10px solid transparent;
#         }
#         .red-triangle {
#           border-top: 15px solid #E97132; /* Red color for downward trend */
#         }
#         .year-label {
#           font-weight: bold;
#           font-size: 18px; /* Larger font size for the year */
#           position: absolute; /* Positioning context within .indicator-content */
#           top: 35%; /* Adjust vertical position to center */
#           transform: translateY(-50%); /* Center vertically */
#           right: 60px; /* Adjust right position */
#         }
#         .plot-container {
#           width: 90%; /* Adjust width of plot container */
#           position: relative; /* Ensure position is relative for child elements */
#         }
#       "))
#     ),
#     ## ui----
#     div(
#       class = "main-title", maintitle
#     ),
#     div(style = "height: 20px;"),  
#     fluidRow(
#       column(width = 4,
#              div(
#                class = "custom-box",
#                tags$a(href = "https://example.com/indicator1", class = "custom-title",
#                       h4("Private Sector Investment in Innovation", class = "custom-title")),
#                div(class = "indicator-content",
#                    plotOutput("line_chart1", height = "100px", width = "70%"),  # Plot output directly in the box
#                    div(class = "year-label", "2023"),
#                    div(class = "trend-triangle green-triangle")
#                )
#              )
#       ),
#       column(width = 4,
#              div(
#                class = "custom-box",
#                tags$a(href = "https://example.com/indicator2", class = "custom-title",
#                       h4("Labour Productivity", class = "custom-title")),
#                div(class = "indicator-content",
#                    plotOutput("line_chart2", height = "150px", width = "70%"),  # Plot output directly in the box
#                    div(class = "year-label", "2023"),
#                    div(class = "trend-triangle yellow-triangle")
#                )
#              )
#       ),
#       column(width = 4,
#              div(
#                class = "custom-box",
#                tags$a(href = "https://example.com/indicator3", class = "custom-title",
#                       h4("Value-Added Goods and Services Exports", class = "custom-title")),
#                div(class = "indicator-content",
#                    plotOutput("line_chart3", height = "130px", width = "70%"),  # Plot output directly in the box
#                    div(class = "year-label", "2023"),
#                    div(class = "trend-triangle green-triangle")
#                )
#              )
#       )
#     ),
#     div(style = "height: 20px;"),  # Space between first and second rows of boxes
#     fluidRow(
#       column(width = 4,
#              div(
#                class = "custom-box",
#                tags$a(href = "https://example.com/indicator4", class = "custom-title",
#                       h4("Non-residential Investments", class = "custom-title")),
#                div(class = "indicator-content",
#                    plotOutput("line_chart4", height = "150px", width = "70%"),  # Plot output directly in the box
#                    div(class = "year-label", "2023"),
#                    div(class = "trend-triangle green-triangle")
#                )
#              )
#       ),
#       column(width = 4,
#              div(
#                class = "custom-box",
#                tags$a(href = "https://example.com/indicator5", class = "custom-title",
#                       h4("Exports Share", class = "custom-title")),
#                div(class = "indicator-content",
#                    plotOutput("line_chart5", height = "150px", width = "70%"),  # Plot output directly in the box
#                    div(class = "year-label", "2023"),
#                    div(class = "trend-triangle red-triangle")
#                )
#              )
#       )
#     )
#     )
#   )}