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
              actionButton("m2_to_homepage", label = "Building Resilient Communities", class = "main-title")),
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

### NBO ----
ui_m2_NBO <- function(df1){
  tabItem(tabName = "NBO",
          go_to_button("NBO_mission2", "Mission 2", "NBO_home", "Home Page"),
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
          go_to_button("HA_mission2", "Mission 2", "HA_home", "Home Page"),
          ##### Line Plot----
          ui_main_chart(title = "Housing Availability",
                        chart_name = "m2_HA_lineplot",
                        button_name = "m2_HA_lineplot_dwnbtt",
                        source = "Statistics Canada, Table 36-10-0480-01",
                        summary = "Exesum_m2_HA_main"),

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
          go_to_button("LMPR_mission2", "Mission 2", "LMPR_home", "Home Page"),
          ##### Line Plot----
          ui_main_chart(title = "Labour Market Participation Rate",
                        chart_name = "m2_LMPR_lineplot",
                        button_name = "m2_LMPR_lineplot_dwnbtt",
                        source = "Statistics Canada, Table 36-10-0480-01",
                        summary = "Exesum_m2_LMPR_main"),
 
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
          go_to_button("OVC_mission2", "Mission 2", "OVC_home", "Home Page"),
          ##### Line Plot----
          ui_main_chart(title = "Occurrences of Violent Crime",
                        chart_name = "m2_OVC_lineplot",
                        button_name = "m2_OVC_lineplot_dwnbtt",
                        source = "Statistics Canada, Table 36-10-0480-01",
                        summary = "Exesum_m2_OVC_main"),
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
          go_to_button("GII_mission2", "Mission 2", "GII_home", "Home Page"),
          ##### Line Plot----
          ui_main_chart(title = "Government investments in infrastructure",
                        chart_name = "m2_GII_lineplot",
                        button_name = "m2_GII_lineplot_dwnbtt",
                        source = "Statistics Canada, Table 36-10-0480-01",
                        summary = "Exesum_m2_GII_main"),
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
          go_to_button("PRHC_mission2", "Mission 2", "PRHC_home", "Home Page"),
          ##### Line Plot----
          ui_main_chart(title = "Police-reported Hate Crime",
                        chart_name = "m2_PRHC_lineplot",
                        button_name = "m2_PRHC_lineplot_dwnbtt",
                        source = "Statistics Canada, Table 36-10-0480-01",
                        summary = "Exesum_m2_PRHC_main"),
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





