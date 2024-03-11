### CEG ----
ui_m5_CEG <- function(df1){
  tabItem(tabName = "CEG",
          ##### Line Plot----
          fluidPage(
            style = "background-color: white;margin: 20px;",
            fluidRow(
              column(9, h3("Figure 5-1-1: Clean Energy Generated" ))
            ),
            fluidRow(
              column(9,plotlyOutput("m5_CEG_lineplot")),
              column(3,
                     selectInput("m5_CEG_lineplot_geo", "Region", choices = unique(df1$GEO), selected = "British Columbia"),
                     selectInput("m5_CEG_lineplot_class", "Class of electricity producer", choices = unique(df1$Class.of.electricity.producer)),
                     selectInput("m5_CEG_lineplot_type", "Type of electricity generation", choices = unique(df1$Type.of.electricity.generation)),
                     downloadButton("m5_CEG_lineplot_dwnbtt", "Download Filtered Data in CSV"))
            )
          ),
          ##### EXESUM ----
          fluidPage(
            style = "background-color: aliceblue ; margin: 20px;",
            fluidRow(
              column(12, h2("Executive Summary"))
            ),
            fluidRow(
              column(12, uiOutput("exesum_m5_CEG"))
            )
          )
          
  )}

