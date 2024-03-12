### GII ----
ui_m2_GII <- function(df1){
  tabItem(tabName = "GII",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 2-1-1: Government investments in infrastructure" ))
            ),
            fluidRow(
              column(9,plotlyOutput("m2_GII_lineplot")),
              column(3,
                     selectInput("m2_GII_lineplot_geo", "Region", choices = unique(df1$GEO), selected = "British Columbia"),
                     selectInput("m2_GII_lineplot_prices", "Type of Prices", choices = unique(df1$Prices), selected = "Current dollars"),
                     selectInput("m2_GII_lineplot_industry", "Purchasing industry", choices = unique(df1$Purchasing.industry), selected = "Total industries"),
                     selectInput("m2_GII_lineplot_asset", "Asset function", choices = unique(df1$Asset.function), selected = "All functions"),
                     downloadButton("m2_GII_lineplot_dwnbtt", "Download Filtered Data in CSV"))
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

