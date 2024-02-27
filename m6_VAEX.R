# Loading data----
load_df_VAEX <- function() {
  url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/VA_Exporsts_1.csv"
  df <- read.csv(url, header = TRUE)
  df <- na.omit(df)
  return(df)
}

# Line Plot ----
m6_VAEX_lineplot_data <- function(df, geo){
  df |>
    filter(GEO == geo,
           Industry == "Total industries")
}

m6_VAEX_render_lineplot <- function(df, input){
  df1 <- m6_VAEX_lineplot_data(df, input$geo)
  p1 <- df1 |> 
    plot_ly(x = ~Year, y = ~VA_EXP*1000, type = 'scatter', mode = 'lines') |>
    layout(title = list(text = paste("Value-added Exports in", input$geo)),
           xaxis = list(
             title = "", 
             rangeslider = list(
               visible = T,
               thickness = 0.03,  
               bgcolor = "darkgrey"  
             )
           ),
           yaxis = list(title = paste ("$ ")))
  validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
  
  p1 <- ggplotly(p1)
}

# Bar Plot ----
m6_VAEX_bar_data <- function(df, year, industry){
  df |> 
    filter (Year == year,
            Industry == industry)|>
    mutate (EXP_GDP = 100 * VA_EXP / (GDP*1000))
}

m6_VAEX_render_barplot <- function(df, input){
  df2 <- m6_VAEX_bar_data(df, input$year, input$industry)
  df2$GEO <- reorder(df2$GEO, df2$EXP_GDP)
  df2$formatted_VALUE <- sprintf("%.2f%%", df2$EXP_GDP)
  df2$adjusted_VALUE <- df2$EXP_GDP + max(df2$EXP_GDP) / 10
  p2 <- df2 |>
    plot_ly(x = ~EXP_GDP, y=~GEO, color=~GEO, type = 'bar',
            showlegend = FALSE)  |>
    add_text(x = ~adjusted_VALUE,text = ~formatted_VALUE, textposition = 'outside') |>
    layout(title = paste("Value added in Exports as Percent of GDP in", input$year),
           font = list(family = 'Arial', size = 12),
           yaxis = list(title = ""),
           xaxis = list(title = "Percent"),
           bargroupgap = 0.3)
  
  validate(need(nrow(df2) > 0, "The data for this year is inadequate. To obtain a proper visualization, please modify the year selection in the sidebar."))
  return(p2)
}

# Pie Chart ----

m6_VAEX_pie_data <- function(df, geo, year){
  df |>
    filter(Industry != "Total industries",
           GEO == geo,
           Year == year)
}

m6_VAEX_render_pie <- function(df, input){
  df1 <- m6_VAEX_pie_data(df, input$geo, input$year)
  sorted_data <- df1 |>
    arrange(desc(VA_EXP))
  
  # Create a pie chart
  fig <- plot_ly(sorted_data, labels = ~Industry, values = ~VA_EXP, type = 'pie', textposition = 'inside')
  fig <- fig |> layout(showlegend = FALSE)
  fig <- fig |> layout(title = paste("Industries Value Added in", input$geo), showlegend = FALSE)
  
  
  return(fig)
}