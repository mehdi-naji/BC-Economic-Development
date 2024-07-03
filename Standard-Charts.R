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


