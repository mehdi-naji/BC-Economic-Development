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

load_m1_UR4 <- function() {
  url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Unemployment_Rate_4.csv"
  df <- read.csv(url, header = TRUE)
  df <- na.omit(df)
  return(df)
}

# UR Dash----
    ## Line plot----
        m1_UR_lineplot_data <- function(df, geo, character, age, sex) {
          df |>
            filter(GEO == geo,
                   Character == character,
                   Age == age,
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

        ## Waffle plot----
        m1_UR_waffle_data <- function(df, year, geo) {
          df |>
            filter(
              GEO == geo, 
              Year == year)
        }

        m1_UR_render_waffle <- function(df, input){
          df1 <- m1_UR_waffle_data(df, input$m1_UR_waffle_year, input$m1_UR_waffle_geo)
          df1[is.na(df1)] <- 0

          wide_df1 <- pivot_wider(
            data = df1,
            names_from = Sex,
            values_from = VALUE,
            values_fill = 0
          )

          colors <- c('Males' = "#FFA500", 'Females' = "#4384FF")

          waffle_charts <- list()
          for (geo in unique(wide_df1$GEO)) {
            for (reason in unique(wide_df1$Reason)) {
              Males <-  wide_df1[wide_df1$GEO == geo & wide_df1$Reason == reason, ]$Males
              Females <-  wide_df1[wide_df1$GEO == geo & wide_df1$Reason == reason, ]$Females
              total <- ifelse(Males + Females == 0, 1,Males + Females)

              parts <- c('Males' = as.integer(round((Males / total) * 25)), 
                         'Females' = as.integer(round((Females / total) *25)))

              waffle_chart <- waffle(parts, rows = 5, colors = colors, size = 1.0) +
                theme(legend.position = "none")+
                labs(
                  y = ifelse(reason == unique(wide_df1$Reason)[1], geo, ""),
                  x = ifelse(geo == unique(wide_df1$GEO)[length(unique(wide_df1$GEO))], reason, "")
                )


              waffle_charts[[length(waffle_charts) + 1]] <- waffle_chart
            }
          }

          
          # validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
          p1 <- grid.arrange(grobs = waffle_charts, ncol = 7)
          return(p1)
        }
        
        ## Tree Map----
        
        m1_UR_treemap_data <- function(df, geo, year, character){
          df |>
            filter(GEO == geo,
                   Year == year,
                   Labour.force.characteristics == character)
          }
        
        m1_UR_render_treemap <- function(df, input){
          df2 <- m1_UR_treemap_data(df, input$m1_UR_treemap_geo, input$m1_UR_treemap_year, input$character)
          p <- df2 |>
            plot_ly(
              type = 'treemap',
              labels = ~NAICS,
              values = ~VALUE)
          validate(need(nrow(df2) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
          p}
