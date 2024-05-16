### Home ----
ui_m2_home <- function(df2){
  extra_css <- "
          .info-box {
            height: 200px; /* Adjust the height as needed */
          }
          "
  tabItem(tabName = "m2_home",
          h3("Building resilient communities") ,
          fluidRow(
            infoBox("Childcare availability", "$1000", icon = icon("balance-scale"), color = "purple", width = 3, href = "page1"),
            infoBox("New business openings",  Extract_Status(df2, "People"), icon = icon("industry", class = "glyphicon-large"), color = "blue", width = 3, href = "NBO"),
            infoBox("Industry diversification", "$1000", icon = icon("info"), color = "purple", width = 6, href = "page1")
          ),
          fluidRow(
            infoBox("Housing availability", "$1000", icon = icon("info"), color = "purple", width = 6, href = "page1") ,
            infoBox("Government investment in infrastructure", "$1000", icon = icon("info"), color = "purple", width = 6, href = "page1") ,
            infoBox("BlGBox", "$1000", icon = icon("info"), color = "purple", width = 6, href = "page1")
          ),
          fluidRow(
            infoBox("Labour underutilization rate", "$1000", icon = icon("info"), color = "purple", width = 6, href = "page1") ,
            infoBox("Labour market participation rate", "$1000", icon = icon("info"), color = "purple", width = 6, href = "page1") ,
            infoBox("Occurrences of violent crime", "$1000", icon = icon("info"), color = "purple", width = 6, href = "page1"),
            infoBox("Valid human rights complaints", "$1000", icon = icon("info"), color = "purple", width = 6, href = "page1"),
            infoBox("Police-reported hate crime", "$1000", icon = icon("info"), color = "purple", width = 6, href = "page1"),
            infoBox("Public transit ridership", "$1000", icon = icon("info"), color = "purple", width = 6, href = "page1")
            )
          )
}
          



### NBO ----
ui_m2_NBO <- function(df1){
  tabItem(tabName = "NBO",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 2-1-1: New Business Openings" ))
            ),
            fluidRow(
              column(1),
              column(10,plotlyOutput("m2_NBO_lineplot")),
              column(1, downloadButton("m2_NBO_lineplot_dwnbtt", ""))
            )
          ),
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
              column(9, h3("Figure 2-4-1: Occurance of Violent Crime" ))
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





