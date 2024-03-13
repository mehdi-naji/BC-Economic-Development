### UR ----
ui_m1_UR <- function(df1, df2, df3, df4){
  tabItem(tabName = "UR",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 1-1-1: Unemploymnet Rate" ))
            ),
            fluidRow(
              column(9,plotlyOutput("m1_UR_lineplot")),
              column(3,
                     selectInput("m1_UR_lineplot_geo", "Region", choices = unique(df2$GEO), selected = "British Columbia"),
                     selectInput("m1_UR_lineplot_character", "Labour force characteristics", choices = unique(df2$Character), selected = "Unemployment rate"),
                     selectInput("m1_UR_lineplot_sex", "Sex", choices = unique(df2$Sex), selected = "Both sexes"),
                     selectInput("m1_UR_lineplot_age", "Age group", choices = unique(df2$Age), selected = "15 years and over"),
                     downloadButton("m1_UR_lineplot_dwnbtt", "Download Filtered Data in CSV"))
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
              column(9, h3("Figure 1-1-1: Unemploymnet Rate" ))
            ),
            fluidRow(
              column(9,plotOutput("m1_UR_waffle")),
              column(3,
                     selectInput("m1_UR_waffle_year", "Year", choices = unique(df4$Year), selected = 2010),
                     selectInput("m1_UR_waffle_geo", "GEO", choices = unique(df4$GEO), selected = "British Columbia"),
                     downloadButton("m1_UR_waffle_dwnbtt", "Download Filtered Data in CSV"))
            )
          ),
          
  )}