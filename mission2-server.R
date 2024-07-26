# m2 ----

# Homepage----
server_m2_home <- function(df_m2_NBO_1, df_m2_HA_1, df_m2_LMPR_1, 
                           df_m2_OVC_1, df_m2_GII_1, df_m2_PRHC_1, 
                           output, input, session){
  
  
  output$m2_homepage_worm_NBO <- renderPlot({
    wormchart(m2_NBO_lineplot_data(df_m2_NBO_1))})
  observeEvent(input$m2_homepage_button_NBO, {
    updateTabItems(session, "tabs", selected = "NBO")})
  output$m2_homepage_triangle_NBO <- renderUI({
    Sign <- sign(unique(df_m2_NBO_1$Year)[length(unique(df_m2_NBO_1$Year))] - unique(df_m2_NBO_1$Year)[length(unique(df_m2_NBO_1$Year))-1]) 
    div(class = get_triangle_class(Sign))})
  
  output$m2_homepage_worm_HA <- renderPlot({
    wormchart(m2_HA_lineplot_data(df_m2_HA_1))})    
  observeEvent(input$m2_homepage_button_HA, {
    updateTabItems(session, "tabs", selected = "HA")})
  output$m2_homepage_triangle_HA <- renderUI({
    Sign <- sign(unique(df_m2_HA_1$Year)[length(unique(df_m2_HA_1$Year))] - unique(df_m2_HA_1$Year)[length(unique(df_m2_HA_1$Year))-1])
    div(class = get_triangle_class(Sign))})
  
  output$m2_homepage_worm_LMPR <- renderPlot({
    wormchart(m2_LMPR_lineplot_data(df_m2_LMPR_1))})
  observeEvent(input$m2_homepage_button_LMPR, {
    updateTabItems(session, "tabs", selected = "LMPR")})
  output$m2_homepage_triangle_LMPR <- renderUI({
    Sign <- sign(unique(df_m2_LMPR_1$Year)[length(unique(df_m2_LMPR_1$Year))] - unique(df_m2_LMPR_1$Year)[length(unique(df_m2_LMPR_1$Year))-1]) 
    div(class = get_triangle_class(Sign))})
  
  output$m2_homepage_worm_OVC <- renderPlot({
    wormchart(m2_OVC_lineplot_data(df_m2_OVC_1))})   
  observeEvent(input$m2_homepage_button_OVC, {
    updateTabItems(session, "tabs", selected = "OVC")})
  output$m2_homepage_triangle_OVC <- renderUI({
    Sign <- sign(unique(df_m2_OVC_1$Year)[length(unique(df_m2_OVC_1$Year))] - unique(df_m2_OVC_1$Year)[length(unique(df_m2_OVC_1$Year))-1]) 
    div(class = get_triangle_class(Sign))})
  
  output$m2_homepage_worm_GII <- renderPlot({
    wormchart(m2_GII_lineplot_data(df_m2_GII_1))})   
  observeEvent(input$m2_homepage_button_GII, {
    updateTabItems(session, "tabs", selected = "GII")})
  output$m2_homepage_triangle_GII <- renderUI({
    Sign <- sign(unique(df_m2_GII_1$Year)[length(unique(df_m2_GII_1$Year))] - unique(df_m2_GII_1$Year)[length(unique(df_m2_GII_1$Year))-1]) 
    div(class = get_triangle_class(Sign))})
  
  output$m2_homepage_worm_PRHC <- renderPlot({
    wormchart(m2_PRHC_lineplot_data(df_m2_PRHC_1))})   
  observeEvent(input$m2_homepage_button_PRHC, {
    updateTabItems(session, "tabs", selected = "PRHC")})
  output$m2_homepage_triangle_PRHC <- renderUI({
    Sign <- sign(unique(df_m2_PRHC_1$Year)[length(unique(df_m2_PRHC_1$Year))] - unique(df_m2_PRHC_1$Year)[length(unique(df_m2_PRHC_1$Year))-1]) 
    div(class = get_triangle_class(Sign))})
}



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

## HA----
mission2_HA_server <- function(Exesum_m2_HA, df_m2_HA_1, output, input){
  ### Executive Summary----
  output$exesum_m2_HA <- renderUI(Exesum_m2_HA)
  ### Line Plot----
  output$m2_HA_lineplot <- renderPlotly({
    p1 <- m2_HA_render_lineplot(df_m2_HA_1, input)
    p1
  })
  
  output$m2_HA_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_HousingAvailability_filteredData.csv",
    content = function(file) {
      df <- m2_HA_lineplot_data(df_m2_HA_1)
      write.csv(df, file)
    }
  )}


## LMPR----
mission2_LMPR_server <- function(Exesum_m2_LMPR, df_m2_LMPR_1, output, input){
  ### Executive Summary----
  output$exesum_m2_LMPR <- renderUI(Exesum_m2_LMPR)
  ### Line Plot----
  output$m2_LMPR_lineplot <- renderPlotly({
    p1 <- m2_LMPR_render_lineplot(df_m2_LMPR_1, input)
    p1
  })
  
  output$m2_LMPR_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_LobourMarketParticipationRate_filteredData.csv",
    content = function(file) {
      df <- m2_LMPR_lineplot_data(df_m2_LMPR_1)
      write.csv(df, file)
    }
  )}


## OVC----
mission2_OVC_server <- function(Exesum_m2_OVC, df_m2_OVC_1, output, input){
  ### Executive Summary----
  output$exesum_m2_OVC <- renderUI(Exesum_m2_OVC)
  ### Line Plot----
  output$m2_OVC_lineplot <- renderPlotly({
    p1 <- m2_OVC_render_lineplot(df_m2_OVC_1, input)
    p1
  })
  
  output$m2_OVC_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_OccurencesOfViolentCrime_filteredData.csv",
    content = function(file) {
      df <- m2_OVC_lineplot_data(df_m2_OVC_1)
      write.csv(df, file)
    }
  )}


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



## PRHC----
mission2_PRHC_server <- function(Exesum_m2_PRHC, df_m2_PRHC_1, output, input){
  ### Executive Summary----
  output$exesum_m2_PRHC <- renderUI(Exesum_m2_PRHC)
  ### Line Plot----
  output$m2_PRHC_lineplot <- renderPlotly({
    p1 <- m2_PRHC_render_lineplot(df_m2_PRHC_1, input)
    p1
  })
  
  output$m2_PRHC_lineplot_dwnbtt <- downloadHandler(
    filename = "StrongerBC_Mission6_PoliceReportedHateCrime_filteredData.csv",
    content = function(file) {
      df <- m2_PRHC_lineplot_data(df_m2_PRHC_1)
      write.csv(df, file)
    }
  )}
