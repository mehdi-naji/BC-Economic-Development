### Home ----
# ui_m6_home <- function(df_m6_RnD, df_m6_VAEX, df_m6_nRinv, df_m6_LP, df_m6_EXP){
#   style2 <- "background-color:white; height: 130px; padding: 2px; border-radius: 15px; border: 6px solid #ecf0f5;font-size: 18px;text-align: center;"
#   style1 <- "background-color:#156082; color:white; height: 80px; width:98%; padding: 6px; border-radius: 15px; border: 6px solid white;font-size: 24px; text-align: center;margin: 0 auto;"
#   tabItem(tabName = "m6_home",
# 
#             fluidRow(
#               style = "border: 20px solid #ecf0f5;",
#               column(3,
#                      fluidRow(h2(HTML("MISSION6:<br/>FORESTING<br/>INNOVATION<br/>ACROSS<br/>ECONOMY"))),
#                      style = "background-color:#156082; color:white; height:400px; padding: 10px 20px; border-radius: 15px; border: 4px solid #ecf0f5;font-size: 36px;text-align: center;"
#               ),
#               column(3, style = style2,
#                      actionButton("m6_RnD_Button",
#                                   label = HTML(Extract_Status(df_m6_RnD, "Million Dollars")),
#                                   style = style1),
#                      "Investment in Innovation"
#               ),
#               column(3, style = style2,
#                      actionButton("m6_VAEX_Button",
#                                   label = HTML(Extract_Status(df_m6_VAEX, "Billion Dollars")),
#                                   style = style1),
#                      "Value added export"
#               ),
#               column(3, style = style2,
#                      actionButton("m6_nRinv_Button",
#                                   label = HTML(Extract_Status(df_m6_nRinv, "%")),
#                                   style = style1),
#                      "Non-residential Investment"
#               ),
#               column(3, style = style2,
#                      actionButton("m6_LP_Button",
#                                   label = HTML(Extract_Status(df_m6_LP, "$ per hour")),
#                                   style = style1),
#                      "Labour productivity"
#               ),
#               column(3, style = style2,
#                      actionButton("m6_EXP_Button",
#                                   label = HTML(Extract_Status(df_m6_EXP, "%")),
#                                   style = style1),
#                      "Export"
#               )
#             )
#           
# 
#   )}

ui_m6_home <- function(df_m6_RnD, df_m6_VAEX, df_m6_nRinv, df_m6_LP, df_m6_EXP){
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
    "))
    ),
    #----
    div(
      class = "main-title",
      "Fostering Innovation Across the Economy"
    ),
    div(style = "height: 20px;"),  # Space between title and first row of boxes
    fluidRow(
      column(width = 4,
             div(
               class = "custom-box",
               tags$a(href = "https://example.com/indicator1", class = "custom-title",
                      h4("Private Sector Investment in Innovation", class = "custom-title")),
               div(class = "indicator-content",
                   plotOutput("m6_homepage_worm_RnD", height = "100px", width = "70%"),  # Plot output directly in the box
                   div(class = "year-label", "2023"),
                   div(class = "trend-triangle green-triangle")
               )
             )
      ),
      column(width = 4,
             div(
               class = "custom-box",
               tags$a(href = "https://example.com/indicator2", class = "custom-title",
                      h4("Labour Productivity", class = "custom-title")),
               div(class = "indicator-content",
                   plotOutput("m6_homepage_worm_LP", height = "150px", width = "70%"),  # Plot output directly in the box
                   div(class = "year-label", "2023"),
                   div(class = "trend-triangle yellow-triangle")
               )
             )
      ),
      column(width = 4,
             div(
               class = "custom-box",
               tags$a(href = "https://example.com/indicator3", class = "custom-title",
                      h4("Value-Added Goods and Services Exports", class = "custom-title")),
               div(class = "indicator-content",
                   plotOutput("m6_homepage_worm_VAEX", height = "130px", width = "70%"),  # Plot output directly in the box
                   div(class = "year-label", "2023"),
                   div(class = "trend-triangle green-triangle")
               )
             )
      )
    ),
    # div(style = "height: 20px;"),  # Space between first and second rows of boxes
    # fluidRow(
    #   column(width = 4,
    #          div(
    #            class = "custom-box",
    #            tags$a(href = "https://example.com/indicator4", class = "custom-title",
    #                   h4("Non-residential Investments", class = "custom-title")),
    #            div(class = "indicator-content",
    #                plotOutput("line_chart4", height = "150px", width = "70%"),  # Plot output directly in the box
    #                div(class = "year-label", "2023"),
    #                div(class = "trend-triangle green-triangle")
    #            )
    #          )
    #   ),
    #   column(width = 4,
    #          div(
    #            class = "custom-box",
    #            tags$a(href = "https://example.com/indicator5", class = "custom-title",
    #                   h4("Exports Share", class = "custom-title")),
    #            div(class = "indicator-content",
    #                plotOutput("line_chart5", height = "150px", width = "70%"),  # Plot output directly in the box
    #                div(class = "year-label", "2023"),
    #                div(class = "trend-triangle red-triangle")
    #            )
    #          )
    #   )
    # )
  ))}



