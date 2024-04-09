# Loading data----

## GII----
load_m2_GII1 <- function() {
  url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Government_Investment_Infrastructure_1.csv"
  df <- read.csv(url, header = TRUE)
  df <- na.omit(df)
  return(df)
}

## NBO----
load_m2_NBO1 <- function() {
  url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/New_Business_Openings_1.csv"
  df <- read.csv(url, header = TRUE)
  df <- na.omit(df)
  return(df)
}

# GII Dash----
    ## Line plot----
    m2_GII_lineplot_data <- function(df) {
      df |>
        filter(GEO == "British Columbia",
               Prices == "Current dollars",
               Purchasing.industry == "Total industries",
               Asset.function == "All functions")
    }
    
    m2_GII_render_lineplot <- function(df, input){
      dash_lineplot(m2_GII_lineplot_data, df, input)}
    
# NBO Dash----
## Line plot----
m2_NBO_lineplot_data <- function(df) {
  df |>
    filter(GEO == "British Columbia",
           Industry == "Business sector industries [T004]",
           Measure == "Entrants")
}

m2_NBO_render_lineplot <- function(df, input){
  dash_lineplot(m2_NBO_lineplot_data, df, input)}
