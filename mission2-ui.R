### Home ----
ui_m2_home <- function(df_m2_NBO_1, df_m2_HA_1, df_m2_LMPR_1, 
                       df_m2_OVC_1, df_m2_GII_1, df_m2_PRHC_1){
  tabItem(tabName = "m2_home",
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
              class = "main-title",
              "Building Resilient Communities"),
            div(style = "height: 20px;"),  
            fluidRow(
              wormchart_ui(df = df_m2_NBO_1, 
                           button = "m2_homepage_button_NBO",
                           title = "New Business Openings",
                           worm = "m2_homepage_worm_NBO",
                           triangle = "m2_homepage_triangle_NBO"),
              
              wormchart_ui(df = df_m2_HA_1, 
                           button = "m2_homepage_button_HA",
                           title = "Housing Availability",
                           worm = "m2_homepage_worm_HA",
                           triangle = "m2_homepage_triangle_HA"),
              
              wormchart_ui(df = df_m2_LMPR_1, 
                           button = "m2_homepage_button_LMPR",
                           title = "Labour Market Participation Rate",
                           worm = "m2_homepage_worm_LMPR",
                           triangle = "m2_homepage_triangle_LMPR"),
            ),
            div(style = "height: 20px;"),  # Space between first and second rows of boxes
            fluidRow(
              wormchart_ui(df = df_m2_OVC_1, 
                           button = "m2_homepage_button_OVC",
                           title = "Occurances of Violent Crime",
                           worm = "m2_homepage_worm_OVC",
                           triangle = "m2_homepage_triangle_OVC"),
              
              wormchart_ui(df = df_m2_GII_1, 
                           button = "m2_homepage_button_GII",
                           title = "Government Investment in Infrastructure",
                           worm = "m2_homepage_worm_GII",
                           triangle = "m2_homepage_triangle_GII"),
              
              wormchart_ui(df = df_m2_PRHC_1, 
                           button = "m2_homepage_button_PRHC",
                           title = "Police_reported Hate Crime",
                           worm = "m2_homepage_worm_PRHC",
                           triangle = "m2_homepage_triangle_PRHC"),
            )
          ))}

# ui_m2_home <- function(df_m2_NBO, df_m2_HA, df_m2_LMPR, df_m2_OVC, df_m2_GII, df_m2_PRHC){
#   style2 <- "background-color:white; height: 130px; padding: 2px; border-radius: 15px; border: 6px solid #ecf0f5;font-size: 18px;text-align: center;"
#   style1 <- "background-color:#156082; color:white; height: 80px; width:98%; padding: 6px; border-radius: 15px; border: 6px solid white;font-size: 24px; text-align: center;margin: 0 auto;"
#   tabItem(tabName = "m2_home",
#           fluidPage(
#             fluidRow(
#               style = "border: 20px solid #ecf0f5;",
#               column(3,
#                      style = "height:100px;"
#               ), 
#               column(3, style = style2,
#                      actionButton("m2_NBO_Button", 
#                                   label = HTML(Extract_Status(df_m2_NBO, "%")), 
#                                   style = style1),
#                      "New Business Openings"
#               ),
#               column(3, style = style2,
#                      actionButton("m2_HA_Button", 
#                                   label = HTML(Extract_Status(df_m2_HA, "%")), 
#                                   style = style1),
#                      "Housing Availability"
#               ),
#               column(3, style = style2,
#                      actionButton("m2_LMPR_Button", 
#                                   label = HTML(Extract_Status(df_m2_LMPR, "")), 
#                                   style = style1),
#                      "Labour Market Participation Rate"
#               )),
#             fluidRow(
#               style = "border: 20px solid #ecf0f5;",
#               column(3,
#                      style = "height:100px;"
#               ),
#               column(3, style = style2,
#                      actionButton("m2_OVC_Button", 
#                                   label = HTML(Extract_Status(df_m2_OVC, "%")), 
#                                   style = style1),
#                      "Occurrences of Violent Crime"
#               ),
#               column(3, style = style2,
#                      actionButton("m2_GII_Button", 
#                                   label = HTML(Extract_Status(df_m2_GII, "%")), 
#                                   style = style1),
#                      "Government Investment in Infrastructure"
#               )
#             ),
#             fluidRow(
#               style = "border: 20px solid #ecf0f5;",
#               column(3,
#                      fluidRow(h2(HTML("MISSION2:<br/>BUILDING<br/>RESILIENT<br/>COMMUNITIES"))),
#                      style = "background-color:#156082; color:white; height:400px; padding: 10px 20px; border-radius: 15px; border: 4px solid #ecf0f5;font-size: 36px;text-align: center;"
#               ), 
#               column(3, style = style2,
#                      actionButton("m2_PRHC_Button", 
#                                   label = HTML(Extract_Status(df_m2_PRHC, "%")), 
#                                   style = style1),
#                      "Police_reported Hate Crime"
#               )
#               
#             )
#           ))}




