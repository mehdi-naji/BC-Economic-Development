# m1 ----
## UR----
mission1_UR_server <- function(Exesum_m1_UR, df_m1_UR_1, df_m1_UR_2, df_m1_UR_3, output, input){
  ### Executive Summary----
  output$exesum_m1_UR <- renderUI(Exesum_m1_UR)
  ### Line Plot----
  output$m1_UR_lineplot <- renderPlotly({
    p1 <- m1_UR_render_lineplot(df_m1_UR_2, input)
    p1
  })
  
  output$m2_UR_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_ResearchandDevelopment_filteredData.csv",
    content = function(file) {
      df <- m1_UR_lineplot_data(df_m1_UR_2, input$m1_UR_lineplot_geo, input$m1_UR_lineplot_character, input$m1_UR_lineplot_age, input$m1_UR_lineplot_sex)
      write.csv(df, file)
    }
  )
  # 
  # ### Stacked Bar Plot----
  # output$m5_CEG_stackbar <- renderPlotly({
  #   p1 <- m5_CEG_render_stackbar(df_m5_CEG_1, input)
  #   p1
  # })
  # 
  # output$m5_CEG_stackbar_dwnbtt <- downloadHandler(
  #   filename = "StrongerBC_Mission6_Export_filteredData.csv",
  #   content = function(file) {
  #     df <-  m5_CEG_stackbar_data(df_m5_CEG_1)
  #     
  #     write.csv(df, file)
  #   }
  # )
  
}