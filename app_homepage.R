## load libraries ----
library(tidyverse)
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(plotly)
library(leaflet)
library(sf)


options(scipen = 999999999)  

source_exports <- "BC Stats"

source("mission5.R")
source("mission6.R")
source("Executive_summaries.R")


# Loading data ----
canada_map <- load_canada_map()
df_m6_RnD_1 <- load_m6_RnD1()
df_m6_RnD_2 <- load_m6_RnD2()
df_m6_VAEX_1 <- load_m6_VAEX1()
df_m6_nRinv_1 <- load_m6_nRinv1()
df_m6_lp_1 <- load_m6_lp1()
df_m6_exp_1 <- load_m6_exp1()
df_m6_exp_2 <- load_m6_exp2()
df_m6_exp_3 <- load_m6_exp3()



# UI ----
ui <- function() {
  
  header <- dashboardHeader()
## Sidebar ----
sidebar <- dashboardSidebar(
  sidebarMenu(id = "tabs",
              menuItem("Home", tabName = "home", icon = icon("home")),
              menuItem("Mission 1", tabName = "mission1", icon = icon("bullseye")),
              menuItem("Mission 2", tabName = "mission2", icon = icon("bullseye")),
              menuItem("Mission 3", tabName = "mission3", icon = icon("bullseye")),
              menuItem("Mission 4", tabName = "mission4", icon = icon("bullseye")),
              menuItem("Mission 5", tabName = "mission5", icon = icon("bullseye")),
              menuItem("Mission 6", tabName = "mission6", icon = icon("bullseye"),
                       menuSubItem("Investment in Innovation", tabName = "RnD"),
                       menuSubItem("Value-added Export", tabName = "VAEX"),
                       menuSubItem("Non-residential Investment", tabName = "nRinv"),
                       menuSubItem("Labour productivity", tabName = "LP"),
                       menuSubItem("Export", tabName = "EXP")),
              menuItem("Data Source", tabName = "data_source", icon = icon("database"))
              
              
  )
)

## Body ----
style1 <- style1 <- style1 <- "background-color:#B0C4DE; height: 300px; padding: 10px; border-radius: 10px; border: 5px solid #ecf0f5;"
style2 <- "background-color:#337AB7; color:white;"

body <- dashboardBody(
  tabItems(
    ### Home tab ----
    tabItem(tabName = "home",
            fluidRow(
              column(width = 4,
                     style = style1, 
                     h3(strong("MISSION 1:"), br(), "Supporting people and families"),
                     p (
                       HTML("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <strong>1234 Ut</strong> enim ad minim veniam.")
                     ),
                     div(
                       actionButton("button1", "Explore further", icon = icon("line-chart"), style = style2),
                       style = "position: absolute; bottom: 5px; left: 5px;"  
                     )              ),
              column(width = 4, 
                     style = style1,
                     h3(strong("MISSION 2:"), br(), "Building resilient communities"),
                     p (
                       HTML("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <strong>1234 Ut</strong> enim ad minim veniam.")
                     ),
                     div(
                       actionButton("button1", "Explore further", icon = icon("line-chart"), style = style2),
                       style = "position: absolute; bottom: 5px; left: 5px;"  
                     )              ),
              column(width = 4,
                     style = style1,
                     h3(strong("MISSION 3:"), br(), "Advancing true, lasting and meaningful reconciliation with Indigenous Peoples"),
                     p (
                       HTML("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <strong>1234 Ut</strong> enim ad minim veniam.")
                     ),
                     div(
                       actionButton("button1", "Explore further", icon = icon("line-chart"), style = style2),
                       style = "position: absolute; bottom: 5px; left: 5px;"  
                     )              )
            ),
            fluidRow(
              column(width =4,
                     style=style1,
                     h3(strong("MISSION 4:"), br(), "Meeting B.C.’s climate commitments"),
                     p (
                       HTML("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <strong>1234 Ut</strong> enim ad minim veniam.")
                     ),
                     div(
                       actionButton("button1", "Explore further", icon = icon("line-chart"), style = style2),
                       style = "position: absolute; bottom: 5px; left: 5px;"  
                     )              ),
              column (width=4,
                      style=style1,
                      h3(strong("MISSION 5:"), br(), "Leading on environmental and social responsibility"),
                      p (
                        HTML("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <strong>1234 Ut</strong> enim ad minim veniam.")
                      ),
                      div(
                        actionButton("button1", "Explore further", icon = icon("line-chart"), style = style2),
                        style = "position: absolute; bottom: 5px; left: 5px;"  
                      )              ),
              column (width=4,
                      style=style1,
                      h3(strong("MISSION 6:"), br(), "Fostering innovation throughout B.C.'s economy"),
                      p (
                        HTML("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. <strong>1234 Ut</strong> enim ad minim veniam.")
                        ),
                      div(
                        actionButton("button1", "Explore further", icon = icon("line-chart"), style = style2),
                        style = "position: absolute; bottom: 5px; left: 5px;"  
                      )
              )
            )
    ),
    ### Mission5 ----
    tabItem(tabName = "mission5",
            mission5_ui
            ),
      #### RnD ----
      tabItem(tabName = "RnD",
              ##### Line Plot----
              fluidPage(
                style = "background-color: white;margin: 20px;",
                fluidRow(
                  column(9, h3("Figure 6-1-1: Private sector investment in innovation " ))
                ),
                fluidRow(
                  column(9,plotlyOutput("m6_RnD_lineplot")),
                  column(3, 
                       selectInput("m6_RnD_lineplot_geo", "Region", choices = unique(df_m6_RnD_1$GEO), selected = "British Columbia"), 
                       selectInput("m6_RnD_lineplot_prices", "Price type", choices = unique(df_m6_RnD_1$Prices)), 
                       selectInput("m6_RnD_lineplot_science_type", "Science Type", choices = unique(df_m6_RnD_1$Science.type)),
                       selectInput("m6_RnD_lineplot_funder", "Funder", choices = unique(df_m6_RnD_1$Funder), selected = " business enterprise sector"),
                       selectInput("m6_RnD_lineplot_performer", "Performer", choices = unique(df_m6_RnD_1$Performer))
              )    )),
              ##### EXESUM ----
              fluidPage(
                style = "background-color: aliceblue ; margin: 20px;",
                fluidRow(
                  column(12, h2("Executive Summary"))
                ),
                fluidRow(
                  column(12, uiOutput("exesum_m6_RnD"))
                )
              ),
              ##### Bar Plot ----
              fluidPage(
                style = "background-color: white;margin: 20px;",
                fluidRow(
                  column(9, h3("Figure 6-1-2: Funding flows in B.C." ))
                ),
                fluidRow(
                  column(9,plotlyOutput("m6_RnD_barplot")),
                  column(3, 
                         selectInput("m6_RnD_barplot_year", "Year", choices = unique(df_m6_RnD_2$Year), selected = max(df_m6_RnD_2$Year))
                  )    )),
              ##### Table ----
              fluidPage(
                style = "background-color: white;margin: 20px;",
                fluidRow(
                  column(9, h3("Figure 6-1-3: Research and Development Spending Growth" ))
                ),
                fluidRow(
                  column(9,DT::dataTableOutput("m6_RnD_table")),
                  column(3, 
                         selectInput("m6_RnD_table_prices", "Price type", choices = unique(df_m6_RnD_1$Prices)), 
                         selectInput("m6_RnD_table_science_type", "Science Type", choices = unique(df_m6_RnD_1$Science.type)),
                         selectInput("m6_RnD_table_funder", "Funder", choices = unique(df_m6_RnD_1$Funder), selected = " business enterprise sector"),
                         selectInput("m6_RnD_table_performer", "Performer", choices = unique(df_m6_RnD_1$Performer)),
                         selectInput("m6_RnD_table_year", "Year", choices = unique(df_m6_RnD_1$Year), selected = max(df_m6_exp_1$Year))
                )    )),
              ##### Sankey Plot ----
              fluidPage(
                style = "background-color: white;margin: 20px;",
                fluidRow(
                  column(9, h3("Figure 6-1-4: R&D intensity " ))
                ),
                fluidRow(
                  column(9,plotlyOutput("m6_RnD_sankey")),
                  column(3, 
                         selectInput("m6_RnD_sankey_geo", "Region", choices = unique(df_m6_RnD_1$GEO), selected = "British Columbia"), 
                         selectInput("m6_RnD_sankey_science_type", "Science Type", choices = unique(df_m6_RnD_1$Science.type)),
                         selectInput("m6_RnD_sankey_year", "Year", choices = unique(df_m6_RnD_1$Year), selected = 2020)
                  )    ))
              
              ),
      #### VAEX ----
      tabItem(tabName = "VAEX",
              ##### Line Plot----
              fluidPage(
                style = "background-color: white;margin: 20px;",
                fluidRow(
                  column(9, h3("Figure 6-2-1: The trend of value added export" ))
                ),
                fluidRow(
                  column(9,plotlyOutput("m6_VAEX_lineplot")),
                  column(3, 
                         selectInput("m6_VAEX_lineplot_geo", "Region", choices = unique(df_m6_VAEX_1$GEO), selected = "British Columbia"))
                  )),
              ##### EXESUM ----
              fluidPage(
                style = "background-color: aliceblue ; margin: 20px;",
                fluidRow(
                  column(12, h2("Executive Summary"))
                ),
                fluidRow(
                  column(12, uiOutput("exesum_m6_VAEX"))
                )
              ),
              ##### Bar Plot ----
              fluidPage(
                style = "background-color: white;margin: 20px;",
                fluidRow(
                  column(9, h3("Figure 6-2-2: Value-added exports by industry in B.C." ))
                ),
                fluidRow(
                  column(9,plotlyOutput("m6_VAEX_barplot")),
                  column(3, 
                         selectInput("m6_VAEX_barplot_year", "Year", choices = unique(df_m6_VAEX_1$Year), selected = 2019),
                         selectInput("m6_VAEX_barplot_industry", "Industry", choices = unique(df_m6_VAEX_1$Industry), selected = "Total industries")
                         
                  )    )),
              ##### Pie Chart ----
              fluidPage(
                style = "background-color: white;margin: 20px;",
                fluidRow(
                  column(9, h3("Figure 62-3: Value-added exports GDP contribution" ))
                ),
                fluidRow(
                  column(9,plotlyOutput("m6_VAEX_pie")),
                  column(3, 
                         selectInput("m6_VAEX_pie_geo", "Region", choices = unique(df_m6_VAEX_1$GEO), selected = "British Columbia"),
                         selectInput("m6_VAEX_pie_year", "Year", choices = unique(df_m6_RnD_1$Year), selected = 2019)
                  )    ))
              
      ),
      #### Non residential investment ----
      tabItem(tabName = "nRinv",
              ##### Line Plot----
              fluidPage(
                style = "background-color: white;margin: 20px;",
                fluidRow(
                  column(9, h3("Figure 6-3-1: TBD" ))
                ),
                fluidRow(
                  column(9,plotlyOutput("m6_nRinv_lineplot")),
                  column(3, 
                         selectInput("m6_nRinv_lineplot_geo", "Region", choices = unique(df_m6_nRinv_1$GEO), selected = "British Columbia"),
                         selectInput("m6_nRinv_lineplot_item", "Item", choices = unique(df_m6_nRinv_1$Estimates)),
                         selectInput("m6_nRinv_lineplot_prices", "Price Type", choices = unique(df_m6_nRinv_1$Prices)))
                )),
              ##### EXESUM ----
              fluidPage(
                style = "background-color: aliceblue ; margin: 20px;",
                fluidRow(
                  column(12, h2("Executive Summary"))
                ),
                fluidRow(
                  column(12, uiOutput("exesum_m6_nRinv"))
                )
              ),
              ##### Lines plot ----
              fluidPage(
                style = "background-color: white;margin: 20px;",
                fluidRow(
                  column(9, h3("Figure 6-3-2: TBD" ))
                ),
                fluidRow(
                  column(9,plotlyOutput("m6_nRinv_lines")),
                  column(3,
                         selectInput("m6_nRinv_lines_geo", "Region", choices = unique(df_m6_nRinv_1$GEO), selected = "British Columbia"),
                         selectInput("m6_nRinv_lines_prices", "Price Type", choices = unique(df_m6_nRinv_1$Prices))
                  )    )),
              ##### Bar Plot ----
              fluidPage(
                style = "background-color: white;margin: 20px;",
                fluidRow(
                  column(9, h3("Figure 6-3-3: TBD" ))
                ),
                fluidRow(
                  column(9,plotlyOutput("m6_nRinv_barplot")),
                  column(3, 
                         selectInput("m6_nRinv_barplot_year", "Year", choices = unique(df_m6_nRinv_1$Year), selected = 2019),
  
                  )    ))
              
      ),
      #### Labour Productivity ----
      tabItem(tabName = "LP",
              ##### Line Plot----
              fluidPage(
                style = "background-color: white;margin: 20px;",
                fluidRow(
                  column(9, h3("Figure 6-4-1: TBD" ))
                ),
                fluidRow(
                  column(9,plotlyOutput("m6_lp_lineplot")),
                  column(3, 
                         selectInput("m6_lp_lineplot_geo", "Region", choices = unique(df_m6_lp_1$GEO), selected = "British Columbia"),
                         selectInput("m6_lp_lineplot_industry", "Industry", choices = unique(df_m6_lp_1$Industry)),
                         selectInput("m6_lp_lineplot_labourtype", "Labour Productivity Measure", choices = unique(df_m6_lp_1$Labour.productivity.and.related.measures)))
                )),
              ##### EXESUM ----
              fluidPage(
                style = "background-color: aliceblue ; margin: 20px;",
                fluidRow(
                  column(12, h2("Executive Summary"))
                ),
                fluidRow(
                  column(12, uiOutput("exesum_m6_lp"))
                )
              ),
              ##### Lines Plot----
              fluidPage(
                style = "background-color: white;margin: 20px;",
                fluidRow(
                  column(9, h3("Figure 6-4-2: TBD" ))
                ),
                fluidRow(
                  column(9,plotlyOutput("m6_lp_lines")),
                  column(3, 
                         selectInput("m6_lp_lines_geo", "Region", choices = unique(df_m6_lp_1$GEO), selected = "British Columbia"),
                         selectInput("m6_lp_lines_labourtype", "Labour Productivity Measure", choices = unique(df_m6_lp_1$Labour.productivity.and.related.measures)))
                )),
              ##### Treemap Plot----
              fluidPage(
                style = "background-color: white;margin: 20px;",
                fluidRow(
                  column(9, h3("Figure 6-4-3: TBD" ))
                ),
                fluidRow(
                  column(9,plotlyOutput("m6_lp_treemap")),
                  column(3, 
                         selectInput("m6_lp_treemap_geo", "Region", choices = unique(df_m6_lp_1$GEO), selected = "British Columbia"),
                         selectInput("m6_lp_treemap_year", "Year", choices = unique(df_m6_lp_1$Year), selected = 2020))
                )),
              ##### Table----
              fluidPage(
                style = "background-color: white;margin: 20px;",
                fluidRow(
                  column(9, h3("Figure 6-4-4: TBD" ))
                ),
                fluidRow(
                  column(9,DT::dataTableOutput("m6_lp_table")),
                  column(3, 
                         selectInput("m6_lp_table_year", "Year", choices = unique(df_m6_lp_1$Year), selected = 2020),
                         selectInput("m6_lp_table_labourtype", "Labour Productivity Measure", choices = unique(df_m6_lp_1$Labour.productivity.and.related.measures)),
                         selectInput("m6_lp_table_industry", "Industry", choices = unique(df_m6_lp_1$Industry))
                  )
                )),
              ##### Map----
              fluidPage(
                style = "background-color: white;margin: 20px;",
                fluidRow(
                  column(9, h3("Figure 6-4-5: TBD" ))
                ),
                fluidRow(
                  column(9,leafletOutput("m6_lp_map")),
                  column(3, 
                         selectInput("m6_lp_map_year", "Year", choices = unique(df_m6_lp_1$Year), selected = 2020),
                         selectInput("m6_lp_map_labourtype", "Labour Productivity Measure", choices = unique(df_m6_lp_1$Labour.productivity.and.related.measures)),
                         selectInput("m6_lp_map_industry", "Industry", choices = unique(df_m6_lp_1$Industry))
                  )
                ))),
     #### EXP ----
          tabItem(tabName = "EXP",
              ##### Line Plot----
                      fluidPage(
                        style = "background-color: white;margin: 20px;",
                        fluidRow(
                          column(9, h3("Figure 6-5-1: TBD" ))
                        ),
                        fluidRow(
                          column(9,plotlyOutput("m6_exp_lineplot")),
                          column(3, 
                                 selectInput("m6_exp_lineplot_geo", "Region", choices = unique(df_m6_exp_1$GEO), selected = "British Columbia"),
                                 selectInput("m6_exp_lineplot_exptype", "Export Measuremnet", choices = unique(df_m6_exp_1$EXP_type))
                        ))),
              ##### EXESUM ----
                  fluidPage(
                    style = "background-color: aliceblue ; margin: 20px;",
                    fluidRow(
                      column(12, h2("Executive Summary"))
                    ),
                    fluidRow(
                      column(12, uiOutput("exesum_m6_exp"))
                    )
                  ),
              ##### Heatmap Plot----
                  fluidPage(
                    style = "background-color: white;margin: 20px;",
                    fluidRow(
                      column(9, h3("Figure 6-5-2: TBD" ))
                    ),
                    fluidRow(
                      column(9,plotlyOutput("m6_exp_heatmap")),
                      column(3, 
                             # selectInput("m6_exp_lineplot_exptype", "Export Measuremnet", choices = unique(df_m6_exp_1$EXP_type))
                      ))),
              #### Stacked Bar----
                fluidPage(
                  style = "background-color: white;margin: 20px;",
                  fluidRow(
                    column(9, h3("Figure 6-5-4: TBD" ))
                  ),
                  fluidRow(
                    column(9,plotlyOutput("m6_exp_stackbar")),
                    column(3, 
                           # selectInput("m6_exp_lineplot_exptype", "Export Measuremnet", choices = unique(df_m6_exp_1$EXP_type))
                    ))),
              
      ),
   #### Data Source Tab----
    tabItem(tabName = "data_source",
            h3("Data Sources & Permissions", style="margin-left:15px;margin-bottom:20px"))
  )
)

ui <- tagList(
  tags$header(class="header", style="background-color:#003366; border-bottom:2px solid #fcba19;
              padding:0 0px 0 0px; display:flex; height:80px;width:100%;",
              tags$div(class="banner", style="display:flex; justify-content:flex-start; align-items:center;  margin: 0 10px 0 10px",
                       a(href="https://www2.gov.bc.ca/gov/content/data/about-data-management/bc-stats",
                         img(src = 'https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/main/logo.png', title = "StrongerBC", height = "40px", alt = "British Columbia - StrongerBC"),
                         onclick="gtag"
                       ),
                       h1("StrongerBC Indicators", style="font-weight:400; color:white; margin: 5px 5px 0 18px;")
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
  # m6 ----
    ## RnD----
      ### Executive Summary----
      output$exesum_m6_RnD <- renderUI(Exesum_m6_RnD)
      ### Line Plot----
      output$m6_RnD_lineplot <- renderPlotly({
        p1 <- m6_RnD_render_lineplot(df_m6_RnD_1, input)
        p1
      })
        
      ### Bar Plot----
      output$m6_RnD_barplot <- renderPlotly({
        p1 <- m6_RnD_render_barplot(df_m6_RnD_2, input)
        p1
      })
      
      ### Table----
      output$m6_RnD_table <- DT::renderDataTable({
        p1 <- m6_RnD_render_table(df_m6_RnD_1, input)
        p1
      })
      
      ### Sankey Plot----
      output$m6_RnD_sankey <- renderPlotly({
        p1 <- m6_RnD_render_sankey(df_m6_RnD_1, input)
        p1
      })
      
    ## VAEX----
      ### Executive Summary----
      output$exesum_m6_VAEX <- renderUI(Exesum_m6_RnD)
      ### Line plot----
      output$m6_VAEX_lineplot <- renderPlotly({
        p1 <- m6_VAEX_render_lineplot(df_m6_VAEX_1, input)
        p1
      })
      ### Bar plot ----
      output$m6_VAEX_barplot <- renderPlotly({
        p1 <- m6_VAEX_render_barplot(df_m6_VAEX_1, input)
        p1
      })
      ### Pie plot----
      output$m6_VAEX_pie <- renderPlotly({
        p1 <- m6_VAEX_render_pie(df_m6_VAEX_1, input)
        p1
      })
    ## non-residential Investment----
      ### Executive Summary----
      output$exesum_nRinv <- renderUI(Exesum_m6_RnD)
      ### Line plot----
      output$m6_nRinv_lineplot <- renderPlotly({
        p1 <- m6_nRinv_render_lineplot(df_m6_nRinv_1, input)
        p1
      })
      ### Lines plot----
      output$m6_nRinv_lines <- renderPlotly({
        p1 <- m6_nRinv_render_lines(df_m6_nRinv_1, input)
        p1
      })
      ### Bar plot----
      output$m6_nRinv_barplot <- renderPlotly({
        p1 <- m6_nRinv_render_barplot(df_m6_nRinv_1, input)
        p1
      })
    ## labour Productivity----
      ### Executive Summary----
      output$exesum_m6_lp <- renderUI(Exesum_m6_RnD)
      ### Line plot----
      output$m6_lp_lineplot <- renderPlotly({
        p1 <- m6_lp_render_lineplot(df_m6_lp_1, input)
        p1
      })
      ### Lines plot----
      output$m6_lp_lines <- renderPlotly({
        p1 <- m6_lp_render_lines(df_m6_lp_1, input)
        p1
      })
      ### Treemap plot----
      output$m6_lp_treemap <- renderPlotly({
        p1 <- m6_lp_render_treemap(df_m6_lp_1, input)
        p1
      })
      ### table----
      output$m6_lp_table <- DT::renderDataTable({
        p1 <- m6_lp_render_table(df_m6_lp_1, input)
        p1
      })
      ### map----
      output$m6_lp_map <- renderLeaflet({
        p1 <- m6_lp_render_map(df_m6_lp_1, canada_map,input)
        
        p1
      })
    ## EXPORT----
      ### Executive Summary----
      output$exesum_m6_exp <- renderUI(Exesum_m6_RnD)
      ### Line plot----
      output$m6_exp_lineplot <- renderPlotly({
        p1 <- m6_exp_render_lineplot(df_m6_exp_1, input)
        p1
      })
      ### Heat Map----
      output$m6_exp_heatmap <- renderPlotly({
        p1 <- m6_exp_render_heatmap(df_m6_exp_2, input)
        p1
      })
      ### Heat Map----
      output$m6_exp_stackbar <- renderPlotly({
        p1 <- m6_exp_render_stackbar(df_m6_exp_3, input)
        p1
      })
}
shinyApp(ui = ui, server = server)
