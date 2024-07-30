# m6 ----

# Homepage----

server_m6_home <- function(df_m6_RnD_1, 
                           df_m6_LP_1, 
                           df_m6_VAEX_1, 
                           df_m6_nRinv_1, 
                           df_m6_EXP_1, 
                           output, input, session) {
  

  plot_and_triangle(df_m6_RnD_1, m6_RnD_lineplot_data, "m6_homepage_worm_RnD", "m6_homepage_button_RnD", "RnD", "m6_homepage_triangle_RnD", output, input, session)
  plot_and_triangle(df_m6_LP_1, m6_LP_lineplot_data, "m6_homepage_worm_LP", "m6_homepage_button_LP", "LP", "m6_homepage_triangle_LP", output, input, session)
  plot_and_triangle(df_m6_VAEX_1, m6_VAEX_lineplot_data, "m6_homepage_worm_VAEX", "m6_homepage_button_VAEX", "VAEX", "m6_homepage_triangle_VAEX", output, input, session)
  plot_and_triangle(df_m6_nRinv_1, m6_nRinv_lineplot_data, "m6_homepage_worm_nRinv", "m6_homepage_button_nRinv", "nRinv", "m6_homepage_triangle_nRinv", output, input, session)
  plot_and_triangle(df_m6_EXP_1, m6_EXP_lineplot_data, "m6_homepage_worm_EXP", "m6_homepage_button_EXP", "EXP", "m6_homepage_triangle_EXP", output, input, session)
}








## RnD----
mission6_RnD_server <- function(Exesum_m6_RnD_main, Exesum_m6_RnD, df_m6_RnD_1, df_m6_RnD_2, output, input){
  output$Exesum_m6_RnD_main <- renderUI(Exesum_m6_RnD_main)

  ### Executive Summary----
  output$Exesum_m6_RnD <- renderUI(Exesum_m6_RnD)
  ### Line Plot----
  output$m6_RnD_lineplot <- renderPlotly({
    p1 <- m6_RnD_render_lineplot(df_m6_RnD_1, input)
    p1
  })
  
  output$m6_RnD_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_ResearchandDevelopment_filteredData.csv",
    content = function(file) {
      df <- m6_RnD_lineplot_data(df_m6_RnD_1, input$m6_RnD_lineplot_geo, input$m6_RnD_lineplot_funder, input$m6_RnD_lineplot_performer, input$m6_RnD_lineplot_science_type, input$m6_RnD_lineplot_prices)
      write.csv(df, file)
    })
  
  output$m6_RnD_map <- renderLeaflet({
    p1 <- m6_RnD_render_map(df_m6_RnD_2,input)
    
    p1
  })
    
  
  
  
  ### Bar Plot----
  output$m6_RnD_barplot <- renderPlotly({
    p1 <- m6_RnD_render_barplot(df_m6_RnD_2, input)
    p1
  })

  output$m6_RnD_barplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_ResearchandDevelopment_filteredData.csv",
    content = function(file) {
      df <- m6_RnD_barplot_data(df_m6_RnD_1, input$m6_RnD_barplot_year)
      write.csv(df, file)
    }
  )
  ### Table----
  output$m6_RnD_table <- DT::renderDataTable({
    p1 <- m6_RnD_render_table(df_m6_RnD_1, input)
    p1
  })

  output$m6_RnD_table_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_ResearchandDevelopment_filteredData.csv",
    content = function(file) {
      df <- m6_RnD_table_data(df_m6_RnD_1, input$m6_RnD_table_year, input$m6_RnD_table_funder, input$m6_RnD_table_performer, input$m6_RnD_table_science_type, input$m6_RnD_table_prices )
      write.csv(df, file)
    }
  )

  ### Sankey Plot----
  output$m6_RnD_sankey <- renderPlotly({
    p1 <- m6_RnD_render_sankey(df_m6_RnD_1, input)
    p1
  })

  output$m6_RnD_sankey_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_ResearchandDevelopment_filteredData.csv",
    content = function(file) {
      df <- m6_RnD_sankey_data(df_m6_RnD_1, input$m6_RnD_sankey_year, input$m6_RnD_sankey_geo, input$m6_RnD_sankey_science_type)

      write.csv(df, file)
    }
  )
}

## VAEX----

