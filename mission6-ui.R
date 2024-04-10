
#### RnD ----
ui_m6_RnD <- function(df1, df2){
  tabItem(tabName = "RnD",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-1-1: Private sector investment in innovation " ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m6_RnD_lineplot")),
              column(1, downloadButton("m6_RnD_lineplot_dwnbtt", ""))
            )
          ),
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
          ##### Sankey Plot ----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-1-2: R&D funding flows" ))
            ),
            fluidRow(
              column(9,plotlyOutput("m6_RnD_sankey")),
              column(3, 
                     selectInput("m6_RnD_sankey_geo", "Region", choices = unique(df1$GEO), selected = "British Columbia"), 
                     selectInput("m6_RnD_sankey_science_type", "Science Type", choices = unique(df1$Science.type)),
                     selectInput("m6_RnD_sankey_year", "Year", choices = unique(df1$Year), selected = 2021),
                     downloadButton("m6_RnD_sankey_dwnbtt", "Download Filtered Data in CSV"))
            )
          ),
          ##### Table ----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-1-3: Research and Development Spending Growth" ))
            ),
            fluidRow(
              column(9,DT::dataTableOutput("m6_RnD_table")),
              column(3, 
                     selectInput("m6_RnD_table_prices", "Price type", choices = unique(df1$Prices)), 
                     selectInput("m6_RnD_table_science_type", "Science Type", choices = unique(df1$Science.type)),
                     selectInput("m6_RnD_table_funder", "Funder", choices = unique(df1$Funder), selected = " business enterprise sector"),
                     selectInput("m6_RnD_table_performer", "Performer", choices = unique(df1$Performer)),
                     selectInput("m6_RnD_table_year", "Year", choices = unique(df1$Year), selected = 2021)
              )
            )
          ),
          ##### Bar Plot ----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-1-4: R&D intensity" ))
            ),
            fluidRow(
              column(9,plotlyOutput("m6_RnD_barplot")),
              column(3, 
                     selectInput("m6_RnD_barplot_year", "Year", choices = unique(df2$Year), selected = 2020),
                     downloadButton("m6_RnD_barplot_dwnbtt", "Download Filtered Data in CSV"))
            )
          )
  )}

ui_m6_VAEX <- function(df){
#### VAEX ----
  tabItem(tabName = "VAEX",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-2-1: Value-added in goods and services exports" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m6_VAEX_lineplot")),
              column(1, downloadButton("m6_VAEX_lineplot_dwnbtt", ""))
            )
          ),
          ##### EXESUM ----
          fluidPage(
            style = "background-color: aliceblue ; margin: 20px;",
            fluidRow(
              column(12, h2("Executive Summary"))
            ),
            fluidRow(
              column(12, uiOutput("Exesum_m6_VAEX"))
            )
          ),
          ##### Pie Chart ----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-2-2: Value-added exports GDP contribution" ))
            ),
            fluidRow(
              column(9,plotlyOutput("m6_VAEX_pie")),
              column(3, 
                     selectInput("m6_VAEX_pie_geo", "Region", choices = unique(df$GEO), selected = "British Columbia"),
                     selectInput("m6_VAEX_pie_year", "Year", choices = unique(df$Year), selected = 2019),
                     downloadButton("m6_VAEX_pie_dwnbtt", "Download Filtered Data in CSV"))
            )    
          ),
          ##### Bar Plot ----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-2-3: Value-added exports by industry in B.C." ))
            ),
            fluidRow(
              column(9,plotlyOutput("m6_VAEX_barplot")),
              column(3, 
                     selectInput("m6_VAEX_barplot_year", "Year", choices = unique(df$Year), selected = 2019),
                     selectInput("m6_VAEX_barplot_industry", "Industry", choices = unique(df$Industry), selected = "Total industries")
              )    
            )
          )
  )}

  #### Non residential investment ----
ui_m6_nRinv <- function(df){
  tabItem(tabName = "nRinv",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-3-1: Non-residential investment as a share of GDP" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m6_nRinv_lineplot")),
              column(1, downloadButton("m6_nRinv_lineplot_dwnbtt", ""))
            )
          ),
          ##### EXESUM ----
          fluidPage(
            style = "background-color: aliceblue ; margin: 20px;",
            fluidRow(
              column(12, h2("Executive Summary"))
            ),
            fluidRow(
              column(12, uiOutput("Exesum_m6_nRinv"))
            )
          ),
          ##### Lines plot ----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-3-2: Gross fixed capital formation breakdown " ))
            ),
            fluidRow(
              column(9,plotlyOutput("m6_nRinv_lines")),
              column(3,
                     selectInput("m6_nRinv_lines_geo", "Region", choices = unique(df$GEO), selected = "British Columbia"),
                     selectInput("m6_nRinv_lines_prices", "Price Type", choices = unique(df$Prices)),
                     downloadButton("m6_nRinv_lines_dwnbtt", "Download Filtered Data in CSV"))
            )    
          ),
          ##### Bar Plot ----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-3-3: Non-residential investment breakdown by jurisdictions" ))
            ),
            fluidRow(
              column(9,plotlyOutput("m6_nRinv_barplot")),
              column(3, 
                     selectInput("m6_nRinv_barplot_year", "Year", choices = unique(df$Year), selected = 2019),
                     downloadButton("m6_nRinv_barplot_dwnbtt", "Download Filtered Data in CSV"))
            )    
          )
  )}


  #### Labour Productivity ----
