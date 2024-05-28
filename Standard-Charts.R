# Line Plot ----
dash_lineplot <- function(data_func, df , input, y_label=""){
  df1 <- data_func(df)
  p1 <- df1 |> 
    plot_ly(x = ~Year, y = ~VALUE, type = 'scatter', mode = 'lines') |>
    layout(xaxis = list(
      title = "",
      tickvals = df1$Year,
      ticktext = df1$Year,
      rangeslider = list(
        visible = T,
        thickness = 0.02,  
        bgcolor = "darkgrey"  
      )
    ),
    yaxis = list(
      title = y_label
    ),
    annotations = list(
      list(
        x = df1$Year[1],
        y = df1$VALUE[1],
        text = paste("  ", format(df1$VALUE[1], big.mark=",")),
        showarrow = TRUE
      ),
      list(
        x = df1$Year[length(df1$Year)],
        y = df1$VALUE[length(df1$VALUE)],
        text = paste("     ", format(df1$VALUE[length(df1$VALUE)], big.mark=",")),
        showarrow = TRUE
      )
    )
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
    return("")  
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


