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
  
  load_m1_UR5 <- function() {
    url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Unemployment_Rate_5.csv"
    df <- read.csv(url, header = TRUE)
    df <- na.omit(df)
    return(df)
  }
  
  
  ## PI----
  load_m1_PI1 <- function() {
    url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Poverty_Incidence_1.csv"
    df <- read.csv(url, header = TRUE)
    df <- na.omit(df)
    return(df)
  }
  
  load_m1_PI2 <- function() {
    url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Poverty_Incidence_2.csv"
    df <- read.csv(url, header = TRUE)
    df <- na.omit(df)
    return(df)
  }
  
  
  
  ## CHN----
  load_m1_CHN1 <- function() {
    url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Core_Housing_Needs_1.csv"
    df <- read.csv(url, header = TRUE)
    df <- na.omit(df)
    return(df)
  }
  ## GC----
  load_m1_GC1 <- function() {
    url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Gini_Coefficient_1.csv"
    df <- read.csv(url, header = TRUE)
    df <- na.omit(df)
    return(df)
  }  
  ## FE----
  load_m1_FE1 <- function() {
    url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Food_Expenditure_1.csv"
    df <- read.csv(url, header = TRUE)
    df <- na.omit(df)
    return(df)
  } 
  ## TS----
  load_m1_TS1 <- function() {
    url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Transportation_Expenditure_1.csv"
    df <- read.csv(url, header = TRUE)
    df <- na.omit(df)
    return(df)
  } 
  
  
  ## MI----
  load_m1_MI1 <- function() {
    url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Median_Income_1.csv"
    df <- read.csv(url, header = TRUE)
    df <- na.omit(df)
    return(df)
  } 
  
  
  ## SB----
  load_m1_SB1 <- function() {
    url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Sense_of_Belonging_1.csv"
    df <- read.csv(url, header = TRUE)
    df <- na.omit(df)
    return(df)
  } 
  
  
  ## LE----
  load_m1_LE1 <- function() {
    url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Life_Expectancy_1.csv"
    df <- read.csv(url, header = TRUE)
    df <- na.omit(df)
    return(df)
  } 
  
  
  ## MH----
  load_m1_MH1 <- function() {
    url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Mental_Health_1.csv"
    df <- read.csv(url, header = TRUE)
    df <- na.omit(df)
    return(df)
  } 
  
  
