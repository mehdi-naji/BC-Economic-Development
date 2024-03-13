# m1 ----
## UR----
mission1_UR_server <- function(Exesum_m1_UR, df1, df2, df3, df4, output, input){
  ### Executive Summary----
  output$exesum_m1_UR <- renderUI(Exesum_m1_UR)
  ### Line Plot----
  output$m1_UR_lineplot <- renderPlotly({
    p1 <- m1_UR_render_lineplot(df2, input)
    p1
  })
  
  output$m1_UR_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission1_UnemploymnetRate_filteredData.csv",
    content = function(file) {
      df <- m1_UR_lineplot_data(df2, input$m1_UR_lineplot_geo, input$m1_UR_lineplot_character, input$m1_UR_lineplot_age, input$m1_UR_lineplot_sex)
      write.csv(df, file)
    }
  )
  
  ### Waffle Plot----
  output$m1_UR_waffle <- renderPlot({
    p1 <- m1_UR_render_waffle(df4, input)
    p1
  })
  
  output$m1_UR_waffle_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission1_UnemploymnetRate_filteredData.csv",
    content = function(file) {
      df <- m1_UR_waffle_data(df4, input$m1_UR_waffle_year)
      write.csv(df, file)
    }
  )

  
}