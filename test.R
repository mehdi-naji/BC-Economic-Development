source("Standard-Charts.R")
source("mission6-charts.R")
df1 <- load_m6_LP1()
plot <- dash_lineplot(m6_LP_lineplot_data, df1, input = NULL, y_label = "$ per hour")

div_style <- "background-color: #003366; padding: 20px;"
title_style <- "padding-left: 45px; background-color: #003366; font-family: 'Century Gothic'; font-size: 40px; font-weight: bold; color: white;"

htmltools::tagList(
  htmltools::tags$div(
    style = title_style,
    "Labour Productivity"
  ),
  htmltools::tags$div(
    style = div_style,
    plot
  )
)