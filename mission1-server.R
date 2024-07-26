# m1 ----
# Homepage----
server_m1_home <- function(df_m1_PI_1, df_m1_CHN_1,df_m1_GC_1, 
                           df_m1_UR_1, df_m1_FE_1, df_m1_TS_1,
                           df_m1_SB_1, df_m1_LE_1, df_m1_MH_1, 
                           output, input, session){
  plot_and_triangle(df_m1_PI_1, m1_PI_lineplot_data, "m1_homepage_worm_PI", "m1_homepage_button_PI", "PI", "m1_homepage_triangle_PI", output, input, session)
  plot_and_triangle(df_m1_CHN_1, m1_CHN_lineplot_data, "m1_homepage_worm_CHN", "m1_homepage_button_CHN", "CHN", "m1_homepage_triangle_CHN", output, input, session)
  plot_and_triangle(df_m1_GC_1, m1_GC_lineplot_data, "m1_homepage_worm_GC", "m1_homepage_button_GC", "GC", "m1_homepage_triangle_GC", output, input, session)
  plot_and_triangle(df_m1_UR_1, m1_UR_lineplot_data, "m1_homepage_worm_UR", "m1_homepage_button_UR", "UR", "m1_homepage_triangle_UR", output, input, session)
  plot_and_triangle(df_m1_FE_1, m1_FE_lineplot_data, "m1_homepage_worm_FE", "m1_homepage_button_FE", "FE", "m1_homepage_triangle_FE", output, input, session)
  plot_and_triangle(df_m1_TS_1, m1_TS_lineplot_data, "m1_homepage_worm_TS", "m1_homepage_button_TS", "TS", "m1_homepage_triangle_TS", output, input, session)
  plot_and_triangle(df_m1_SB_1, m1_SB_lineplot_data, "m1_homepage_worm_SB", "m1_homepage_button_SB", "SB", "m1_homepage_triangle_SB", output, input, session)
  plot_and_triangle(df_m1_LE_1, m1_LE_lineplot_data, "m1_homepage_worm_LE", "m1_homepage_button_LE", "LE", "m1_homepage_triangle_LE", output, input, session)
  plot_and_triangle(df_m1_MH_1, m1_MH_lineplot_data, "m1_homepage_worm_MH", "m1_homepage_button_MH", "MH", "m1_homepage_triangle_MH", output, input, session)
}





## UR----
mission1_UR_server <- function(Exesum_m1_UR_main, Exesum_m1_UR, df1, df2, df3, df4, df5, output, input){
  output$Exesum_m1_UR_main <- renderUI(Exesum_m1_UR_main)
  
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
mission1_PI_server <- function(Exesum_m1_PI_main, Exesum_m1_PI, df1, df2, output, input){
  output$Exesum_m1_PI_main <- renderUI(Exesum_m1_PI_main)
  
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
mission1_CHN_server <- function(Exesum_m1_CHN_main, Exesum_m1_CHN, df1, output, input){
  output$Exesum_m1_CHN_main <- renderUI(Exesum_m1_CHN_main)
  
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
mission1_GC_server <- function(Exesum_m1_GC_main, Exesum_m1_GC, df1, output, input){
  output$Exesum_m1_GC_main <- renderUI(Exesum_m1_GC_main)
  
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

## FE----
mission1_FE_server <- function(Exesum_m1_FE_main, Exesum_m1_FE, df1, output, input){
  output$Exesum_m1_FE_main <- renderUI(Exesum_m1_FE_main)
  
  ### Executive Summary----
  output$exesum_m1_FE <- renderUI(Exesum_m1_FE)
  ### Line Plot----
  output$m1_FE_lineplot <- renderPlotly({
    p1 <- m1_FE_render_lineplot(df1, input)
    p1
  })
  
  output$m1_FE_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission1_FoodExpenditure_filteredData.csv",
    content = function(file) {
      df <- m1_FE_lineplot_data(df1)
      
      write.csv(df, file)
    }
  )
}

## TS----
mission1_TS_server <- function(Exesum_m1_TS_main, Exesum_m1_TS, df1, output, input){
  output$Exesum_m1_TS_main <- renderUI(Exesum_m1_TS_main)
  
  ### Executive Summary----
  output$exesum_m1_TS <- renderUI(Exesum_m1_TS)
  ### Line Plot----
  output$m1_TS_lineplot <- renderPlotly({
    p1 <- m1_TS_render_lineplot(df1, input)
    p1
  })
  
  output$m1_TS_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission1_FoodExpenditure_filteredData.csv",
    content = function(file) {
      df <- m1_TS_lineplot_data(df1)
      
      write.csv(df, file)
    }
  )
}
## MI----
mission1_MI_server <- function(Exesum_m1_MI_main, Exesum_m1_MI, df1, output, input){
  output$Exesum_m1_MI_main <- renderUI(Exesum_m1_MI_main)
  
  ### Executive Summary----
  output$exesum_m1_MI <- renderUI(Exesum_m1_MI)
  ### Line Plot----
  output$m1_MI_lineplot <- renderPlotly({
    p1 <- m1_MI_render_lineplot(df1, input)
    p1
  })
  
  output$m1_MI_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission1_MedianIncome_filteredData.csv",
    content = function(file) {
      df <- m1_MI_lineplot_data(df1)
      
      write.csv(df, file)
    }
  )
}
## SB----
mission1_SB_server <- function(Exesum_m1_SB_main, Exesum_m1_SB, df1, output, input){
  output$Exesum_m1_SB_main <- renderUI(Exesum_m1_SB_main)
  
  ### Executive Summary----
  output$exesum_m1_SB <- renderUI(Exesum_m1_SB)
  ### Line Plot----
  output$m1_SB_lineplot <- renderPlotly({
    p1 <- m1_SB_render_lineplot(df1, input)
    p1
  })
  
  output$m1_SB_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission1_SenseofBelongings_filteredData.csv",
    content = function(file) {
      df <- m1_SB_lineplot_data(df1)
      
      write.csv(df, file)
    }
  )
}
## LE----
mission1_LE_server <- function(Exesum_m1_LE_main, Exesum_m1_LE, df1, output, input){
  output$Exesum_m1_LE_main <- renderUI(Exesum_m1_LE_main)
  
  ### Executive Summary----
  output$exesum_m1_LE <- renderUI(Exesum_m1_LE)
  ### Line Plot----
  output$m1_LE_lineplot <- renderPlotly({
    p1 <- m1_LE_render_lineplot(df1, input)
    p1
  })
  
  output$m1_LE_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission1_LifeExpectancy_filteredData.csv",
    content = function(file) {
      df <- m1_LE_lineplot_data(df1)
      
      write.csv(df, file)
    }
  )
}
## MH----
mission1_MH_server <- function(Exesum_m1_MH_main, Exesum_m1_MH, df1, output, input){
  output$Exesum_m1_MH_main <- renderUI(Exesum_m1_MH_main)
  
  ### Executive Summary----
  output$exesum_m1_MH <- renderUI(Exesum_m1_MH)
  ### Line Plot----
  output$m1_MH_lineplot <- renderPlotly({
    p1 <- m1_MH_render_lineplot(df1, input)
    p1
  })
  
  output$m1_MH_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission1_MentalHealth_filteredData.csv",
    content = function(file) {
      df <- m1_MH_lineplot_data(df1)
      
      write.csv(df, file)
    }
  )
}