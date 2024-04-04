# m1 ----
## UR----
mission1_UR_server <- function(Exesum_m1_UR, df1, df2, df3, df4, df5, output, input){
  ### Executive Summary----
  output$exesum_m1_UR <- renderUI(Exesum_m1_UR)
  ### Line Plot----
  output$m1_UR_lineplot <- renderPlotly({
    p1 <- m1_UR_render_lineplot(df1, input)
    p1
  })
  
  output$m1_UR_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission1_UnderemploymentRate_filteredData.csv",
    content = function(file) {
      df <- m1_UR_lineplot_data(df2)
      write.csv(df, file)
    }
  )
  
  ### Waffle Plot----
  output$m1_UR_waffle <- renderPlot({
    p1 <- m1_UR_render_waffle(df4, input)
    p1
  })
  
  output$m1_UR_waffle_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission1_UnderemploymentRate_filteredData.csv",
    content = function(file) {
      df <- m1_UR_waffle_data(df4, input$m1_UR_waffle_year)
      write.csv(df, file)
    }
  )
  
  
  ### Tree Map Plot----
  output$m1_UR_treemap <- renderPlotly({
    p1 <- m1_UR_render_treemap(df3, input)
    p1
  })
  
  output$m1_UR_treemap_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission1_UnderemploymentRate_filteredData.csv",
    content = function(file) {
      df <- m1_UR_treemap_data(df3, input$m1_UR_treemap_geo, input$m1_UR_treemap_year, input$m1_UR_treemap_character)
      
      write.csv(df, file)
    }
  )
  
  ### Heat Map Plot----
  output$m1_UR_heatmap <- renderPlotly({
    p1 <- m1_UR_render_heatmap(df5, input)
    p1
  })
  
  output$m1_UR_heatmap_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission1_UnderemploymentRate_filteredData.csv",
    content = function(file) {
      df <- m1_UR_heatmap_data(df5, input$m1_UR_heatmap_geo, input$m1_UR_heatmap_year, input$m1_UR_heatmap_character)
      
      write.csv(df, file)
    }
  )

  
}

## PI----
mission1_PI_server <- function(Exesum_m1_PI, df1, df2, output, input){
  ### Executive Summary----
  output$exesum_m1_PI <- renderUI(Exesum_m1_PI)
  ### Line Plot----
  output$m1_PI_lineplot <- renderPlotly({
    p1 <- m1_PI_render_lineplot(df1, input)
    p1
  })
  
  output$m1_PI_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission1_PovertyIncidence_filteredData.csv",
    content = function(file) {
      df <- m1_PI_lineplot_data(df1)
      
      write.csv(df, file)
    }
  )
  
  ### GB : Gender Bias----
  output$m1_PI_GB <- renderPlot({
    p1 <- m1_PI_render_GB(df2, input)
    p1
  })
  
  output$m1_PI_GB_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission1_PovertyIncidence_filteredData.csv",
    content = function(file) {
      df <- m1_PI_GB_data(df2, input$m1_PI_GB_geo, input$m1_PI_GB_year)
      
      write.csv(df, file)
    }
  )
}


## CHN----
mission1_CHN_server <- function(Exesum_m1_CHN, df1, output, input){
  ### Executive Summary----
  output$exesum_m1_CHN <- renderUI(Exesum_m1_CHN)
  ### Line Plot----
  output$m1_CHN_lineplot <- renderPlotly({
    p1 <- m1_CHN_render_lineplot(df1, input)
    p1
  })
  
  output$m1_CHN_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission1_CoreHousingNeeds_filteredData.csv",
    content = function(file) {
      df <- m1_CHN_lineplot_data(df1)
      
      write.csv(df, file)
    }
  )
}

## GC----
mission1_GC_server <- function(Exesum_m1_GC, df1, output, input){
  ### Executive Summary----
  output$exesum_m1_GC <- renderUI(Exesum_m1_GC)
  ### Line Plot----
  output$m1_GC_lineplot <- renderPlotly({
    p1 <- m1_GC_render_lineplot(df1, input)
    p1
  })
  
  output$m1_GC_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission1_GiniCoefficient_filteredData.csv",
    content = function(file) {
      df <- m1_GC_lineplot_data(df1)
      
      write.csv(df, file)
    }
  )
}