### NBO ----
ui_m2_NBO <- function(df1){
  tabItem(tabName = "NBO",
          ##### Line Plot----
          ui_main_chart(title = "New Business Openings",
                        chart_name = "m2_NBO_lineplot",
                        button_name = "m2_NBO_lineplot_dwnbtt",
                        source = "Statistics Canada, Table 36-10-0480-01",
                        summary = "Exesum_m2_NBO_main"),
          ##### EXESUM ----
          fluidPage(
            style = "background-color: aliceblue ; margin: 20px;",
            fluidRow(
              column(12, h2("Executive Summary"))
            ),
            fluidRow(
              column(12, uiOutput("exesum_m2_NBO"))
            )
          )
          
  )}


### HA ----
ui_m2_HA <- function(df1){
  tabItem(tabName = "HA",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 2-2-1: Housing Availability" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m2_HA_lineplot")),
              column(1, downloadButton("m2_HA_lineplot_dwnbtt", ""))
            )
          ),
          ##### EXESUM ----
          fluidPage(
            style = "background-color: aliceblue ; margin: 20px;",
            fluidRow(
              column(12, h2("Executive Summary"))
            ),
            fluidRow(
              column(12, uiOutput("exesum_m2_HA"))
            )
          )
          
  )}


### LMPR ----
ui_m2_LMPR <- function(df1){
  tabItem(tabName = "LMPR",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 2-3-1: Labour Market Participation Rate" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m2_LMPR_lineplot")),
              column(1, downloadButton("m2_LMPR_lineplot_dwnbtt", ""))
            )
          ),
          ##### EXESUM ----
          fluidPage(
            style = "background-color: aliceblue ; margin: 20px;",
            fluidRow(
              column(12, h2("Executive Summary"))
            ),
            fluidRow(
              column(12, uiOutput("exesum_m2_LMPR"))
            )
          )
          
  )}



### OVC ----
ui_m2_OVC <- function(df1){
  tabItem(tabName = "OVC",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 2-4-1: Occurrences of Violent Crime" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m2_OVC_lineplot")),
              column(1, downloadButton("m2_OVC_lineplot_dwnbtt", ""))
            )
          ),
          ##### EXESUM ----
          fluidPage(
            style = "background-color: aliceblue ; margin: 20px;",
            fluidRow(
              column(12, h2("Executive Summary"))
            ),
            fluidRow(
              column(12, uiOutput("exesum_m2_OVC"))
            )
          )
          
  )}




### GII ----
ui_m2_GII <- function(df1){
  tabItem(tabName = "GII",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 2-5-1: Government investments in infrastructure" ))
            ),
            fluidRow(
              column(1),
              column(10, plotlyOutput("m2_GII_lineplot")),
              column(1, downloadButton("m2_GII_lineplot_dwnbtt", ""))
            )
          ),
          ##### EXESUM ----
          fluidPage(
            style = "background-color: aliceblue ; margin: 20px;",
            fluidRow(
              column(12, h2("Executive Summary"))
            ),
            fluidRow(
              column(12, uiOutput("exesum_m2_GII"))
            )
          )
          
  )}

### PRHC ----
ui_m2_PRHC <- function(df1){
  tabItem(tabName = "PRHC",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 2-6-1: Police-reported Hate Crime" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m2_PRHC_lineplot")),
              column(1, downloadButton("m2_PRHC_lineplot_dwnbtt", ""))
            )
          ),
          ##### EXESUM ----
          fluidPage(
            style = "background-color: aliceblue ; margin: 20px;",
            fluidRow(
              column(12, h2("Executive Summary"))
            ),
            fluidRow(
              column(12, uiOutput("exesum_m2_PRHC"))
            )
          )
          
  )}





