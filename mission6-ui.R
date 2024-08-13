### Home ----
ui_m6_home <- function(df_m6_RnD_1, df_m6_VAEX_1, df_m6_nRinv_1, df_m6_LP_1, df_m6_EXP_1){
  tabItem(tabName = "m6_home",
  fluidPage(
    #CSS Code ----
    tags$head(
      tags$style(HTML("
      .main-title {
        font-weight: bold;
        color: black;
        font-size: 40px;
        text-align: center;
        margin-top: 20px;
        margin-bottom: 20px;
      }
      .custom-box {
        background-color: #f2f2f2;
        border-left: 16px solid #FEB70D;
        padding: 10px;
        margin-bottom: 20px; /* Space between rows of boxes */
        height: 220px; /* Increased height to accommodate labels */
        position: relative; /* Positioning context for absolute positioning */
      }
      .custom-title {
        font-weight: bold;
        text-align: center;
        margin-bottom: 30px; /* Space below the title */
        cursor: pointer; /* Change cursor to pointer on hover */
        color: black; 
        text-decoration: none; /* Remove default underline */
        line-height: 1.5;
        word-wrap: break-word; /* Ensure title is responsive and wraps */
      }
      .custom-title:hover {
        text-decoration: underline; /* Underline on hover */
      }
      .indicator-content {
        display: flex;
        flex-direction: row; /* Align items in a row */
        align-items: center; /* Align items in the center vertically */
        justify-content: flex-start; /* Align items to the left */
        height: 100%; /* Occupy full height */
        position: relative; /* Positioning context for absolute positioning */
        bottom:50px;
        left:25px;
      }
      .trend-triangle {
        width: 15px; /* Smaller width for the triangle */
        height: 15px; /* Smaller height for the triangle */
        border-left: 10px solid transparent;
        border-right: 10px solid transparent;
        margin-left: 5px; /* Space to the left of the triangle */
        position: absolute; /* Positioning context within .indicator-content */
        top: 35%; /* Adjust vertical position to center */
        transform: translateY(-50%); /* Center vertically */
        right: 35px; /* Adjust right position */
      }
      .green-triangle {
        border-bottom: 15px solid #4EA72E; /* Green color for upward trend */
      }
      .yellow-triangle {
        right:30px;
        border-left: 15px solid #FEB70D; /* Yellow color for neutral trend */
        border-top: 10px solid transparent;
        border-bottom: 10px solid transparent;
      }
      .red-triangle {
        border-top: 15px solid #E97132; /* Red color for downward trend */
      }
      .year-label {
        font-weight: bold;
        font-size: 18px; /* Larger font size for the year */
        position: absolute; /* Positioning context within .indicator-content */
        top: 35%; /* Adjust vertical position to center */
        transform: translateY(-50%); /* Center vertically */
        right: 60px; /* Adjust right position */
      }
      .plot-container {
        width: 90%; /* Adjust width of plot container */
        position: relative; /* Ensure position is relative for child elements */
      }
      .action-button {
        border: none; /* Remove border */
        background: none; /* No background color */
        width: 100%; /* Full width */
        padding: 0; /* Remove padding */
      }
      .action-button:hover {
        background: none; /* No background color on hover */
      }
    "))
    ),
    #----
    div(
      actionButton("m6_to_homepage", label = "Fostering Innovation Across the Economy", class = "main-title")
    ),
    div(style = "height: 20px;"),  # Space between title and first row of boxes
    fluidRow(
      wormchart_ui(df = df_m6_RnD_1, 
                   button = "m6_homepage_button_RnD",
                   title = "Private Sector Investment in Innovation",
                   worm = "m6_homepage_worm_RnD",
                   triangle = "m6_homepage_triangle_RnD"),
      
      wormchart_ui(df = df_m6_LP_1, 
                   button = "m6_homepage_button_LP",
                   title = "Labour Productivity",
                   worm = "m6_homepage_worm_LP",
                   triangle = "m6_homepage_triangle_LP"),
      
      wormchart_ui(df = df_m6_VAEX_1, 
                   button = "m6_homepage_button_VAEX",
                   title = "Value-Added Goods and Services Exports",
                   worm = "m6_homepage_worm_VAEX",
                   triangle = "m6_homepage_triangle_VAEX"),
    ),
    div(style = "height: 20px;"),  # Space between first and second rows of boxes
    fluidRow(
      wormchart_ui(df = df_m6_nRinv_1, 
                   button = "m6_homepage_button_nRinv",
                   title = "Non-residential Investments",
                   worm = "m6_homepage_worm_nRinv",
                   triangle = "m6_homepage_triangle_nRinv"),
      
      wormchart_ui(df = df_m6_EXP_1,
                   button = "m6_homepage_button_EXP",
                   title = "Exports Share",
                   worm = "m6_homepage_worm_EXP",
                   triangle = "m6_homepage_triangle_EXP"),
    )
  ))}



### RnD ----
ui_m6_RnD <- function(df1, df2){
  tabItem(tabName = "RnD",
          go_to_button("RnD_mission6", "Mission 6", "RnD_home", "Home Page"),
          ##### Line Plot----
          ui_main_chart(title = "Private sector investment in innovation",
                        chart_name = "m6_RnD_lineplot",
                        button_name = "m6_RnD_lineplot_dwnbtt",
                        source = "Statistics Canada, Table 36-10-0480-01",
                        summary = "Exesum_m6_RnD_main"),
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
#### VAEX----
  tabItem(tabName = "VAEX",
          go_to_button("VAEX_mission6", "Mission 6","VAEX_home", "Home Page"),
          
          ##### Line Plot----
          ui_main_chart(title = "Value-added in goods and services exports",
                        chart_name = "m6_VAEX_lineplot",
                        button_name = "m6_VAEX_lineplot_dwnbtt",
                        source = "Statistics Canada, Table 36-10-0480-01",
                        summary = "Exesum_m6_VAEX_main"),
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
          go_to_button("nRinv_mission6", "Mission 6","nRinv_home", "Home Page"),

          ##### Line Plot----
          ui_main_chart(title = "Non-residential investment as a share of GDP", 
                        chart_name = "m6_nRinv_lineplot", 
                        button_name = "m6_nRinv_lineplot_dwnbtt", 
                        source = "Statistics Canada, Table 36-10-0480-01", 
                        summary = "Exesum_m6_nRinv_main"), 
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




# #### Labour Productivity ----
ui_m6_LP <- function(df){
  tabItem(tabName = "LP",
          go_to_button("LP_mission6", "Mission 6", "LP_home", "Home Page"),
          fluidPage(
            ##### Main Plot----
            ui_indicatorpage_generalcss(),
            div(class = "chart-container", 
                ui_main_chart(
                  title = "Labour productivity",
                  chart_name = "m6_LP_lineplot",
                  button_name = "m6_LP_lineplot_dwnbtt",
                  source = "Statistics Canada, Table 36-10-0480-01",
                  summary = "Exesum_m6_LP_main")),
            
            ##### Deep Dive----
            fluidRow(),
            fluidPage(
              fluidRow(h1("Deep-Dive Charts"), style = "padding-left: 10px;"),
              style = "background-color: white; margin-top: 40px;",
              div(class = "content-container",
                  ###### Fixed Panel----
                  div(class = "fixed-box", 
                      column(12,
                             style = "background-color: #003366; color: white;",
                             fluidRow(h3("", style = "padding-left: 10px;")),
                             fluidRow(align = "center", leafletOutput("m6_LP_map")),
                             fluidRow(
                               column(2),
                               column(8, style = "height: 20px; font-size: 10px;", "Source: Statistics Canada, Table 36-10-0480-01"),
                               column(2)),
                             fluidRow(
                               column(3, div(class = "blue-dropdown", selectInput("m6_LP_map_year", "", choices = unique(df$Year), selected = 2020))),
                               column(4, div(class = "blue-dropdown", selectInput("m6_LP_map_labourtype", "", choices = unique(df$measure), selected = "Labour productivity"))),
                               column(3, div(class = "blue-dropdown", selectInput("m6_LP_map_industry", "", choices = unique(df$Industry)))),
                               column(2, style = "padding-top: 20px;" , downloadButton("m6_LP_map_dwnbtt", label = NULL, class = "btn-custom", icon = icon("cloud-download-alt")))
                             ),
                             fluidRow(
                               style = "padding-left: 10px; padding-right: 40px;",
                               h2("Highlights"),
                               div(style = "width: 100%; overflow-wrap: break-word;", uiOutput("Exesum_m6_LP"))
                             )
                      )),
                  ###### Scrolling Panel----
                  div(class = "scrollable-boxes", style = "padding-left: 60px;",
                      h3("Labour productivity growth rate"),
                      ####### Lines Plot----
                      fluidRow(
                        tags$head(
                          tags$style(HTML("
                            .popover {
                              max-width: 300px; /* Adjust the max-width as needed */
                              width: 300px; /* Set the width */
                            }
                            .popover-content {
                              color: black;
                            }
                            .popover-title {
                              color: black;
                            }
                          "))),
                        div(
                          style = "position: relative; margin-bottom: 0px; height: 250px;",
                          plotlyOutput("m6_LP_lines"),
                          div(
                            actionButton("search_btn", label = icon("search", "fa-4x"), style = "color: white; background-color: #FEB70D; border: none;"),
                            bsPopover(id = "search_btn", title = "Popover Title", content = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum.", 
                                      placement = "right", trigger = "click"),
                            style = "color: white; position: absolute; top: 0px; left: -35px; background-color: #FEB70D; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px; padding: 10px; z-index: 10;"
                          )
                        )
                      ),
                      # Source
                      fluidRow(style = "background-color: #f2f2f2; padding-left: 100px; padding-right: 40px; margin-right: 85px; margin-left: 35px; height: 20px; font-size: 12px;", "Source: Statistics Canada, Table 36-10-0480-01"),
                      # inputs
                      fluidRow(style = "margin-right: 85px; margin-left: 35px; background-color: #f2f2f2;",
                               column(4, div(class = "grey-dropdown", selectInput("m6_LP_lines_geo", "", choices = unique(df$GEO), selected = "British Columbia"))),
                               column(4, div(class = "grey-dropdown", selectInput("m6_LP_lines_labourtype", "", choices = unique(df$measure), selected = "Labour productivity"))),
                               column(2),
                               column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m6_LP_lines_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
                      h3(""),
                      ####### Bar Plot----
                      fluidRow(
                        div(style = "position: relative; margin-bottom: 0px; height: 250px; margin-right: 100px; margin-left: 50px;",
                            plotlyOutput("m6_LP_growthsectors"),
                            div(
                              actionButton("linecahrt_btn", label = icon("line-chart", "fa-4x"), style = "color: white; background-color: #FEB70D; border: none;"),
                              bsPopover(id = "linecahrt_btn", title = "Popover Title", content = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum.", 
                                        placement = "right", trigger = "click"),
                              style = "color: white; position: absolute; top: 0px; left: -35px; background-color: #FEB70D; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px; padding: 10px; z-index: 10;"
                            )
                        )),
                      #Source
                      fluidRow(style = "background-color: #f2f2f2; padding-left: 60px; padding-right: 40px; margin-left: 35px; margin-right: 85px; height: 20px; font-size: 12px;", "Source: Statistics Canada, Table 36-10-0480-01"),
                      # input
                      fluidRow(style = "margin-right: 85px; margin-left: 35px; background-color: #f2f2f2;",
                               column(2, div(class = "grey-dropdown", selectInput("m6_LP_table_year", "", choices = unique(df$Year), selected = 2022))),
                               column(4, div(class = "grey-dropdown", selectInput("m6_LP_table_labourtype", "", choices = unique(df$measure), selected = "Labour productivity"))),
                               column(4, div(class = "grey-dropdown", selectInput("m6_LP_table_industry", "", choices = unique(df$Industry)))),
                               column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m6_LP_table_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
                      h3("Total number of jobs by sector"),
                      ####### Treemap----
                      fluidRow(
                        div(style = "position: relative; margin-bottom: 0px; height: 250px; margin-right: 100px; margin-left: 50px;",
                            plotlyOutput("m6_LP_treemap"),
                            div(
                              actionButton("areachart_btn", label = icon("area-chart", "fa-4x"), style = "color: white; background-color: #FEB70D; border: none;"),
                              bsPopover(id = "areachart_btn", title = "Popover Title", content = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus lacinia odio vitae vestibulum vestibulum.", 
                                        placement = "right", trigger = "click"),
                              style = "color: white; position: absolute; top: 0px; left: -35px; background-color: #FEB70D; border-bottom-left-radius: 10px; border-bottom-right-radius: 10px; padding: 10px; z-index: 10;"
                            ))),
                      #source
                      fluidRow(style = "background-color: #f2f2f2; padding-left: 60px; padding-right: 40px; margin-left: 35px; margin-right: 85px; height: 20px; font-size: 12px;", "Source: Statistics Canada, Table 36-10-0480-01"),
                      # input
                      fluidRow(style = "margin-right: 85px; margin-left: 35px; background-color: #f2f2f2;",
                               column(4, div(class = "grey-dropdown", selectInput("m6_LP_treemap_geo", "", choices = unique(df$GEO), selected = "British Columbia"))),
                               column(4, div(class = "grey-dropdown", selectInput("m6_LP_treemap_year", "", choices = unique(df$Year), selected = 2022))),
                               column(2),
                               column(2, style = "background-color: #f2f2f2; height: 20px; padding-top: 40px; display: flex; justify-content: center; align-items: center;", downloadButton("m6_LP_treemap_dwnbtt", label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt")))),
                      fluidRow(style = "height: 100px;"),
                      fluidRow(
                               column(4),
                               column(4,
                                  downloadButton("m6_LP_report", label = "Download pdf Report", style = "color: white; background-color: #FEB70D; border: none;"),
                               ),
                               column(4)
                  ))
              )
            )
          )
  )
}

#### EXP ----
ui_m6_EXP <- function(df1, df3){
  
  tabItem(tabName = "EXP",
          go_to_button("EXP_mission6", "Mission 6", "EXP_home", "Home Page"),
          ##### Line Plot----
          ui_main_chart(title= "Exports as a share of total Canadian exports",
                        chart_name = "m6_EXP_lineplot", 
                        button_name= "m6_EXP_lineplot_dwnbtt",
                        source= "Statistics Canada, Table 36-10-0480-01",
                        summary = "Exesum_m6_EXP_main"), 
  
          ##### EXESUM ----
          fluidPage(
            style = "background-color: aliceblue ; margin: 20px;",
            fluidRow(
              column(12, h2("Executive Summary"))
            ),
            fluidRow(
              column(12, uiOutput("Exesum_m6_EXP"))
            )
          ),
          ##### Heatmap Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-5-2: Exports as a share of total Canadian exports by commodity types " ))
            ),
            fluidRow(
              column(9,plotlyOutput("m6_EXP_heatmap")),
              column(3, 
                     downloadButton("m6_EXP_heatmap_dwnbtt", "Download Filtered Data in CSV"))
            )
          ),
          ##### Stacked Bar----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-5-4: Environmental and clean technology products exports  " ))
            ),
            fluidRow(
              column(9,plotlyOutput("m6_EXP_stackbar")),
              column(3, 
                     selectInput("m6_EXP_stackbar_year", "Year", choices = unique(df3$Year), selected = 2022),
                     downloadButton("m6_EXP_stackbar_dwnbtt", "Download Filtered Data in CSV"))
            )
          ),
          ##### Bubble plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 6-5-5: Exports by destinations" ))
            ),
            fluidRow(
              column(9,plotlyOutput("m6_EXP_bubble")),
              column(3,
                     downloadButton("m6_EXP_bubble_dwnbtt", "Download Filtered Data in CSV"))
            )
          )
          
  )}