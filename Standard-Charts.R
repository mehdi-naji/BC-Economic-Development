# Line Plot ----
dash_lineplot <- function(data_func, df, input){
  df1 <- data_func(df)
  p1 <- df1 |> 
    plot_ly(x = ~Year, y = ~VALUE, type = 'scatter', mode = 'lines') |>
    layout(xaxis = list(
      title = "", 
      rangeslider = list(
        visible = T,
        thickness = 0.02,  
        bgcolor = "darkgrey"  
      )
    ),
    yaxis = list(
      title = ""
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