# m5 ----
## CEG----
mission5_CEG_server <- function(Exesum_m5_CEG, df_m5_CEG_1, output, input){
  ### Executive Summary----
  output$exesum_m5_CEG <- renderUI(Exesum_m5_CEG)
  ### Line Plot----
  output$m5_CEG_lineplot <- renderPlotly({
    p1 <- m5_CEG_render_lineplot(df_m5_CEG_1, input)
    p1
  })
  
  output$m5_CEG_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_ResearchandDevelopment_filteredData.csv",
    content = function(file) {
      df <- m5_CEG_lineplot_data(df_m5_CEG_1, input$m5_CEG_lineplot_geo, input$m5_CEG_lineplot_class, input$m5_CEG_lineplot_type)
      write.csv(df, file)
    }
  )
  
  ### Stacked Bar Plot----
  output$m5_CEG_stackbar <- renderPlotly({
    p1 <- m5_CEG_render_stackbar(df_m5_CEG_1, input)
    p1
  })
  
  output$m5_CEG_stackbar_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_Export_filteredData.csv",
    content = function(file) {
      df <-  m5_CEG_stackbar_data(df_m5_CEG_1)
      
      write.csv(df, file)
    }
  )
  
}