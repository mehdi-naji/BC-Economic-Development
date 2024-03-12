# Loading data----

## GII----
load_m2_GII1 <- function() {
  url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Government_Investment_Infrastructure_1.csv"
  df <- read.csv(url, header = TRUE)
  df <- na.omit(df)
  return(df)
}

# GII Dash----
    ## Line plot----
    m2_GII_lineplot_data <- function(df, geo, prices, industry, asset) {
      df |>
        filter(GEO == geo,
               Prices == prices,
               Purchasing.industry == industry,
               Asset.function == asset)
      }
    
    m2_GII_render_lineplot <- function(df, input){
      df1 <- m2_GII_lineplot_data(df, input$m2_GII_lineplot_geo, input$m2_GII_lineplot_prices, input$m2_GII_lineplot_industry, input$m2_GII_lineplot_asset)
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
        yaxis = list(title = paste ("Million Dollars")))
      validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
      
      p1 <- ggplotly(p1)
      return(p1)
    
    }
