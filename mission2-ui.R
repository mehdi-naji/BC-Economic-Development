### Home ----
ui_m2_home <- function(df_m2_NBO, df_m2_HA, df_m2_LMPR, df_m2_OVC, df_m2_GII, df_m2_PRHC){
  style2 <- "background-color:white; height: 130px; padding: 2px; border-radius: 15px; border: 6px solid #ecf0f5;font-size: 18px;text-align: center;"
  style1 <- "background-color:#156082; color:white; height: 80px; width:98%; padding: 6px; border-radius: 15px; border: 6px solid white;font-size: 24px; text-align: center;margin: 0 auto;"
  tabItem(tabName = "m2_home",
          fluidPage(
            fluidRow(
              style = "border: 20px solid #ecf0f5;",
              column(3,
                     style = "height:100px;"
              ), 
              column(3, style = style2,
                     actionButton("m2_NBO_Button", 
                                  label = HTML(Extract_Status(df_m2_NBO, "%")), 
                                  style = style1),
                     "New Business Openings"
              ),
              column(3, style = style2,
                     actionButton("m2_HA_Button", 
                                  label = HTML(Extract_Status(df_m2_HA, "%")), 
                                  style = style1),
                     "Housing Availability"
              ),
              column(3, style = style2,
                     actionButton("m2_LMPR_Button", 
                                  label = HTML(Extract_Status(df_m2_LMPR, "")), 
                                  style = style1),
                     "Labour Market Participation Rate"
              )),
            fluidRow(
              style = "border: 20px solid #ecf0f5;",
              column(3,
                     style = "height:100px;"
              ),
              column(3, style = style2,
                     actionButton("m2_OVC_Button", 
                                  label = HTML(Extract_Status(df_m2_OVC, "%")), 
                                  style = style1),
                     "Occurrences of Violent Crime"
              ),
              column(3, style = style2,
                     actionButton("m2_GII_Button", 
                                  label = HTML(Extract_Status(df_m2_GII, "%")), 
                                  style = style1),
                     "Government Investment in Infrastructure"
              )
            ),
            fluidRow(
              style = "border: 20px solid #ecf0f5;",
              column(3,
                     fluidRow(h2(HTML("MISSION2:<br/>BUILDING<br/>RESILIENT<br/>COMMUNITIES"))),
                     style = "background-color:#156082; color:white; height:400px; padding: 10px 20px; border-radius: 15px; border: 4px solid #ecf0f5;font-size: 36px;text-align: center;"
              ), 
              column(3, style = style2,
                     actionButton("m2_PRHC_Button", 
                                  label = HTML(Extract_Status(df_m2_PRHC, "%")), 
                                  style = style1),
                     "Police_reported Hate Crime"
              )
              
            )
          ))}




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