ui_m6_lp <- function(df){
    tabItem(tabName = "LP",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-4-1: Labour productivity " ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m6_lp_lineplot")),
              column(1,downloadButton("m6_lp_lineplot_dwnbtt", "")))
          ),
          ##### EXESUM ----
          fluidPage(
            style = "background-color: aliceblue ; margin: 20px;",
            fluidRow(
              column(12, h2("Executive Summary"))
            ),
            fluidRow(
              column(12, uiOutput("Exesum_m6_lp"))
            )
          ),
          ##### Lines ----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-4-2: Labour productivity by sector" ))
            ),
            fluidRow(
              column(9,plotlyOutput("m6_lp_lines")),
              column(3, 
                     selectInput("m6_lp_lines_geo", "Region", choices = unique(df$GEO), selected = "British Columbia"),
                     selectInput("m6_lp_lines_labourtype", "Labour Productivity Measure", choices = unique(df$Labour.productivity.and.related.measures),
                                 selected = "Labour productivity"),
                     downloadButton("m6_lp_lines_dwnbtt", "Download Filtered Data in CSV"))
            )
          ),
          ##### Map----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-4-3: Labour productivity by jurisdictions" ))
            ),
            fluidRow(
              column(9,leafletOutput("m6_lp_map")),
              column(3, 
                     selectInput("m6_lp_map_year", "Year", choices = unique(df$Year), selected = 2020),
                     selectInput("m6_lp_map_labourtype", "Labour Productivity Measure", choices = unique(df$Labour.productivity.and.related.measures),
                                 selected = "Labour productivity"),
                     selectInput("m6_lp_map_industry", "Industry", choices = unique(df$Industry)),
                     downloadButton("m6_lp_map_dwnbtt", "Download Filtered Data in CSV"))
            )
          ),
          ##### Table----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-4-4: Labour productivity growth rate " ))
            ),
            fluidRow(
              column(9,DT::dataTableOutput("m6_lp_table")),
              column(3, 
                     selectInput("m6_lp_table_year", "Year", choices = unique(df$Year), selected = 2022),
                     selectInput("m6_lp_table_labourtype", "Labour Productivity Measure", choices = unique(df$Labour.productivity.and.related.measures),
                                 selected = "Labour productivity"),
                     selectInput("m6_lp_table_industry", "Industry", choices = unique(df$Industry)),
                     downloadButton("m6_lp_table_dwnbtt", "Download Filtered Data in CSV"))
            )
          ),
          ##### Treemap Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-4-5: Total number of jobs by industry  " ))
            ),
            fluidRow(
              column(9,plotlyOutput("m6_lp_treemap")),
              column(3, 
                     selectInput("m6_lp_treemap_geo", "Region", choices = unique(df$GEO), selected = "British Columbia"),
                     selectInput("m6_lp_treemap_year", "Year", choices = unique(df$Year), selected = 2022)),
                     downloadButton("m6_lp_treemap_dwnbtt", "Download Filtered Data in CSV"))
            
          )
    )}

  #### EXP ----
ui_m6_exp <- function(df1, df3){
  
  tabItem(tabName = "EXP",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-5-1: Exports as a share of total Canadian exports" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m6_exp_lineplot")),
              column(1, downloadButton("m6_exp_lineplot_dwnbtt", ""))
            )
          ),
          ##### EXESUM ----
          fluidPage(
            style = "background-color: aliceblue ; margin: 20px;",
            fluidRow(
              column(12, h2("Executive Summary"))
            ),
            fluidRow(
              column(12, uiOutput("Exesum_m6_exp"))
            )
          ),
          ##### Heatmap Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-5-2: Exports as a share of total Canadian exports by commodity types " ))
            ),
            fluidRow(
              column(9,plotlyOutput("m6_exp_heatmap")),
              column(3, 
                     downloadButton("m6_exp_heatmap_dwnbtt", "Download Filtered Data in CSV"))
            )
          ),
          ##### Stacked Bar----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-5-4: Environmental and clean technology products exports  " ))
            ),
            fluidRow(
              column(9,plotlyOutput("m6_exp_stackbar")),
              column(3, 
                     selectInput("m6_exp_stackbar_year", "Year", choices = unique(df3$Year), selected = 2022),
                     downloadButton("m6_exp_stackbar_dwnbtt", "Download Filtered Data in CSV"))
            )
          ),
          ##### Bubble plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-5-5: Exports by destinations" ))
            ),
            fluidRow(
              column(9,plotlyOutput("m6_exp_bubble")),
              column(3,
                     downloadButton("m6_exp_bubble_dwnbtt", "Download Filtered Data in CSV"))
            )
          )
          
  )}