mission6_VAEX_server <- function(Exesum_m6_VAEX_main, Exesum_m6_VAEX, df_m6_VAEX_1, output, input){
  output$Exesum_m6_VAEX_main <- renderUI(Exesum_m6_VAEX_main)
  
  ### Executive Summary----
  output$Exesum_m6_VAEX <- renderUI(Exesum_m6_VAEX)
  ### Line plot----
  output$m6_VAEX_lineplot <- renderPlotly({
    p1 <- m6_VAEX_render_lineplot(df_m6_VAEX_1, input)
    p1
  })
  
  output$m6_VAEX_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_ValueAddedEXPort_filteredData.csv",
    content = function(file) {
      df <- m6_VAEX_lineplot_data(df_m6_VAEX_1, input$m6_VAEX_lineplot_geo)
      
      write.csv(df, file)
    }
  )
  ### Bar plot ----
  output$m6_VAEX_barplot <- renderPlotly({
    p1 <- m6_VAEX_render_barplot(df_m6_VAEX_1, input)
    p1
  })
  
  output$m6_VAEX_barplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_ValueAddedEXPort_filteredData.csv",
    content = function(file) {
      df <- m6_VAEX_bar_data(df_m6_VAEX_1, input$m6_VAEX_barplot_year, input$m6_VAEX_barplot_industry)
      
      write.csv(df, file)
    }
  )
  ### Pie plot----
  output$m6_VAEX_pie <- renderPlotly({
    p1 <- m6_VAEX_render_pie(df_m6_VAEX_1, input)
    p1
  })
  
  output$m6_VAEX_pie_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_ValueAddedEXPort_filteredData.csv",
    content = function(file) {
      df <- m6_VAEX_pie_data(df_m6_VAEX_1, input$m6_VAEX_pie_geo, input$m6_VAEX_pie_year)
      
      write.csv(df, file)
    }
  )
}
## non-residential Investment----

mission6_nRinv_server <- function(Exesum_m6_nRiv_main, Exesum_m6_nRinv, df_m6_nRinv_1, output, input){
  output$Exesum_m6_nRinv_main <- renderUI(Exesum_m6_nRinv_main)
  
  ### Executive Summary----
  output$Exesum_m6_nRinv <- renderUI(Exesum_m6_nRinv)
  ### Line plot----
  output$m6_nRinv_lineplot <- renderPlotly({
    p1 <- m6_nRinv_render_lineplot(df_m6_nRinv_1, input)
    p1
  })
  
  output$m6_nRinv_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_nonResidentialInvestment_filteredData.csv",
    content = function(file) {
      df <- m6_nRinv_lineplot_data(df_m6_nRinv_1, input$m6_nRinv_lineplot_geo, input$m6_nRinv_lineplot_item)
      
      write.csv(df, file)
    }
  )
  ### Lines plot----
  output$m6_nRinv_lines <- renderPlotly({
    p1 <- m6_nRinv_render_lines(df_m6_nRinv_1, input)
    p1
  })
  
  output$m6_nRinv_lines_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_nonResidentialInvestment_filteredData.csv",
    content = function(file) {
      df <- m6_nRinv_lines_data(df_m6_nRinv_1, input$m6_nRinv_lines_geo, input$m6_nRinv_lines_prices)
      
      write.csv(df, file)
    }
  )
  
  ### Bar plot----
  output$m6_nRinv_barplot <- renderPlotly({
    p1 <- m6_nRinv_render_barplot(df_m6_nRinv_1, input)
    p1
  })
  
  output$m6_nRinv_barplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_nonResidentialInvestment_filteredData.csv",
    content = function(file) {
      df <- m6_nRinv_barplot_data(df_m6_nRinv_1, input$m6_nRinv_barplot_year)
      
      write.csv(df, file)
    }
  )
}

