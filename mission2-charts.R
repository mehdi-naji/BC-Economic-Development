# Loading data----
          ## NBO----
          load_m2_NBO1 <- function() {
            url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/New_Business_Openings_1.csv"
            df <- read.csv(url, header = TRUE)
            df <- na.omit(df)
            return(df)
          }
          ## HA----
          load_m2_HA1 <- function() {
            url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Housing_Availability_1.csv"
            df <- read.csv(url, header = TRUE)
            df <- na.omit(df)
            return(df)
          }
          ## LMPR----
          load_m2_LMPR1 <- function() {
            url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Labour_Market_Participation_Rate_1.csv"
            df <- read.csv(url, header = TRUE)
            df <- na.omit(df)
            return(df)
          }            
          ## OVC----
          load_m2_OVC1 <- function() {
            url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Occurance_Violent_Crime_1.csv"
            df <- read.csv(url, header = TRUE)
            df <- na.omit(df)
            return(df)
          }   
          ## GII----
          load_m2_GII1 <- function() {
            url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Government_Investment_Infrastructure_1.csv"
            df <- read.csv(url, header = TRUE)
            df <- na.omit(df)
            return(df)
          }            
          ## PRHC----
          load_m2_PRHC1 <- function() {
            url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Police_Reported_Hate_Crime_1.csv"
            df <- read.csv(url, header = TRUE)
            df <- na.omit(df)
            return(df)
          }            

          
# NBO Dash----
          ## Line plot----
          m2_NBO_lineplot_data <- function(df) {
            df |>
              filter(Industry == "Business sector industries [T004]",
                     Measure == "Entrants")}
          
          m2_NBO_render_lineplot <- function(df, input){
            dash_lineplot(m2_NBO_lineplot_data, df, input)}
          
# HA Dash----
          ## Line plot----
          m2_HA_lineplot_data <- function(df) {
            df }
          
          m2_HA_render_lineplot <- function(df, input){
            dash_lineplot(m2_HA_lineplot_data, df, input)}


# LMPR Dash----
          ## Line plot----
          m2_LMPR_lineplot_data <- function(df) {
            df |>
              filter(GEO == "British Columbia")
          }
          
          m2_LMPR_render_lineplot <- function(df, input){
            dash_lineplot(m2_LMPR_lineplot_data, df, input, y_label="Percent %")}


# OVC Dash----
          ## Line plot----
          m2_OVC_lineplot_data <- function(df) {
            df |>
              filter(GEO == "British Columbia [59]")
          }

          m2_OVC_render_lineplot <- function(df, input){
            dash_lineplot(m2_OVC_lineplot_data, df, input, y_label="Per 100,000 population")}


# GII Dash----
          ## Line plot----
    m2_GII_lineplot_data <- function(df) {
      df }
    
    m2_GII_render_lineplot <- function(df, input){
      dash_lineplot(m2_GII_lineplot_data, df, input, y_label="$ billion")}
    
# PRHC Dash----
          ## Line plot----
    m2_PRHC_lineplot_data <- function(df) {
      df|>
        filter(GEO == "British Columbia")}
    
    m2_PRHC_render_lineplot <- function(df, input){
      dash_lineplot(m2_PRHC_lineplot_data, df, input)}
    
    