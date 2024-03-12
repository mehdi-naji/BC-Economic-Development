# Loading data----

## UR----
load_m1_UR1 <- function() {
  url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Unemployment_Rate_1.csv"
  df <- read.csv(url, header = TRUE)
  df <- na.omit(df)
  return(df)
}

load_m1_UR2 <- function() {
  url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Unemployment_Rate_2.csv"
  df <- read.csv(url, header = TRUE)
  df <- na.omit(df)
  return(df)
}

load_m1_UR3 <- function() {
  url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Unemployment_Rate_3.csv"
  df <- read.csv(url, header = TRUE)
  df <- na.omit(df)
  return(df)
}

# UR Dash----
    ## Line plot----
        m1_UR_lineplot_data <- function(df, geo, character, age, sex) {
          df |>
            filter(GEO == geo,
                   `Labour force characteristics` == character,
                   `Age group` == age,
                   Sex == sex)
        }
        
        m1_UR_render_lineplot <- function(df, input){
          df1 <- m1_UR_lineplot_data(df, input$m1_UR_lineplot_geo, input$m1_UR_lineplot_character, input$m1_UR_lineplot_age, input$m1_UR_lineplot_sex)
          p1 <- df1 |> 
            plot_ly(x = ~Year, y = ~VALUE, type = 'scatter', mode = 'lines') |>
            layout(xaxis = list(
              title = "", 
              rangeslider = list(
                visible = T,
                thickness = 0.02,  
                bgcolor = "darkgrey"  
              )
            ))
          validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
          
          p1 <- ggplotly(p1)
          return(p1)
          
        }
