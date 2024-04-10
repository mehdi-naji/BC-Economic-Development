# m6 ----
## RnD----
mission6_RnD_server <- function(Exesum_m6_RnD, df_m6_RnD_1, df_m6_RnD_2, output, input){
  ### Executive Summary----
  output$exesum_m6_RnD <- renderUI(Exesum_m6_RnD)
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
    }
  )
  
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

mission6_VAEX_server <- function(Exesum_m6_VAEX, df_m6_VAEX_1, output, input){
  
  ### Executive Summary----
  output$Exesum_m6_VAEX <- renderUI(Exesum_m6_VAEX)
  ### Line plot----
  output$m6_VAEX_lineplot <- renderPlotly({
    p1 <- m6_VAEX_render_lineplot(df_m6_VAEX_1, input)
    p1
  })
  
  output$m6_VAEX_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_ValueAddedExport_filteredData.csv",
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
    filename = "StrongerBC_Mission6_ValueAddedExport_filteredData.csv",
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
    filename = "StrongerBC_Mission6_ValueAddedExport_filteredData.csv",
    content = function(file) {
      df <- m6_VAEX_pie_data(df_m6_VAEX_1, input$m6_VAEX_pie_geo, input$m6_VAEX_pie_year)
      
      write.csv(df, file)
    }
  )
}
## non-residential Investment----

mission6_nRinv_server <- function(Exesum_m6_nRinv, df_m6_nRinv_1, output, input){
    
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
mission6_lp_server <- function(Exesum_m6_lp, df_m6_lp_1, output, input){
  
  ### Executive Summary----
  output$Exesum_m6_lp <- renderUI(Exesum_m6_lp)
  ### Line plot----
  output$m6_lp_lineplot <- renderPlotly({
    p1 <- m6_lp_render_lineplot(df_m6_lp_1, input)
    p1
  })
  
  output$m6_lp_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_LabourProductivity_filteredData.csv",
    content = function(file) {
      df <- m6_lp_lineplot_data(df_m6_lp_1, input$m6_lp_lineplot_geo, input$m6_lp_lineplot_industry, input$m6_lp_lineplot_labourtype)
      
      write.csv(df, file)
    }
  )
  
  ### Lines plot----
  output$m6_lp_lines <- renderPlotly({
    p1 <- m6_lp_render_lines(df_m6_lp_1, input)
    p1
  })
  
  output$m6_lp_lines_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_LabourProductivity_filteredData.csv",
    content = function(file) {
      df <- m6_lp_lines_data(df_m6_lp_1, input$m6_lp_lines_geo, input$m6_lp_lines_labourtype)
      
      write.csv(df, file)
    }
  )
  ### Treemap plot----
  output$m6_lp_treemap <- renderPlotly({
    p1 <- m6_lp_render_treemap(df_m6_lp_1, input)
    p1
  })
  
  output$m6_lp_treemap_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_LabourProductivity_filteredData.csv",
    content = function(file) {
      df <- m6_lp_treemap_data(df_m6_lp_1, input$m6_lp_treemap_geo, input$m6_lp_treemap_year)
      
      write.csv(df, file)
    }
  )
  ### table----
  output$m6_lp_table <- DT::renderDataTable({
    p1 <- m6_lp_render_table(df_m6_lp_1, input)
    p1
  })
  output$m6_lp_table_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_LabourProductivity_filteredData.csv",
    content = function(file) {
      df <- m6_lp_table_data(df_m6_lp_1, input$m6_lp_table_year, input$m6_lp_table_labourtype, input$m6_lp_table_industry)
      
      write.csv(df, file)
    }
  )
  
  ### map----
  output$m6_lp_map <- renderLeaflet({
    p1 <- m6_lp_render_map(df_m6_lp_1,input)
    
    p1
  })
  
  output$m6_lp_map_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_LabourProductivity_filteredData.csv",
    content = function(file) {
      df <-  m6_lp_map_data(df_m6_lp_1, input$m6_lp_map_year, input$m6_lp_map_labourtype, input$m6_lp_map_industry)
      
      write.csv(df, file)
    }
  )
}

## EXPORT----
mission6_exp_server <- function(Exesum_m6_exp, df_m6_exp_1, df_m6_exp_2, df_m6_exp_3, df_m6_exp_4, output, input){
  ### Executive Summary----
  output$Exesum_m6_exp <- renderUI(Exesum_m6_exp)
  ### Line plot----
  output$m6_exp_lineplot <- renderPlotly({
    p1 <- m6_exp_render_lineplot(df_m6_exp_1, input)
    p1
  })
  
  output$m6_exp_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_Export_filteredData.csv",
    content = function(file) {
      df <-  m6_exp_lineplot_data(df_m6_exp_1, input$m6_exp_lineplot_geo, input$m6_exp_lineplot_exptype)
      
      write.csv(df, file)
    }
  )
  
  ### Heat Map----
  output$m6_exp_heatmap <- renderPlotly({
    p1 <- m6_exp_render_heatmap(df_m6_exp_2, input)
    p1
  })
  
  
  output$m6_exp_heatmap_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_Export_filteredData.csv",
    content = function(file) {
      df <- m6_exp_heatmap_data(df_m6_exp_2)  
      
      write.csv(df, file)
    }
  )
  ### Stacked Bar Plot----
  output$m6_exp_stackbar <- renderPlotly({
    p1 <- m6_exp_render_stackbar(df_m6_exp_3, input)
    p1
  })
  
  output$m6_exp_stackbar_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_Export_filteredData.csv",
    content = function(file) {
      df <-  m6_exp_stackbar_data(df_m6_exp_3, input$m6_exp_stackbar_year)
      
      write.csv(df, file)
    }
  )
  ### Bubble Plot----
  output$m6_exp_bubble <- renderPlotly({
    p1 <- m6_exp_render_bubble(df_m6_exp_4, input)
    p1
  })
  
  output$m6_exp_bubble_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_Export_filteredData.csv",
    content = function(file) {
      df <-  m6_exp_bubble_data(df_m6_exp_4)
      
      write.csv(df, file)
    }
  )
}