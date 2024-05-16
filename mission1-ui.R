
### Home ----
ui_m1_home <- function(df_m1_PI, df_m1_CHN, df_m1_GC, df_m1_UR, df_m1_FE, df_m1_TS, df_m1_SB, df_m1_LE, df_m1_MH){
  style2 <- "background-color:white; height: 130px; padding: 2px; border-radius: 15px; border: 6px solid #ecf0f5;font-size: 18px;text-align: center;"
  style1 <- "background-color:#156082; color:white; height: 80px; width:98%; padding: 6px; border-radius: 15px; border: 6px solid white;font-size: 24px; text-align: center;margin: 0 auto;"
  tabItem(tabName = "m1_home",
          fluidPage(
            fluidRow(
                style = "border: 20px solid #ecf0f5;",
                column(3,
                       style = "height:100px;"
                ), 
                column(3, style = style2,
                       actionButton("m1_PI_Button", 
                                    label = HTML(Extract_Status(df_m1_PI, "%")), 
                                    style = style1),
                       "Poverty Incidence"
                ),
                column(3, style = style2,
                       actionButton("m1_CHN_Button", 
                                    label = HTML(Extract_Status(df_m1_CHN, "%")), 
                                    style = style1),
                       "Core Housing Need"
                ),
                column(3, style = style2,
                       actionButton("m1_GC_Button", 
                                    label = HTML(Extract_Status(df_m1_GC, "")), 
                                    style = style1),
                       "Gini Coefficinet"
                )),
              fluidRow(
                  style = "border: 20px solid #ecf0f5;",
                  column(3,
                         style = "height:100px;"
                  ), 
                  column(3, style = style2,
                         actionButton("m1_UR_Button", 
                                      label = HTML(Extract_Status(df_m1_UR, "")), 
                                      style = style1),
                         "Underemployment Rate"
                  ),
                  column(3, style = style2,
                         actionButton("m1_FE_Button", 
                                      label = HTML(Extract_Status(df_m1_FE, "%")), 
                                      style = style1),
                         "Food Expenditure"
                  ),
                  column(3, style = style2,
                         actionButton("m1_TS_Button", 
                                      label = HTML(Extract_Status(df_m1_TS, "%")), 
                                      style = style1),
                         "Spending on Transportation"
                  )
                ),
            fluidRow(
                  style = "border: 20px solid #ecf0f5;",
                  column(3,
                         fluidRow(h2(HTML("MISSION1:<br/>SUPPORTING<br/>PEOPLE<br/>FAMILIES"))),
                         style = "background-color:#156082; color:white; height:400px; padding: 10px 20px; border-radius: 15px; border: 4px solid #ecf0f5;font-size: 36px;text-align: center;"
                  ), 
                  column(3, style = style2,
                         actionButton("m1_SB_Button", 
                                      label = HTML(Extract_Status(df_m1_SB, "%")), 
                                      style = style1),
                         "Sense of Belongings"
                  ),
                  column(3, style = style2,
                         actionButton("m1_LE_Button", 
                                      label = HTML(Extract_Status(df_m1_LE, "years")), 
                                      style = style1),
                         "Life Expectancy"
                  ),
                  column(3, style = style2,
                         actionButton("m1_MH_Button", 
                                      label = HTML(Extract_Status(df_m1_MH, "%")), 
                                      style = style1), "Mental Health"
                  )
                )
            ))}



### PI: Povery Incidence ----
ui_m1_PI <- function(df1, df2){
  tabItem(tabName = "PI",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-1-1: Poverty Incidence" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m1_PI_lineplot")),
              column(1,
                     downloadButton("m1_PI_lineplot_dwnbtt", ""))
            )
          ),
          ##### EXESUM ----
          fluidPage(
            style = "background-color: aliceblue ; margin: 20px;",
            fluidRow(
              column(12, h2("Executive Summary"))
            ),
            fluidRow(
              column(12, uiOutput("exesum_m1_PI"))
            )
          ),
          ##### Gender Bias----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-2-2: Poverty Incidence - Gender Bias" ))
            ),
            fluidRow(
              column(9,plotOutput("m1_PI_GB")),
              column(3,
                     selectInput("m1_PI_GB_geo", "Region", choices = unique(df2$GEO), selected = "British Columbia"),
                     selectInput("m1_PI_GB_year", "Year", choices = unique(df2$Year), selected = 2021),
                     downloadButton("m1_PI_GB_dwnbtt", "Download Filtered Data in CSV"))
            )
          ),
          
  )}

### CHN: Core Housing Needs ----
ui_m1_CHN <- function(df1){
  tabItem(tabName = "CHN",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-2-1: Core Housing Needs" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m1_CHN_lineplot")),
              column(1,
                     downloadButton("m1_CHN_lineplot_dwnbtt", ""))
            )
          ),
  )}
          