#### RnD ----
ui_m6_RnD <- function(df1, df2){
  tabItem(tabName = "RnD",
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
#### VAEX ----
  tabItem(tabName = "VAEX",
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


#### Labour Productivity ----
ui_m6_lp <- function(df){
    tabItem(
        tabName = "LP",
        fluidPage(
        ##### Main Plot----
                                  tags$head(
                                    tags$style(HTML("
                              .chart-container {
                                height: 400px;
                                background-color: #f0f0f0;
                              }
                              .content-container {
                                display: flex;
                                position: relative;
                                overflow: hidden; /* Hide scrolling for the content container */
                                overflow-y: scroll; /* Allow scrolling for the content container */
                                height: calc(120vh - 120px); /* Adjust height as needed */
                              }
                              .fixed-box {
                                position: -webkit-sticky; /* For Safari */
                                position: sticky;
                                top: 0;
                                width: 400px;
                                /*background-color: white;*/
                                padding: 10px;
                                z-index: 1; /* Ensure the fixed box is above the moving boxes */
                              }
                              .scrollable-boxes {
                                /*flex-grow: 1;*/
                                padding: 10px;
                                width: 1000px;
                                 /*background-color: #e9ecef;*/
                                /*margin-left: 80px; Ensure space for fixed box */
                              }

                            "))
                                  ),
          fluidPage(
                            div(class = "chart-container", 
                            ui_main_chart(
                                title = "Labour productivity",
                                chart_name = "m6_lp_lineplot",
                                button_name = "m6_lp_lineplot_dwnbtt",
                                source = " Statistics Canada, Table 36-10-0480-01",
                                summary = "Exesum_m6_lp_main"))),
          
        ##### Deep DIve----
        # fluidRow(h3("Deep dive"), style = "margin: 60px; height: 80px;"),
        fluidPage(
          fluidRow(h1("Deep-Dive Charts"), style = "padding-left: 10px;"),
          style = "background-color : white; margin-left: 65px; margin-right:65px; margin-top:40px; ",
          div(class = "content-container",
              ###### Fixed Panel----
              div(class = "fixed-box", 
                  column(12,
                                    style = "background-color: #003366; color:white; ",
                                    fluidRow(
                                        h3("Labour productivity across Canada", style="padding-left: 10px;" )
                                     ),
                                    fluidRow(
                                      align = "center",
                                      leafletOutput("m6_lp_map")
                                       ),
                         fluidRow(
                           column(2),
                           column(8,
                                  style = "height: 20px; font-size: 10px;",
                                  "Source: Statistics Canada, Table 36-10-0480-01"
                                  ),
                           column(2)),
                                     fluidRow(
                                       tags$head(
                                         tags$style(HTML("
                        .selectize-input, .selectize-dropdown {
                          background-color: #003366 !important;
                          color: white !important;
                          border-color: #003366 !important;
                        }
                        .selectize-dropdown-content .option {
                          color: white !important;
                        }
                        .selectize-input::after {
                          display: none !important;
                        }
                        .blue-dropdown .selectize-input, .blue-dropdown .selectize-dropdown {
                          background-color: #003366 !important;
                          color: white !important;
                          padding : 5px;
                          font-size : 10px;
                          border-color: #003366 !important;
                        }
                        .blue-dropdown .selectize-dropdown-content .option {
                          color: white !important;
                        }
                        .grey-dropdown .selectize-input, .grey-dropdown .selectize-dropdown {
                          background-color: #f2f2f2 !important;
                          color: black !important;
                          border-color: #f2f2f2 !important;
                        }
                        .grey-dropdown .selectize-dropdown-content .option {
                          color: black !important;
                        }
                        .btn-custom {
                          background-color: transparent;
                          border: none;
                        }
                        .btn-custom .fa-cloud-download-alt {
                          color: white;
                        }
                        .btn-custom-black {
                          background-color: transparent;
                          border: none;
                          color: black;
                        }
                        .btn-custom-black .fa-cloud-download-alt {
                          color: black;
                        }
                     "))
                                       ),
                                       
                                       column(2,
                                              div(class = "blue-dropdown",
                                              selectInput("m6_lp_map_year", "", choices = unique(df$Year), selected = 2020))
                                       ),
                                       column(4,
                                              div(class = "blue-dropdown",
                                              selectInput("m6_lp_map_labourtype", "", choices = unique(df$measure),
                                              selected = "Labour productivity"))
                                       ),
                                       column(4,
                                              div(class = "blue-dropdown",
                                              selectInput("m6_lp_map_industry", "", choices = unique(df$Industry))),
                                       ),
        #                                tags$style(HTML(".btn-custom {
        #                   background-color: transparent;
        #                   border: none;
        #                   color: white;
        #                 }
        #                 .btn-custom .fa-cloud-download-alt {
        #                   color: white;
        #                 }
        # ")),
                                       column(2, style = "padding-top: 20px; padding-right: 30px;",
                                              downloadButton("m6_lp_map_dwnbtt" , label = NULL, class = "btn-custom", icon = icon("cloud-download-alt"))
                                       )
                                       ),
                         fluidRow(
                             style = "padding-left: 40px; padding-right: 40px;",
                             h2("Highlights"),
                             uiOutput("Exesum_m6_lp")
                             )
                                     )
                              ),
              ###### Scrolling Panel----
              div(class = "scrollable-boxes",
                      style = "padding-left: 60px; ",
                      h3("Labour productivity growth rate"),
                      ####### Lines Plot----
                      fluidRow(
                              div(
                                style = "position: relative; margin-buttom:40px; height:250px; margin-right: 100px; margin-left: 50px;",
                                plotlyOutput("m6_lp_lines"),
                                div(
                                  icon("search", "fa-4x"),
                                  style = "color: white;
                         position: absolute;
                         top: 0px;
                         left: -35px;
                         background-color: #FEB70D;
                         border-bottom-left-radius: 10px;
                         border-bottom-right-radius: 10px;
                         padding: 10px;
                         z-index: 10;"
                                )
                              )
                            ),
                     # Source
                      fluidRow(
                        style = "background-color: #f2f2f2; padding-left: 100px; padding-right:40px; margin-right: 85px; margin-left: 35px; height: 20px; font-size: 12px;",
                        "Source: Statistics Canada, Table 36-10-0480-01"
                      ),
                     # inputs
                     fluidRow(
                           style = "margin-right: 85px; margin-left: 35px; background-color: #f2f2f2;",
                           column(4,
                                  div(class = "grey-dropdown",
                                  selectInput("m6_lp_lines_geo", "", choices = unique(df$GEO), selected = "British Columbia"),
                           )),
                           column(4,
                                  div(class = "grey-dropdown",
                                  selectInput("m6_lp_lines_labourtype", "", choices = unique(df$measure),selected = "Labour productivity"),
                           )),
                           column(2),
                           column(2,
                              style = "background-color: #f2f2f2; height: 20px; padding-top : 40px; display: flex; justify-content: center; align-items: center;",
                                            downloadButton("m6_lp_lines_dwnbtt" , label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt"))
                              ),

                              
                           ),

                        h1(""),
                      ####### Bar Plot----
                        fluidRow(
                          div(
                            style = "position: relative; margin-right: 100px; margin-left: 50px; height:250px;",
                            plotlyOutput("m6_lp_growthsectors"),
                            div(
                              icon("line-chart", "fa-4x"),
                              style = "color: white;
                           position: absolute;
                           top: 0px;
                           left: -35px;
                           background-color: #FEB70D;
                           border-bottom-left-radius: 10px;
                           border-bottom-right-radius: 10px;
                           padding: 10px;
                           z-index: 10;"
                                  )
                                )
                              ),
                          #Source
                          fluidRow(
                            style = "background-color: #f2f2f2; padding-left: 60px; padding-right:40px; margin-left: 35px; margin-right: 85px; height: 20px; font-size: 12px;",
                            "Source: Statistics Canada, Table 36-10-0480-01"
                          ),
                         # input
                          fluidRow(
                            style = "margin-right: 85px; margin-left:35px; background-color: #f2f2f2;",
                            column(2,
                                   div(class = "grey-dropdown",
                                   selectInput("m6_lp_table_year", "", choices = unique(df$Year), selected = 2022),
                                   )),
                            column(4,
                                   div(class = "grey-dropdown",
                                   selectInput("m6_lp_table_labourtype", "", choices = unique(df$measure), selected = "Labour productivity"),
                                   )),
                            column(4,
                                   div(class = "grey-dropdown",
                                   selectInput("m6_lp_table_industry", "", choices = unique(df$Industry)),  
                                   )),
                            column(2,
                                   style = "background-color: #f2f2f2; height: 20px; padding-top : 40px; display: flex; justify-content: center; align-items: center;",
                                   downloadButton("m6_lp_table_dwnbtt" , label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt"))
                            ),
        
                          ),
                 
                          h3("Total number of jobs by sector"),
                      ####### Treemap----
                       fluidRow(
                         div(
                           style = "position: relative; margin-right: 100px; margin-left: 50px;height:250px;",
                           plotlyOutput("m6_lp_treemap"),
                           div(
                             icon("area-chart", "fa-4x"),
                             style = "color: white;
                     position: absolute;
                     top: 0px;
                     left: -35px;
                     background-color: #FEB70D;
                     border-bottom-left-radius: 10px;
                     border-bottom-right-radius: 10px;
                     padding: 10px;
                     z-index: 10;"
                           )
                         )
                       ),
                      #source
                       fluidRow(
                         style = "background-color: #f2f2f2; padding-left: 60px; padding-right:40px; margin-left: 35px; margin-right: 85px; height: 20px; font-size: 12px;",
                         "Source: Statistics Canada, Table 36-10-0480-01"
                       ),
                       # input
                       fluidRow(
                         style = "margin-right: 85px; margin-left:35px; background-color: #f2f2f2;",
                         column(4,
                                div(class = "grey-dropdown",
                                    selectInput("m6_lp_treemap_geo", "", choices = unique(df$GEO), selected = "British Columbia"),                          )),
                         column(4,
                                div(class = "grey-dropdown",
                                    selectInput("m6_lp_treemap_year", "", choices = unique(df$Year), selected = 2022)),
                                ),
                         column(2),
                         column(2,
                                style = "background-color: #f2f2f2; height: 20px; padding-top : 40px; display: flex; justify-content: center; align-items: center;",
                                downloadButton("m6_lp_treemap_dwnbtt" , label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt"))
                         ),
                         
                       ),
                       fluidRow(style = "height : 200px;")
                  #----
                  )

            )
          ) 
)
    )}

  #### EXP ----
ui_m6_exp <- function(df1, df3){
  
  tabItem(tabName = "EXP",
          ##### Line Plot----
          ui_main_chart(title= "Exports as a share of total Canadian exports",
                        chart_name = "m6_exp_lineplot", 
                        button_name= "m6_exp_lineplot_dwnbtt",
                        source= "Statistics Canada, Table 36-10-0480-01",
                        summary = "Exesum_m6_exp_main"), 
  
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