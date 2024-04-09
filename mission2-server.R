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
    filename = "StrongerBC_Mission6_GovernmentInvestmentInfrastructure_filteredData.csv",
    content = function(file) {
      df <- m2_GII_lineplot_data(df_m2_GII_1, input$m2_GII_lineplot_geo, input$m2_GII_lineplot_prices, input$m2_GII_lineplot_industry, input$m2_GII_lineplot_asset)
      write.csv(df, file)
    }
  )}

## NBO----
mission2_NBO_server <- function(Exesum_m2_NBO, df_m2_NBO_1, output, input){
  ### Executive Summary----
  output$exesum_m2_NBO <- renderUI(Exesum_m2_NBO)
  ### Line Plot----
  output$m2_NBO_lineplot <- renderPlotly({
    p1 <- m2_NBO_render_lineplot(df_m2_NBO_1, input)
    p1
  })
  
  output$m2_NBO_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_NewBusinessOpenings_filteredData.csv",
    content = function(file) {
      df <- m2_NBO_lineplot_data(df_m2_NBO_1)
      write.csv(df, file)
    }
  )}