### GC: Gini Coefficient ----
ui_m1_GC <- function(df1){
  tabItem(tabName = "GC",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-3-1: Gini Coefficient" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m1_GC_lineplot")),
              column(1,
                     downloadButton("m1_GC_lineplot_dwnbtt", ""))
            )
          ),

  )}

### UR: Underemploymnet Rate ----
ui_m1_UR <- function(df1, df2, df3, df4, df5){
  tabItem(tabName = "UR",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-4-1: Uneremployment Rate" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m1_UR_lineplot")),
              column(1, downloadButton("m1_UR_lineplot_dwnbtt", ""))
            )
          ),
          ##### EXESUM ----
          fluidPage(
            style = "background-color: aliceblue ; margin: 20px;",
            fluidRow(
              column(12, h2("Executive Summary"))
            ),
            fluidRow(
              column(12, uiOutput("exesum_m1_UR"))
            )
          ),
          #### Waffle Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-1-1: Underemployment Rate" ))
            ),
            fluidRow(
              column(9,plotOutput("m1_UR_waffle")),
              column(3,
                     selectInput("m1_UR_waffle_year", "Year", choices = unique(df4$Year), selected = 2010),
                     selectInput("m1_UR_waffle_geo", "GEO", choices = unique(df4$GEO), selected = "British Columbia"),
                     downloadButton("m1_UR_waffle_dwnbtt", "Download Filtered Data in CSV"))
            )
          ),
          
          #### Treemap Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-1-3: Underemployment Rate" ))
            ),
            fluidRow(
              column(9,plotlyOutput("m1_UR_treemap")),
              column(3,
                     selectInput("m1_UR_treemap_year", "Year", choices = unique(df3$Year), selected = 2010),
                     selectInput("m1_UR_treemap_geo", "GEO", choices = unique(df3$GEO), selected = "British Columbia"),
                     selectInput("m1_UR_treemap_character", "Labour Force Characterisitics", choices = unique(df3$Character), selected = "Employment"),
                     downloadButton("m1_UR_treemap_dwnbtt", "Download Filtered Data in CSV"))
            )
          ),
          
          #### Heatmap Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-1-4: Underemployment Rate" ))
            ),
            fluidRow(
              column(9,plotlyOutput("m1_UR_heatmap")),
              column(3,
                     selectInput("m1_UR_heatmap_year", "Year", choices = unique(df5$Year), selected = 2010),
                     selectInput("m1_UR_heatmap_geo", "GEO", choices = unique(df5$GEO), selected = "British Columbia"),
                     selectInput("m1_UR_heatmap_character", "Labour Force Characterisitics", choices = unique(df5$Character), selected = "Employment"),
                     downloadButton("m1_UR_heatmap_dwnbtt", "Download Filtered Data in CSV"))
            )
          ),
          
  )}


### FE: Food Expenditures ----
ui_m1_FE <- function(df1){
  tabItem(tabName = "FE",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-5-1: Food Expenditure" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m1_FE_lineplot")),
              column(1,
                     downloadButton("m1_FE_lineplot_dwnbtt", ""))
            )
          ),
          
  )}

### TS: Transportation Spending ----
ui_m1_TS <- function(df1){
  tabItem(tabName = "TS",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-6-1: Spending on Transportation" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m1_TS_lineplot")),
              column(1,
                     downloadButton("m1_TS_lineplot_dwnbtt", ""))
            )
          ),
          
  )}
### SB: Sense of Belongings ----
ui_m1_SB <- function(df1){
  tabItem(tabName = "SB",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-7-1: Sense of Belongings" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m1_SB_lineplot")),
              column(1,
                     downloadButton("m1_SB_lineplot_dwnbtt", ""))
            )
          ),
          
  )}
### LE: Life Expectancy ----
ui_m1_LE <- function(df1){
  tabItem(tabName = "LE",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-8-1: Life Expectancy" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m1_LE_lineplot")),
              column(1,
                     downloadButton("m1_LE_lineplot_dwnbtt", ""))
            )
          ),
          
  )}
### MI: Median Income ----
ui_m1_MI <- function(df1){
  tabItem(tabName = "MI",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-3-1: Income (Median after tax)" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m1_MI_lineplot")),
              column(1,
                     downloadButton("m1_MI_lineplot_dwnbtt", ""))
            )
          ),
          
  )}
### MH: Mental Health ----
ui_m1_MH <- function(df1){
  tabItem(tabName = "MH",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-10-1: Mental Health" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m1_MH_lineplot")),
              column(1,
                     downloadButton("m1_MH_lineplot_dwnbtt", ""))
            )
          ),
          
  )}