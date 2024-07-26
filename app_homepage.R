active_tabs <- list(
  mission1 = TRUE,
              m1_PI =  TRUE,
              m1_CHN = TRUE,
              m1_GC =  TRUE,
              m1_UR =  TRUE,
              m1_FE =  TRUE,
              m1_TS =  TRUE,
              m1_MI =  TRUE,
              m1_SB =  TRUE,
              m1_LE =  TRUE,
              m1_MH =  TRUE,
  mission2 = TRUE,
              m2_NBO = TRUE,
              m2_HA  = TRUE,
              m2_LMPR= TRUE,
              m2_OVC = TRUE,
              m2_GII = TRUE,
              m2_PRHC= TRUE,
  mission3 = TRUE,
  mission4 = TRUE,
  mission5 = TRUE,
              m5_CEG = TRUE,
  mission6 = TRUE,
              m6_RnD = TRUE,
              m6_VAEX= TRUE,
              m6_nRinv= TRUE,
              m6_LP = TRUE,
              m6_EXP = TRUE
)



## load libraries ----
library(tidyverse)
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(plotly)
library(leaflet)
library(sf)
library(gridExtra)
library(waffle)
library(ggplot2)
library(htmlwidgets)


options(scipen = 999999999)  

source_exports <- "BC Stats"

source("Standard-Charts.R")


source("home-ui1.R")

source("mission1-charts.R")
source("mission1-ui.R")
source("mission1-server.R")
source("mission2-charts.R")
source("mission2-ui.R")
source("mission2-server.R")
source("mission5-charts.R")
source("mission5-ui.R")
source("mission5-server.R")

source("mission6-charts.R")
source("mission6-ui.R")
source("ui_m6_RnD.R")
source("mission6-server.R")

source("Executive_summaries.R")


# Loading data ----
canada_map <- load_canada_map()

# Mission 1 ----
if (active_tabs$mission1) {  
  df_m1_UR_1 <- load_m1_UR1()
  df_m1_UR_2 <- load_m1_UR2()
  df_m1_UR_3 <- load_m1_UR3()
  df_m1_UR_4 <- load_m1_UR4()
  df_m1_UR_5 <- load_m1_UR5()
  df_m1_PI_1 <- load_m1_PI1()
  df_m1_PI_2 <- load_m1_PI2()
  df_m1_CHN_1 <- load_m1_CHN1()
  df_m1_GC_1 <- load_m1_GC1()
  df_m1_FE_1 <- load_m1_FE1()
  df_m1_TS_1 <- load_m1_TS1()
  df_m1_MI_1 <- load_m1_MI1()
  df_m1_SB_1 <- load_m1_SB1()
  df_m1_LE_1 <- load_m1_LE1()
  df_m1_MH_1 <- load_m1_MH1()}

# Mission 2 ----
if (active_tabs$mission2) {  
  df_m2_NBO_1 <- load_m2_NBO1()
  df_m2_HA_1 <- load_m2_HA1()
  df_m2_LMPR_1 <- load_m2_LMPR1()
  df_m2_OVC_1 <- load_m2_OVC1()
  df_m2_PRHC_1 <- load_m2_PRHC1()
  df_m2_GII_1 <- load_m2_GII1()}

if (active_tabs$mission5) {  
  df_m5_CEG_1 <- load_m5_CEG1()}
  
if (active_tabs$mission6) {  
  df_m6_RnD_1 <- load_m6_RnD1()
  df_m6_RnD_2 <- load_m6_RnD2()
  df_m6_VAEX_1 <- load_m6_VAEX1()
  df_m6_nRinv_1 <- load_m6_nRinv1()
  df_m6_LP_1 <- load_m6_LP1()
  df_m6_exp_1 <- load_m6_exp1()
  df_m6_exp_2 <- load_m6_exp2()
  df_m6_exp_3 <- load_m6_exp3()
  df_m6_exp_4 <- load_m6_exp4()}



