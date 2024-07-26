# ui_m6_RnD <- function(df1, df2){
#   tabItem(
#     tabName = "RnD",
#     fluidPage(
#       ##### Main Plot----
#       ui_indicatorpage_generalcss(),
#       fluidPage(
#         div(class = "chart-container", 
#             ui_main_chart(
#               title = "Private sector investment in innovation",
#               chart_name = "m6_RnD_lineplot",
#               button_name = "m6_RnD_lineplot_dwnbtt",
#               source = " Statistics Canada, Table 36-10-0480-01",
#               summary = "Exesum_m6_RnD_main"))),
#       
#       ##### Deep DIve----
#       fluidPage(
#         fluidRow(h1("Deep-Dive Charts"), style = "padding-left: 10px;"),
#         style = "background-color : white; margin-left: 65px; margin-right:65px; margin-top:40px; ",
#         div(class = "content-container",
#             ###### Fixed Panel----
#             div(class = "fixed-box", 
#                 column(12,
#                        style = "background-color: #003366; color:white; ",
#                        fluidRow(
#                          h3("Research and development across Canada", style="padding-left: 10px;" )
#                        ),
#                        fluidRow(
#                          align = "center",
#                          leafletOutput("m6_RnD_map")
#                        ),
#                        fluidRow(
#                          column(2),
#                          column(8,
#                                 style = "height: 20px; font-size: 10px;",
#                                 "Source: Statistics Canada, Table 36-10-0480-01"
#                          ),
#                          column(2)),
#                        fluidRow(
#                          column(2,
#                                 div(class = "blue-dropdown",
#                                     selectInput("m6_RnD_map_year", "", choices = unique(df1$Year), selected = 2020))
#                          ),
#                          column(4),
#                          column(4),
#                          column(2, style = "padding-top: 20px; padding-right: 30px;",
#                                 downloadButton("m6_RnD_map_dwnbtt" , label = NULL, class = "btn-custom", icon = icon("cloud-download-alt"))
#                          )
#                        ),
#                        fluidRow(
#                          style = "padding-left: 40px; padding-right: 40px;",
#                          h2("Highlights"),
#                          uiOutput("Exesum_m6_RnD")
#                        )
#                 )
#             ),
            ##### Scrolling Panel----
            # div(class = "scrollable-boxes",
                # style = "padding-left: 60px; ",
                # h3("Labour productivity growth rate"),
                ####### Lines Plot----
                # fluidRow(
                #   div(
                #     style = "position: relative; margin-buttom:40px; height:250px; margin-right: 100px; margin-left: 50px;",
                #     plotlyOutput("m6_RnD_lines"),
                #     div(
                #       icon("search", "fa-4x"),
                #       style = "color: white;
                #          position: absolute;
                #          top: 0px;
                #          left: -35px;
                #          background-color: #FEB70D;
                #          border-bottom-left-radius: 10px;
                #          border-bottom-right-radius: 10px;
                #          padding: 10px;
                #          z-index: 10;"
                #     )
                #   )
                # ),
                # Source
                # fluidRow(
                #   style = "background-color: #f2f2f2; padding-left: 100px; padding-right:40px; margin-right: 85px; margin-left: 35px; height: 20px; font-size: 12px;",
                #   "Source: Statistics Canada, Table 36-10-0480-01"
                # ),
                # inputs
                # fluidRow(
                #   style = "margin-right: 85px; margin-left: 35px; background-color: #f2f2f2;",
                #   column(4,
                #          div(class = "grey-dropdown",
                #              selectInput("m6_RnD_lines_geo", "", choices = unique(df$GEO), selected = "British Columbia"),
                #          )),
                #   column(4,
                #          div(class = "grey-dropdown",
                #              selectInput("m6_RnD_lines_labourtype", "", choices = unique(df$measure),selected = "Labour productivity"),
                #          )),
                #   column(2),
                #   column(2,
                #          style = "background-color: #f2f2f2; height: 20px; padding-top : 40px; display: flex; justify-content: center; align-items: center;",
                #          downloadButton("m6_RnD_lines_dwnbtt" , label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt"))
                #   ),
                #   
                #   
                # ),
                # h1(""),
                ####### Bar Plot----
                # fluidRow(
                #   div(
                #     style = "position: relative; margin-right: 100px; margin-left: 50px; height:250px;",
                #     plotlyOutput("m6_RnD_growthsectors"),
                #     div(
                #       icon("line-chart", "fa-4x"),
                #       style = "color: white;
                #            position: absolute;
                #            top: 0px;
                #            left: -35px;
                #            background-color: #FEB70D;
                #            border-bottom-left-radius: 10px;
                #            border-bottom-right-radius: 10px;
                #            padding: 10px;
                #            z-index: 10;"
                #     )
                #   )
                # ),
                #Source
                # fluidRow(
                #   style = "background-color: #f2f2f2; padding-left: 60px; padding-right:40px; margin-left: 35px; margin-right: 85px; height: 20px; font-size: 12px;",
                #   "Source: Statistics Canada, Table 36-10-0480-01"
                # ),
                # input
                # fluidRow(
                #   style = "margin-right: 85px; margin-left:35px; background-color: #f2f2f2;",
                #   column(2,
                #          div(class = "grey-dropdown",
                #              selectInput("m6_RnD_table_year", "", choices = unique(df$Year), selected = 2022),
                #          )),
                #   column(4,
                #          div(class = "grey-dropdown",
                #              selectInput("m6_RnD_table_labourtype", "", choices = unique(df$measure), selected = "Labour productivity"),
                #          )),
                #   column(4,
                #          div(class = "grey-dropdown",
                #              selectInput("m6_RnD_table_industry", "", choices = unique(df$Industry)),  
                #          )),
                #   column(2,
                #          style = "background-color: #f2f2f2; height: 20px; padding-top : 40px; display: flex; justify-content: center; align-items: center;",
                #          downloadButton("m6_RnD_table_dwnbtt" , label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt"))
                #   ),
                # ),
                # h3("Total number of jobs by sector"),
                ####### Treemap----
                # fluidRow(
                #   div(
                #     style = "position: relative; margin-right: 100px; margin-left: 50px;height:250px;",
                #     plotlyOutput("m6_RnD_treemap"),
                #     div(
                #       icon("area-chart", "fa-4x"),
                #       style = "color: white;
                #      position: absolute;
                #      top: 0px;
                #      left: -35px;
                #      background-color: #FEB70D;
                #      border-bottom-left-radius: 10px;
                #      border-bottom-right-radius: 10px;
                #      padding: 10px;
                #      z-index: 10;"
                #     )
                #   )
                # ),
                #source
                # fluidRow(
                #   style = "background-color: #f2f2f2; padding-left: 60px; padding-right:40px; margin-left: 35px; margin-right: 85px; height: 20px; font-size: 12px;",
                #   "Source: Statistics Canada, Table 36-10-0480-01"
                # ),
                # input
                # fluidRow(
                #   style = "margin-right: 85px; margin-left:35px; background-color: #f2f2f2;",
                #   column(4,
                #          div(class = "grey-dropdown",
                #              selectInput("m6_RnD_treemap_geo", "", choices = unique(df$GEO), selected = "British Columbia"),                          )),
                #   column(4,
                #          div(class = "grey-dropdown",
                #              selectInput("m6_RnD_treemap_year", "", choices = unique(df$Year), selected = 2022)),
                #   ),
                #   column(2),
                #   column(2,
                #          style = "background-color: #f2f2f2; height: 20px; padding-top : 40px; display: flex; justify-content: center; align-items: center;",
                #          downloadButton("m6_RnD_treemap_dwnbtt" , label = NULL, class = "btn-custom-black", icon = icon("cloud-download-alt"))
                #   ),
                # ),
                # fluidRow(style = "height : 200px;")
                #----
            # )
            
  #       )
  #     ) 
  #   )
  # )}
