# m2 ----
## GII----
mission2_GII_server <- function(Exesum_m2_GII, df_m2_GII_1, output, input){
  ### Executive Summary----
  output$exesum_m2_GII <- renderUI(Exesum_m2_GII)
  ### Line Plot----
  output$m2_GII_lineplot <- renderPlotly({
    p1 <- m2_GII_render_lineplot(df_m2_GII_1, input)
    p1
  })
  
  output$m2_GII_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_ResearchandDevelopment_filteredData.csv",
    content = function(file) {
      df <- m2_GII_lineplot_data(df_m2_GII_1, input$m2_GII_lineplot_geo, input$m2_GII_lineplot_prices, input$m2_GII_lineplot_industry, input$m2_GII_lineplot_asset)
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