# UI ----
ui <- function() {
  header <- dashboardHeader()
  ## Sidebar ----
  sidebar <- dashboardSidebar(
    collapsed = TRUE,
    sidebarMenu(id = "tabs",
                menuItem("Home", tabName = "home", icon = icon("home")),
                if (active_tabs$mission1) {
                menuItem("Mission 1", tabName = "mission1", icon = icon("bullseye"),
                         menuSubItem("mission1", tabName = "m1_home"),
                         if (active_tabs$m1_PI) menuSubItem("Poverty Incidence", tabName = "PI"),
                         if (active_tabs$m1_CHN) menuSubItem("Core Housing Need", tabName = "CHN"),
                         if (active_tabs$m1_GC) menuSubItem("Gini Coefficient", tabName = "GC"),
                         if (active_tabs$m1_UR) menuSubItem("Underemployment rate", tabName = "UR"),
                         if (active_tabs$m1_FE) menuSubItem("Food Expenditure", tabName = "FE"),
                         if (active_tabs$m1_TS) menuSubItem("Spending on Transportation", tabName = "TS"),
                         # menuSubItem("Income", tabName = "MI"),
                         if (active_tabs$m1_SB) menuSubItem("Sense of Belongings", tabName = "SB"),
                         if (active_tabs$m1_LE) menuSubItem("Life Expectancy", tabName = "LE"),
                         if (active_tabs$m1_MH) menuSubItem("Mental Health", tabName = "MH")
                )},
                if (active_tabs$mission2) {
                menuItem("Mission 2", tabName = "mission2", icon = icon("bullseye"),
                         menuSubItem("mission2", tabName = "m2_home"),
                         if (active_tabs$m2_NBO) menuSubItem("New Business Openings", tabName = "NBO"),
                         if (active_tabs$m2_HA) menuSubItem("Housing Availability", tabName = "HA"),
                         if (active_tabs$m2_LMPR) menuSubItem("Labour Market Participation Rate", tabName = "LMPR"),
                         if (active_tabs$m2_OVC) menuSubItem("Occurances of Violent Crime", tabName = "OVC"),
                         if (active_tabs$m2_GII) menuSubItem("Government Investment in Infrastructure", tabName = "GII"),
                         if (active_tabs$m2_PRHC) menuSubItem("Police_reported Hate Crime", tabName = "PRHC")
                )},
                if (active_tabs$mission3) {
                menuItem("Mission 3", tabName = "mission3", icon = icon("bullseye"))},
                if (active_tabs$mission4) {
                menuItem("Mission 4", tabName = "mission4", icon = icon("bullseye"))},
                if (active_tabs$mission5) {
                menuItem("Mission 5", tabName = "mission5", icon = icon("bullseye"),
                         if (active_tabs$m5_CEG) menuSubItem("Clean Energy Generated", tabName = "CEG")
                )},
                if (active_tabs$mission6) {
                menuItem("Mission 6", tabName = "mission6", icon = icon("bullseye"),
                         menuSubItem("mission6", tabName = "m6_home"),
                         if (active_tabs$m6_RnD) menuSubItem("Investment in Innovation", tabName = "RnD"),
                         if (active_tabs$m6_VAEX) menuSubItem("Value-added Export", tabName = "VAEX"),
                         if (active_tabs$m6_nRinv) menuSubItem("Non-residential Investment", tabName = "nRinv"),
                         if (active_tabs$m6_LP) menuSubItem("Labour productivity", tabName = "LP"),
                         if (active_tabs$m6_EXP) menuSubItem("Export", tabName = "EXP"))},
                menuItem("Data Source", tabName = "data_source", icon = icon("database"))
                
                
    )
  )
  
  body <- dashboardBody(
    do.call(tabItems, c(
      Filter(Negate(is.null), list(
        ### Home tab ----
        ui_home(),
        ## Mission1 ----
        if (active_tabs$mission1)
            {ui_m1_home(m1_PI_lineplot_data(df_m1_PI_1),
                       m1_CHN_lineplot_data(df_m1_CHN_1),
                       m1_GC_lineplot_data(df_m1_GC_1),
                       m1_UR_lineplot_data(df_m1_UR_1),
                       m1_FE_lineplot_data(df_m1_FE_1),
                       m1_TS_lineplot_data(df_m1_TS_1),
                       m1_SB_lineplot_data(df_m1_SB_1),
                       m1_LE_lineplot_data(df_m1_LE_1),
                       m1_MH_lineplot_data(df_m1_MH_1))} else NULL,
        if (active_tabs$mission1 * active_tabs$m1_PI ) ui_m1_PI(df1 = df_m1_PI_1, df2 = df_m1_PI_2) else NULL,
        if (active_tabs$mission1 * active_tabs$m1_UR ) ui_m1_UR(df1 = df_m1_UR_1, df2 = df_m1_UR_2, df3= df_m1_UR_3, df4 = df_m1_UR_4, df5 = df_m1_UR_5) else NULL,
        if (active_tabs$mission1 * active_tabs$m1_CHN ) ui_m1_CHN(df1 = df_m1_CHN_1) else NULL,
        if (active_tabs$mission1 * active_tabs$m1_GC ) ui_m1_GC(df1 = df_m1_GC_1) else NULL,
        if (active_tabs$mission1 * active_tabs$m1_FE ) ui_m1_FE(df1 = df_m1_FE_1) else NULL,
        if (active_tabs$mission1 * active_tabs$m1_TS ) ui_m1_TS(df1 = df_m1_TS_1) else NULL,
        if (active_tabs$mission1 * active_tabs$m1_MI ) ui_m1_MI(df1 = df_m1_MI_1) else NULL,
        if (active_tabs$mission1 * active_tabs$m1_SB ) ui_m1_SB(df1 = df_m1_SB_1) else NULL,
        if (active_tabs$mission1 * active_tabs$m1_LE ) ui_m1_LE(df1 = df_m1_LE_1) else NULL,
        if (active_tabs$mission1 * active_tabs$m1_MH ) ui_m1_MH(df1 = df_m1_MH_1) else NULL,
            # )},

      ### Mission2 ----
      if (active_tabs$mission2)
      ui_m2_home(m2_NBO_lineplot_data(df_m2_NBO_1),
                 m2_HA_lineplot_data(df_m2_HA_1),
                 m2_LMPR_lineplot_data(df_m2_LMPR_1),
                 m2_OVC_lineplot_data(df_m2_OVC_1),
                 m2_GII_lineplot_data(df_m2_GII_1),
                 m2_PRHC_lineplot_data(df_m2_PRHC_1)) else NULL,

      if (active_tabs$mission2 * active_tabs$m2_NBO ) ui_m2_NBO(df_m2_NBO_1) else NULL,
      if (active_tabs$mission2 * active_tabs$m2_HA ) ui_m2_HA(df_m2_HA_1) else NULL,
      if (active_tabs$mission2 * active_tabs$m2_LMPR ) ui_m2_LMPR(df_m2_LMPR_1) else NULL,
      if (active_tabs$mission2 * active_tabs$m2_OVC ) ui_m2_OVC(df_m2_OVC_1) else NULL,
      if (active_tabs$mission2 * active_tabs$m2_PRHC ) ui_m2_PRHC(df_m2_PRHC_1) else NULL,
      if (active_tabs$mission2 * active_tabs$m2_GII ) ui_m2_GII(df_m2_GII_1) else NULL,

      ## Mission5 ----
      if (active_tabs$mission5) ui_m5_CEG(df_m5_CEG_1) else NULL,
      # Mission6 ----
      if (active_tabs$mission6)
      ui_m6_home(m6_RnD_lineplot_data(df_m6_RnD_1),
                 m6_VAEX_lineplot_data(df_m6_VAEX_1),
                 m6_nRinv_lineplot_data(df_m6_nRinv_1),
                 m6_LP_lineplot_data(df_m6_LP_1),
                 m6_exp_lineplot_data(df_m6_exp_1)) else NULL,
      if (active_tabs$mission6 * active_tabs$m6_RnD ) ui_m6_RnD(df_m6_RnD_1, df_m6_RnD_2) else NULL,
      if (active_tabs$mission6 * active_tabs$m6_VAEX ) ui_m6_VAEX(df_m6_VAEX_1) else NULL,
      if (active_tabs$mission6 * active_tabs$m6_nRinv ) ui_m6_nRinv(df_m6_nRinv_1) else NULL,
      if (active_tabs$mission6 * active_tabs$m6_LP ) ui_m6_LP(df_m6_LP_1) else NULL,
      if (active_tabs$mission6 * active_tabs$m6_EXP ) ui_m6_exp(df_m6_exp_1, df_m6_exp_3) else NULL,
      #### Data Source Tab----
      tabItem(tabName = "data_source",
              h3("Data Sources & Permissions", style="margin-left:15px;margin-bottom:20px"))
    ) ))
  )) # This closes dashboard body
  
  ## UI environment ----
  ui <- tagList(
    tags$header(class="header", style="background-color:#003366; border-bottom:2px solid #fcba19;
              padding:0 0px 0 0px; display:flex; height:60px;width:100%;",
                tags$div(class="banner", style="display:flex; justify-content:flex-start; align-items:center;  margin: 0 10px 0 10px",
                         a(href="https://www2.gov.bc.ca/gov/content/data/about-data-management/bc-stats",
                           img(src = 'https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/main/bc_logo.svg', title = "StrongerBC", height = "10px", alt = "British Columbia - StrongerBC"),
                           onclick="gtag"
                         ),
                         h1("StrongerBC Indicators", style = "font-weight:400; color:white; margin: 5px 5px 0 18px;"),
                         h2("Work in progress, subject to change!", style = "font-size: 16px; color: white; margin: 0 5px 5px 18px;")
                )
    ),
    dashboardPage(header = header, sidebar = sidebar, body = body, skin = "blue"),
    column(width = 12,
           style = "background-color:#003366; border-top:2px solid #fcba19;",
           tags$footer(class="footer",
                       tags$div(class="container", style="display:flex; justify-content:center; flex-direction:column; text-align:center; height:46px;",
                                tags$ul(style="display:flex; flex-direction:row; flex-wrap:wrap; margin:0; list-style:none; align-items:center; height:100%;",
                                        tags$li(a(href="https://www2.gov.bc.ca/gov/content/home", "Home", style="font-size:1em; font-weight:normal; color:white; padding-left:5px; padding-right:5px; border-right:1px solid #4b5e7e;")),
                                        tags$li(a(href="https://www2.gov.bc.ca/gov/content/home/disclaimer", "Disclaimer", style="font-size:1em; font-weight:normal; color:white; padding-left:5px; padding-right:5px; border-right:1px solid #4b5e7e;"))
                                        
                                )
                       )
           )
    ))
  
  
  
}