## labour Productivity----
mission6_LP_server <- function(Exesum_m6_LP_main, Exesum_m6_LP, df_m6_LP_1, output, input){
  
  output$Exesum_m6_LP_main <- renderUI(Exesum_m6_LP_main)
  
  ### Executive Summary----
  output$Exesum_m6_LP <- renderUI(Exesum_m6_LP)
  ### Line plot----
  output$m6_LP_lineplot <- renderPlotly({
    p1 <- m6_LP_render_lineplot(df_m6_LP_1, input)
    p1
  })
  
  output$m6_LP_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_LabourProductivity_filteredData.csv",
    content = function(file) {
      df <- m6_LP_lineplot_data(df_m6_LP_1, input$m6_LP_lineplot_geo, input$m6_LP_lineplot_industry, input$m6_LP_lineplot_labourtype)
      
      write.csv(df, file)
    }
  )
  
  ### Lines plot----
  output$m6_LP_lines <- renderPlotly({
    p1 <- m6_LP_render_lines(df_m6_LP_1, input)
    p1
  })
  
  output$m6_LP_lines_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_LabourProductivity_filteredData.csv",
    content = function(file) {
      df <- m6_LP_lines_data(df_m6_LP_1, input$m6_LP_lines_geo, input$m6_LP_lines_labourtype)
      
      write.csv(df, file)
    }
  )
  ### Treemap plot----
  output$m6_LP_treemap <- renderPlotly({
    p1 <- m6_LP_render_treemap(df_m6_LP_1, input)
    p1
  })
  
  output$m6_LP_treemap_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_LabourProductivity_filteredData.csv",
    content = function(file) {
      df <- m6_LP_treemap_data(df_m6_LP_1, input$m6_LP_treemap_geo, input$m6_LP_treemap_year)
      
      write.csv(df, file)
    }
  )
  ### table----
  output$m6_LP_table <- DT::renderDataTable({
    p1 <- m6_LP_render_table(df_m6_LP_1, input)
    p1
  })
  
  
  output$m6_LP_growthsectors <- renderPlotly({
    p1 <- m6_LP_render_growthsectors(df_m6_LP_1, input)
    p1
  })
  
  
  output$m6_LP_table_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_LabourProductivity_filteredData.csv",
    content = function(file) {
      df <- m6_LP_table_data(df_m6_LP_1, input$m6_LP_table_year, input$m6_LP_table_labourtype, input$m6_LP_table_industry)
      
      write.csv(df, file)
    }
  )
  
  ### map----
  output$m6_LP_map <- renderLeaflet({
    p1 <- m6_LP_render_map(df_m6_LP_1,input)
    
    p1
  })
  
  output$m6_LP_map_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_LabourProductivity_filteredData.csv",
    content = function(file) {
      df <-  m6_LP_map_data(df_m6_LP_1, input$m6_LP_map_year, input$m6_LP_map_labourtype, input$m6_LP_map_industry)
      
      write.csv(df, file)
    }
  )
}

## EXPORT----
mission6_EXP_server <- function(Exesum_m6_EXP_main, Exesum_m6_EXP, df_m6_EXP_1, df_m6_EXP_2, df_m6_EXP_3, df_m6_EXP_4, output, input){
  output$Exesum_m6_EXP_main <- renderUI(Exesum_m6_EXP_main)
  
  ### Executive Summary----
  output$Exesum_m6_EXP <- renderUI(Exesum_m6_EXP)
  ### Line plot----
  output$m6_EXP_lineplot <- renderPlotly({
    p1 <- m6_EXP_render_lineplot(df_m6_EXP_1, input)
    p1
  })
  
  output$m6_EXP_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_EXPort_filteredData.csv",
    content = function(file) {
      df <-  m6_EXP_lineplot_data(df_m6_EXP_1, input$m6_EXP_lineplot_geo, input$m6_EXP_lineplot_EXPtype)
      
      write.csv(df, file)
    }
  )
  
  ### Heat Map----
  output$m6_EXP_heatmap <- renderPlotly({
    p1 <- m6_EXP_render_heatmap(df_m6_EXP_2, input)
    p1
  })
  
  
  output$m6_EXP_heatmap_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_EXPort_filteredData.csv",
    content = function(file) {
      df <- m6_EXP_heatmap_data(df_m6_EXP_2)  
      
      write.csv(df, file)
    }
  )
  ### Stacked Bar Plot----
  output$m6_EXP_stackbar <- renderPlotly({
    p1 <- m6_EXP_render_stackbar(df_m6_EXP_3, input)
    p1
  })
  
  output$m6_EXP_stackbar_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_EXPort_filteredData.csv",
    content = function(file) {
      df <-  m6_EXP_stackbar_data(df_m6_EXP_3, input$m6_EXP_stackbar_year)
      
      write.csv(df, file)
    }
  )
  ### Bubble Plot----
  output$m6_EXP_bubble <- renderPlotly({
    p1 <- m6_EXP_render_bubble(df_m6_EXP_4, input)
    p1
  })
  
  output$m6_EXP_bubble_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_EXPort_filteredData.csv",
    content = function(file) {
      df <-  m6_EXP_bubble_data(df_m6_EXP_4)
      
      write.csv(df, file)
    }
  )
}