# UR Dash----
    ## Line plot----
        m1_UR_lineplot_data <- function(df) {
         df |>
            filter(GEO == "British Columbia",
                   Reason %in% c("Business conditions, did not look for full-time work in last month",
                                 "Business conditions, looked for full-time work in last month",
                                 "Could not find full-time work, looked for full-time work in last month"
                                 ),
                   Age == "15 years and over",
                   Sex == "Both sexes") |>
            group_by(Year) |>
            summarise(VALUE = sum(VALUE)) |>
           left_join(df |> filter(Reason == "Part-time employment, all reasons",
                                   GEO == "British Columbia",
                                   Age == "15 years and over",
                                   Sex == "Both sexes"
                                   ),
                     by = "Year") |>
           mutate(VALUE = (VALUE.x / VALUE.y) * 100,
                  VALUE = round(VALUE,1))|>
           select(Year, VALUE)
        }
        
        m1_UR_render_lineplot <- function(df, input){
            dash_lineplot(m1_UR_lineplot_data, df, input, "Percentage")} 

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

      
      validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
      p1 <- grid.arrange(grobs = waffle_charts, ncol = 7)
      return(p1)
    }
    
    ## Tree Map----
    
    m1_UR_treemap_data <- function(df, geo, year, character){
      df |>
        filter(GEO == geo,
               Year == year,
               Character == character)
      }
    
    m1_UR_render_treemap <- function(df, input){
      df2 <- m1_UR_treemap_data(df, input$m1_UR_treemap_geo, input$m1_UR_treemap_year, input$m1_UR_treemap_character)
      p <- df2 |>
        plot_ly(
          type = 'treemap',
          labels = ~NAICS,
          parents = "Industry",
          values = ~VALUE)
      validate(need(nrow(df2) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
      return(p)
      }

    
    ## Heat Map----
    
    m1_UR_heatmap_data <- function(df, geo, year, character){
      df |>
        filter(GEO == geo,
               Year == year,
               Character == character,
               Sex != "Both sexes",
               Age != "15 years and over")
    }
    
    m1_UR_render_heatmap <- function(df, input){
      df2 <- m1_UR_heatmap_data(df, input$m1_UR_heatmap_geo, input$m1_UR_heatmap_year, input$m1_UR_heatmap_character)
      p1 <- plot_ly(
        data = df2,
        x = ~Age,
        y = ~Sex,
        z = ~VALUE,
        type = "heatmap",
        colorscale = "Plasma" )
      validate(need(nrow(df2) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
      
      p1
    }
      
      
      
      
      

    
    
# PI Dash----
    ## Line plot----
    m1_PI_lineplot_data <- function(df) {
      df |>
        filter(GEO == "British Columbia",
               PersonsType == "All persons",
               IncomeLine == "Market basket measure, 2018 base",
               Statistics == "Percentage of persons in low income"
        )
         
    }
    
    m1_PI_render_lineplot <- function(df, input){
      dash_lineplot(m1_PI_lineplot_data, df, input, "Percentage")}
    
    ## GB : Gender Bias----
    m1_PI_GB_data <- function(df, geo, year) {
      df |>
        filter(GEO == geo,
               Year == year,
               Age != "All ages",
               IncomeLine == "Low income measure after tax",
               Statistics == "Number of persons in low income"
        )
      
    }
    
    m1_PI_render_GB <- function(df, input){
      df1 <- m1_PI_GB_data(df, input$m1_PI_GB_geo, input$m1_PI_GB_year)
      df1[is.na(df1)] <- 0
      
      wide_df1 <- pivot_wider(
        data = df1,
        names_from = Sex,
        values_from = VALUE,
        values_fill = 0
      )
      
      colors <- c('Males' = "#FFA500", 'Females' = "#4384FF")
      
      waffle_charts <- list()
      for (age in unique(wide_df1$Age)) {
        Males <-  wide_df1[wide_df1$Age == age, ]$Males
        Females <-  wide_df1[wide_df1$Age == age, ]$Females
        total <- ifelse(Males + Females == 0, 1,Males + Females)
        
        parts <- c('Males' = as.integer(round((Males / total) * 25)), 
                   'Females' = as.integer(round((Females / total) *25)))
        
        waffle_chart <- waffle(parts, rows = 5, colors = colors, size = 3.0) +
          theme(legend.position = "none")+
          labs(
            x = age
          )
        
        waffle_charts[[length(waffle_charts) + 1]] <- waffle_chart
      }
      
      
      
      validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
      p1 <- grid.arrange(grobs = waffle_charts, ncol = 7)
      return(p1)
    }
 
    
# CHN Dash----
    ## Line plot----
    m1_CHN_lineplot_data <- function(df) {
      df |>
        filter(GEO == "British Columbia",
               Tenure == "Total, tenure",
               Statistics == "Percentage of households in core housing need")
    }
    
    m1_CHN_render_lineplot <- function(df, input){
      dash_lineplot(m1_CHN_lineplot_data, df, input, "Percentage")} 
    
# GC Dash----
## Line plot----
m1_GC_lineplot_data <- function(df) {
  df |>
    filter(Year >= 2010,
           GEO == "British Columbia",
           Income_concept == "Adjusted total income")
}

m1_GC_render_lineplot <- function(df, input){
  dash_lineplot(m1_GC_lineplot_data, df, input)}

# FE Dash----
## Line plot----
m1_FE_lineplot_data <- function(df) {
  df |>
    filter(GEO == "British Columbia") |>
    mutate(VALUE = round(100*VALUE,1))
}

m1_FE_render_lineplot <- function(df, input){
  dash_lineplot(m1_FE_lineplot_data, df, input, "Percentage")}

# TS Dash----
## Line plot----
m1_TS_lineplot_data <- function(df) {
  df |>
    filter(GEO == "British Columbia") |>
    mutate(VALUE = round(100*VALUE,1))
}

m1_TS_render_lineplot <- function(df, input){
  dash_lineplot(m1_TS_lineplot_data, df, input, "Percentage")}
# MI Dash----
## Line plot----
m1_MI_lineplot_data <- function(df) {
  df |>
    filter(Year >= 2000,
           GEO == "British Columbia",
           Concept == "Median after-tax income",
           Type == "Economic families and persons not in an economic family")
}

m1_MI_render_lineplot <- function(df, input){
  dash_lineplot(m1_MI_lineplot_data, df, input)}
# SB Dash----
## Line plot----
m1_SB_lineplot_data <- function(df) {
  df |>
    filter(GEO == "British Columbia",
           Age == "Total, 12 years and over",
           Sex == "Both sexes",
           Indicators == "Sense of belonging to local community, somewhat strong or very strong",
           Characteristics == "Percent") |>
    mutate(VALUE = round(VALUE, 1))
}

m1_SB_render_lineplot <- function(df, input){
  dash_lineplot(m1_SB_lineplot_data, df, input, "Percentage")}
# LE Dash----
## Line plot----
m1_LE_lineplot_data <- function(df) {
  df |>
    filter(Year >= 2000,
           GEO == "British Columbia",
           Age == "0 years",
           Sex == "Both sexes",
           Element == "Life expectancy (in years) at age x (ex)")|>
    mutate(VALUE = round(VALUE,1))
}

m1_LE_render_lineplot <- function(df, input){
  dash_lineplot(m1_LE_lineplot_data, df, input, "Percentage")}

# MH Dash----
## Line plot----
m1_MH_lineplot_data <- function(df) {
  df |>
    filter(GEO == "British Columbia",
           Age == "Total, 12 years and over",
           Sex == "Both sexes",
           Indicators == "Perceived mental health, very good or excellent",
           Characteristics == "Percent")
}

m1_MH_render_lineplot <- function(df, input){
  dash_lineplot(m1_MH_lineplot_data, df, input, "Years")}