# Server----
server <- function(input, output, session) {
  ##HOMEPAGE----
  observeEvent(input$button1, {
    updateTabItems(session, "tabs", selected = "m1_home")})
  observeEvent(input$button2, {
    updateTabItems(session, "tabs", selected = "m2_home")})
  observeEvent(input$button3, {
    updateTabItems(session, "tabs", selected = "mission3")})
  observeEvent(input$button4, {
    updateTabItems(session, "tabs", selected = "mission4")})
  observeEvent(input$button5, {
    updateTabItems(session, "tabs", selected = "mission5")})
  observeEvent(input$button6, {
    updateTabItems(session, "tabs", selected = "m6_home")})
  
  ##Mission1----

  if (active_tabs$mission1){
  
  observeEvent(input$m1_PI_Button, {
    updateTabItems(session, "tabs", selected = "PI")})
  observeEvent(input$m1_CHN_Button, {
    updateTabItems(session, "tabs", selected = "CHN")})
  observeEvent(input$m1_GC_Button, {
    updateTabItems(session, "tabs", selected = "GC")})
  observeEvent(input$m1_UR_Button, {
    updateTabItems(session, "tabs", selected = "UR")})
  observeEvent(input$m1_FE_Button, {
    updateTabItems(session, "tabs", selected = "FE")})
  observeEvent(input$m1_TS_Button, {
    updateTabItems(session, "tabs", selected = "TS")})
  observeEvent(input$m1_SB_Button, {
    updateTabItems(session, "tabs", selected = "SB")})
  observeEvent(input$m1_LE_Button, {
    updateTabItems(session, "tabs", selected = "LE")})
  observeEvent(input$m1_MH_Button, {
    updateTabItems(session, "tabs", selected = "MH")})
  server_m1_home(df_m1_PI_1, df_m1_CHN_1,df_m1_GC_1, 
                 df_m1_UR_1, df_m1_FE_1, df_m1_TS_1,
                 df_m1_SB_1, df_m1_LE_1, df_m1_MH_1,
                 output, input, session)
  mission1_PI_server(Exesum_m1_PI_main, Exesum_m1_PI, df1 = df_m1_PI_1, df2 = df_m1_PI_2, output, input)
  mission1_UR_server(Exesum_m1_UR_main, Exesum_m1_UR, df1 = df_m1_UR_1, df2 = df_m1_UR_2, df3 = df_m1_UR_3, df4 = df_m1_UR_4, df5 = df_m1_UR_5, output, input)
  mission1_CHN_server(Exesum_m1_CHN_main, Exesum_m1_CHN, df1 = df_m1_CHN_1, output, input)
  mission1_GC_server(Exesum_m1_GC_main, Exesum_m1_GC, df1 = df_m1_GC_1, output, input)
  mission1_FE_server(Exesum_m1_FE_main, Exesum_m1_FE, df1 = df_m1_FE_1, output, input)
  mission1_TS_server(Exesum_m1_TS_main, Exesum_m1_TS, df1 = df_m1_TS_1, output, input)
  mission1_MI_server(Exesum_m1_MI_main, Exesum_m1_MI, df1 = df_m1_MI_1, output, input)
  mission1_SB_server(Exesum_m1_SB_main, Exesum_m1_SB, df1 = df_m1_SB_1, output, input)
  mission1_LE_server(Exesum_m1_LE_main, Exesum_m1_LE, df1 = df_m1_LE_1, output, input)
  mission1_MH_server(Exesum_m1_MH_main, Exesum_m1_MH, df1 = df_m1_MH_1, output, input)
}
  
  if (active_tabs$mission2){
    
  observeEvent(input$m2_NBO_Button, {
    updateTabItems(session, "tabs", selected = "NBO")})
  observeEvent(input$m2_HA_Button, {
    updateTabItems(session, "tabs", selected = "HA")})
  observeEvent(input$m2_LMPR_Button, {
    updateTabItems(session, "tabs", selected = "LMPR")})
  observeEvent(input$m2_OVC_Button, {
    updateTabItems(session, "tabs", selected = "OVC")})
  observeEvent(input$m2_PRHC_Button, {
    updateTabItems(session, "tabs", selected = "PRHC")})
  observeEvent(input$m2_GII_Button, {
    updateTabItems(session, "tabs", selected = "GII")})
  
  server_m2_home(df_m2_NBO_1, df_m2_HA_1, df_m2_LMPR_1, 
                 df_m2_OVC_1, df_m2_GII_1, df_m2_PRHC_1, 
                 output, input, session)
  mission2_NBO_server(Exesum_m2_NBO, df_m2_NBO_1, output, input)
  mission2_HA_server(Exesum_m2_HA, df_m2_HA_1, output, input)
  mission2_LMPR_server(Exesum_m2_LMPR, df_m2_LMPR_1, output, input)
  mission2_OVC_server(Exesum_m2_OVC, df_m2_OVC_1, output, input)
  mission2_PRHC_server(Exesum_m2_PRHC, df_m2_PRHC_1, output, input)
  mission2_GII_server(Exesum_m2_GII, df_m2_GII_1, output, input)}

  if (active_tabs$mission5){
  mission5_CEG_server(Exesum_m5_CEG, df_m5_CEG_1, output, input)}

  if (active_tabs$mission6){
  observeEvent(input$m6_RnD_Button, {
    updateTabItems(session, "tabs", selected = "RnD")})
  observeEvent(input$m6_VAEX_Button, {
    updateTabItems(session, "tabs", selected = "VAEX")})
  observeEvent(input$m6_nRinv_Button, {
    updateTabItems(session, "tabs", selected = "nRinv")})
  observeEvent(input$m6_LP_Button, {
    updateTabItems(session, "tabs", selected = "LP")})
  observeEvent(input$m6_EXP_Button, {
    updateTabItems(session, "tabs", selected = "EXP")})
  
  server_m6_home(df_m6_RnD_1, df_m6_LP_1, df_m6_VAEX_1, df_m6_nRinv_1, df_m6_exp_1, output, input, session)
  mission6_RnD_server( Exesum_m6_RnD_main,Exesum_m6_RnD, df_m6_RnD_1, df_m6_RnD_2, output, input)
  mission6_VAEX_server(Exesum_m6_VAEX_main, Exesum_m6_VAEX, df_m6_VAEX_1, output, input)
  mission6_nRinv_server(Exesum_m6_nRinv_main, Exesum_m6_nRinv, df_m6_nRinv_1, output, input)
  mission6_LP_server(Exesum_m6_LP_main, Exesum_m6_LP, df_m6_LP_1, output, input)
  mission6_exp_server(Exesum_m6_exp_main, Exesum_m6_exp, df_m6_exp_1, df_m6_exp_2, df_m6_exp_3, df_m6_exp_4, output, input)
  }}
  
shinyApp(ui, server)
