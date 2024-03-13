## load libraries ----
library(tidyverse)
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(plotly)
library(leaflet)
library(sf)
library(gridExtra)

options(scipen = 999999999)  

source_exports <- "BC Stats"

source("home-ui.R")

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
source("mission6-server.R")

source("Executive_summaries.R")


# Loading data ----
canada_map <- load_canada_map()

df_m1_UR_1 <- load_m1_UR1()
df_m1_UR_2 <- load_m1_UR2()
df_m1_UR_3 <- load_m1_UR3()


df_m2_GII_1 <- load_m2_GII1()

df_m5_CEG_1 <- load_m5_CEG1()

df_m6_RnD_1 <- load_m6_RnD1()
df_m6_RnD_2 <- load_m6_RnD2()
df_m6_VAEX_1 <- load_m6_VAEX1()
df_m6_nRinv_1 <- load_m6_nRinv1()
df_m6_lp_1 <- load_m6_lp1()
df_m6_exp_1 <- load_m6_exp1()
df_m6_exp_2 <- load_m6_exp2()
df_m6_exp_3 <- load_m6_exp3()
df_m6_exp_4 <- load_m6_exp4()



# UI ----
ui <- function() {
  header <- dashboardHeader()
  ## Sidebar ----
  sidebar <- dashboardSidebar(
    collapsed = TRUE,
    sidebarMenu(id = "tabs",
                menuItem("Home", tabName = "home", icon = icon("home")),
                menuItem("Mission 1", tabName = "mission1", icon = icon("bullseye"),
                         menuSubItem("Unemploymnet Rate", tabName = "UR")
                         ),
                menuItem("Mission 2", tabName = "mission2", icon = icon("bullseye"),
                         menuSubItem("Government Investment in Infrastructure", tabName = "GII")
                         ),
                menuItem("Mission 3", tabName = "mission3", icon = icon("bullseye")),
                menuItem("Mission 4", tabName = "mission4", icon = icon("bullseye")),
                menuItem("Mission 5", tabName = "mission5", icon = icon("bullseye"),
                         menuSubItem("Clean Energy Generated", tabName = "CEG")
                         ),
                menuItem("Mission 6", tabName = "mission6", icon = icon("bullseye"),
                         menuSubItem("Investment in Innovation", tabName = "RnD"),
                         menuSubItem("Value-added Export", tabName = "VAEX"),
                         menuSubItem("Non-residential Investment", tabName = "nRinv"),
                         menuSubItem("Labour productivity", tabName = "LP"),
                         menuSubItem("Export", tabName = "EXP")),
                menuItem("Data Source", tabName = "data_source", icon = icon("database"))
                
                
    )
  )
    body <- dashboardBody(
      tabItems(
        ### Home tab ----
        ui_m6_home(),
        ### Mission1 ----
        ui_m1_UR(df_m1_UR_1,df_m1_UR_2,df_m1_UR_3),
        ### Mission2 ----
        ui_m2_GII(df_m2_GII_1),
        ### Mission5 ----
        ui_m5_CEG(df_m5_CEG_1),
        ### Mission6 ----
        ui_m6_RnD(df_m6_RnD_1, df_m6_RnD_2),
        ui_m6_VAEX(df_m6_VAEX_1),
        ui_m6_nRinv(df_m6_nRinv_1),
        ui_m6_lp(df_m6_lp_1),
        ui_m6_exp(df1 = df_m6_exp_1, df3 = df_m6_exp_3),
       #### Data Source Tab----
        tabItem(tabName = "data_source",
                h3("Data Sources & Permissions", style="margin-left:15px;margin-bottom:20px")
                )
             ) 
          ) # This closes dashboard body
    
    ## UI environment ----
    ui <- tagList(
      tags$header(class="header", style="background-color:#003366; border-bottom:2px solid #fcba19;
              padding:0 0px 0 0px; display:flex; height:80px;width:100%;",
                  tags$div(class="banner", style="display:flex; justify-content:flex-start; align-items:center;  margin: 0 10px 0 10px",
                           a(href="https://www2.gov.bc.ca/gov/content/data/about-data-management/bc-stats",
                             img(src = 'https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/main/bc_logo.svg', title = "StrongerBC", height = "40px", alt = "British Columbia - StrongerBC"),
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
      )
    )
    
    
}

# Server----
server <- function(input, output, session) {
  
  observeEvent(input$button6, {
    updateTabItems(session, "tabs", selected = "RnD")
  })
  
  mission1_UR_server(Exesum_m1_UR, df_m1_UR_1, df_m1_UR_2, df_m1_UR_3, output, input)
  
  mission2_GII_server(Exesum_m2_GII, df_m2_GII_1, output, input)
  
  mission5_CEG_server(Exesum_m5_CEG, df_m5_CEG_1, output, input)
  
  mission6_RnD_server(Exesum_m6_RnD, df_m6_RnD_1, df_m6_RnD_2, output, input)
  mission6_VAEX_server(Exesum_m6_VAEX, df_m6_VAEX_1, output, input)
  mission6_nRinv_server(Exesum_m6_nRinv, df_m6_nRinv_1, output, input)
  mission6_lp_server(Exesum_m6_lp, df_m6_lp_1, output, input)
  mission6_exp_server(Exesum_m6_exp, df_m6_exp_1, df_m6_exp_2, df_m6_exp_3, df_m6_exp_4, output, input)

}
shinyApp(ui, server)
