# Libraries ----
library(shiny)
library(ggplot2)
library(tidyr)
library(tidyverse)
library(tidyquant)
library(lubridate)
library(plotly)
library(leaflet)
library(cowplot)
library(grid)
library(gtable)
library(shinydashboard)
library(RColorBrewer)
library(sf)

options(shiny.autoreload = TRUE)

# Downloading processed data ----
url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Labour_Productivity_1.csv"
df <- read.csv(url, header = TRUE)
df <- na.omit(df)
df <- df |> filter(
  Labour.productivity.and.related.measures %in% c("Total number of jobs",
                                                  "Labour productivity",
                                                  "Nominal value added")
)


canada_url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/supplementary%20materials/canada-with-provinces_795.geojson"
geojson_content <- httr::GET(canada_url, httr::write_disk(tf <- tempfile(fileext = ".geojson"), overwrite = TRUE))
canada <- sf::st_read(dsn = tf, quiet = TRUE)

# Static inputs ----
modal_title1 <- "Private sector investment in innovation"
modal_text1 <- paste("The amount spent on research and development by the business enterprise sector (not adjusted for inflation) in") 
modal_title2 <- "Value-added exports"
modal_title3 <- "Non-residential structures, machinery and equipment and IP investment as share of GDP"
modal_title4 <- "Labour Productivity"
modal_title5 <- "Exports as % of GDP"

# User Interface -----
## ui_components ----
### line plot ----
ui_lineplot <- column(6,plotlyOutput("line_plot"))

### map ----
ui_map <- column(3, leafletOutput("map"))

### Pie Chart ----
ui_treemap <- column(6,plotlyOutput("treemap"))

### lines Chart ----
ui_lines <- column(6,plotlyOutput("lines"))

### table Chart ----
ui_table <-  column(3, DT::dataTableOutput("table"))


### tabs ----
ui_text_tabs <- column(6, tabsetPanel(
  tabPanel("Analysis", 
           uiOutput("analysis")),
  tabPanel("Considerations", 
           uiOutput("consideration"))))


## design -----
ui <- dashboardPage(
  dashboardHeader(
    title = tags$a(
      tags$img(src='https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/main/logo.png', height='40', width='200', style="padding-left: 25px;float: left;") , 
      tags$span("Labour Productivity", style = " color: black;font-size: 130%; "),
      href='https://strongerbc.shinyapps.io/research_and_development/',
    ),titleWidth = 500
  ),
  dashboardSidebar(
    collapsed = TRUE,
    sidebarMenu(
      ### input list ----
      menuItem("Inputs", tabName = "inputs", icon = icon("dashboard")),
        selectInput("geo", "Region", choices = unique(df$GEO), selected = "British Columbia"), 
        selectInput("industry", "Industry", choices = unique(df$Industry), selected = "Total industries"), 
        selectInput("labourtype", "Labour Productivity Measure", choices = unique(df$Labour.productivity.and.related.measures), selected = "Total number of jobs"),
        selectInput("year", "Year", choices = unique(df$Year), selected = 2019)
    )
  ),
  dashboardBody(
    tags$style(HTML("
      .skin-blue .main-header .navbar, 
      .skin-blue .main-header .logo,
      .skin-blue .main-header .logo:hover,
      .skin-blue .main-header .navbar .sidebar-toggle,
      .skin-blue .main-header .navbar .sidebar-toggle:hover,
      .skin-blue .content-header, 
      .skin-blue .wrapper, 
      .content-wrapper, 
      .right-side   { 
                      background-color: white; 
                      color: black;
      }


      .skin-blue .main-header .navbar .sidebar-toggle {
                      position: fixed;
                      left:0;
                    }
    ")),
    tags$style(type="text/css",
               ".shiny-output-error-validation {
     font-size: 15px;
    }"
    ),
    
    tags$head(tags$style(".modal-dialog { width: 80%; }")),
    tags$head(tags$style(".modal-body { min-height: 700px; }")),
    fluidPage(
      # modalDialog(
      #   easyClose = TRUE, 
      #   size = "l", 
      #   footer = tagList(modalButton("OK")),
      #   fluidRow(
      #     column(4, style = "height: 400px; background-color: white;margin-buttom: 10px;margin-right: 10px;"),
      #     column(2, style = "height: 400px; background-color: white; border: 1px solid darkgreen; margin-right: 10px;margin-buttom: 10px;", 
      #            h4(modal_title1, style = "color: darkgreen; font-weight: bold;"), 
      #            p(modal_text1),
      #            p(Modal_df$Year, 
      #              style = "font-size: 30px; font-family: Arial; color: darkgreen;"),
      #            p(paste0("$", format(Modal_df$PrivateInvestment/1000, big.mark = ",", scientific = FALSE), "billion"), 
      #              style = "font-size: 40px; font-family: Arial; color: black;")),
      #     column(2, style = "height: 400px; background-color: white; border: 1px solid darkgreen; margin-right: 10px;margin-buttom: 10px;", 
      #            h4(modal_title2, style = "color: darkgreen; font-weight: bold;"), 
      #            p("$200,000", style = "color: black;")),
      #     column(2, style = "height: 400px; background-color: white; border: 1px solid darkgreen; margin-right: 10px;margin-buttom: 10px;", 
      #            h4(modal_title3, style = "color: darkgreen; font-weight: bold;"), 
      #            p("$300,000", style = "color: black;")),
      #     column(1, style = "height: 400px; background-color: darkgreen;margin-buttom: 10px;")
      #   ),
      #   fluidRow(
      #     column(4, style = "height: 400px; background-color: darkgreen;margin-right: 10px; margin-top: 10px;", 
      #            h2("Fostering \n Innovation Across Economy", style = "color: white; font-size: 300%;")),
      #     column(3, style = "height: 400px; background-color: white; border: 1px solid darkgreen; margin-right: px; margin-top: 10px;", 
      #            h4(modal_title4, style = "color: darkgreen; font-weight: bold;"), 
      #            p("$400,000", style = "color: black;")),
      #     column(3, style = "height: 400px; background-color: white; border: 1px solid darkgreen; margin-top: 10px;", 
      #            h4(modal_title5, style = "color: darkgreen; font-weight: bold;"), 
      #            p("$500,000", style = "color: black;")),
      #     column(1, style = "height: 400px; background-color: white;")
      #   )
      # ),
      h3(textOutput("title"))
    ),
    fluidRow(
      ui_lineplot, ui_text_tabs),
    fluidRow(
      ui_treemap, ui_table, ui_map),
    fluidPage(
      textOutput("source")
    )
    ))


# Server ----
server <- function(input, output, session) {

# Data ----
## line plot data----  
  line_plot_data <- reactive({
    df %>%
      filter(GEO == input$geo,
             Industry == input$industry,
             Labour.productivity.and.related.measures == input$labourtype)
  })

## map data----  
 map_data <- reactive({
   df |> 
     filter(
       GEO != "Canada",
       Year == input$year,
       Labour.productivity.and.related.measures == input$labourtype,
       Industry == input$industry
     ) |>
     select(
       GEO, Labour.productivity.and.related.measures, Industry, VALUE 
     )
 })

  
## treemap data----
  treemap_data <- reactive({
    df |>
      filter(GEO == input$geo,
             Year == input$year,
             Labour.productivity.and.related.measures == input$labourtype,
             parent != "NONE") |>
      group_by(parent) |>
      mutate(total_value = sum(VALUE))|>
      ungroup()|>
      mutate(per_val = (VALUE / total_value) * parent_val)
  })
  
  
## lines data----  
  lines_data <- reactive({
    df |>
      filter(
        GEO == input$geo,
        Labour.productivity.and.related.measures == input$labourtype,
        Industry %in% c("Business sector industries",
                        "Energy sector",
                        "Information and communication sector",
                        "Finance and insurance, and holding companies [BS5B]",
                        "Industrial production",
                        "Non-business sector industries")
        )
  })

  ## table data----  
  table_data <- reactive({
    df |>
      filter(
        Year == input$year,
        Labour.productivity.and.related.measures == input$labourtype,
        Industry == input$industry,
        GEO %in% c("British Columbia", "Ontario", "Quebec", "Alberta", "Canada"))|>
      select (GEO, Y1_growth, Y3_growht, Y5_growth) |>
      mutate(GEO = factor(GEO, levels = c("British Columbia", "Ontario", "Quebec", "Alberta", "Canada")),
             Y1_growth = paste0(round(Y1_growth,1),"%"),
             Y3_growht = paste0(round(Y3_growht,1),"%"),
             Y5_growth = paste0(round(Y5_growth,1),"%"))|>
      arrange(GEO)|>
      rename(Region = GEO) |>
      rename_with(~paste0("one-year growth <br>(", as.numeric(as.character(input$year))-1, "-", as.numeric(as.character(input$year)) ,")") , Y1_growth)|>
      rename_with(~paste0("3-year growth <br>(", as.numeric(as.character(input$year))-3, "-", as.numeric(as.character(input$year)) ,")") , Y3_growht)|>
      rename_with(~paste0("5-year growth <br>(", as.numeric(as.character(input$year))-5, "-", as.numeric(as.character(input$year)) ,")") , Y5_growth)

  })
# Rendering ----

  # output$title <- renderText({
  #   if (input$funder == " business enterprise sector") {
  #     "Private Sector Investment in Innovation"
  #   } else if (input$funder == " federal government sector") {
  #     "Federal Government Investment in Innovation"
  #   } else if (input$funder == " provincial governments sector") {
  #     "Provincial Government Investment in Innovation"
  #   } else if (input$funder == " provincial research organizations sector") {
  #     "Provincial Research Organizations Investment in Innovation"
  #   } else if (input$funder == " foreign sector") {
  #     "Foreign Investment in Innovation"
  #   } else if (input$funder == " higher education sector") {
  #     "Higher Education Investment in Innovation"
  #   } else {"Investment in Innovation"}
  # })
  
## line plot ----
  output$line_plot <- renderPlotly({
    df1 <- line_plot_data()
    unit1 <- df1 |> pull(UOM) |> unique()
    p1 <- df1 |> 
            plot_ly(x = ~Year, y = ~VALUE, type = 'scatter', mode = 'lines') |>
            layout(title = list(text = paste(input$labourtype, "of" , input$industry, "in" , input$geo)),
                   xaxis = list(
                     title = "", 
                     rangeslider = list(
                       visible = T,
                       thickness = 0.03,  
                       bgcolor = "darkgrey"  
                     )
                   ),
             yaxis = list(title = paste (unit1)))
  validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
    
  p1 
  })   
  
  
  
  ## treemap diagram ----
  output$treemap <- renderPlotly({
    if (input$labourtype == "Labour productivity") {
      df2 <- lines_data()
      p <- df2 |>
        plot_ly(x = ~Year, y =~Y1_growth, color = ~Industry, type = 'scatter', mode = 'lines') |>
        layout(legend = list(orientation = 'h', x = 0.5, xanchor = 'center', y = -0.3, yanchor = 'top'))
      
      p
            
    } else {
      df2 <- treemap_data()
      p <- df2 |>
        plot_ly(
          type = 'treemap',
          branchvalues = "total",
          labels = ~Industry,
          parents = ~parent,
          values = ~per_val)
      validate(need(nrow(df2) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
      p}
      })
  
  
  ## table----
  output$table <- DT::renderDataTable({
    data <- table_data()
    DT::datatable(data, options = list(dom = 't'), escape = FALSE, rownames = FALSE, 
                  caption = htmltools::tags$caption("",
                                                    style = "font-family: Arial; font-size: 12px;"))
  })
  
  
  
  # Render the text boxes
  
  output$text_box_2 <- renderText({
    paste("This is the second text box.")
  })
  

  ## map plot ----
  output$map <- renderLeaflet({
    df_map <- map_data()
    merged_df <- merge(canada, df_map, by.x="prov_name_en", by.y="GEO", all.x = TRUE)
    canada$VALUE <- merged_df$VALUE
    # Create a color palette
    pal <- colorNumeric(palette = "viridis", domain = canada$VALUE)
    
    p2 <- leaflet(data = canada, options = leafletOptions(minZoom = 2, maxZoom = 2, dragging = FALSE, doubleClickZoom = FALSE, scrollWheelZoom = FALSE, touchZoom = FALSE, keyboard = FALSE)) %>%
      addProviderTiles(providers$CartoDB.Positron) %>%
      addPolygons(fillColor = ~pal(canada$VALUE),
                  fillOpacity = 0.8,
                  color = "#BDBDC3",
                  weight = 1,
                  popup = ~paste0("<b>", prov_name_en, "</b><br>Value: ", round(canada$VALUE, 2))) |>
      leaflet::addLegend(pal = pal,
                         values = canada$VALUE,
                         title = "Value",
                         position = "bottomleft")
    
    validate(need(nrow(df_map) > 0, "The data for this year is inadequate. To obtain a proper visualization, please modify the year selection in the sidebar."))
    p2
  })
  
  

  
  output$analysis <- renderUI({
    HTML("
  <ul style='text-align: justify;'>
    <li>Spending on research and development promotes scientific and technological advancement while fostering economic progress through growth, productivity, adaptation, and market resilience.</li>
    <li>Between 2020 and 2021, private sector R&D spending in British Columbia grew by $341 million to $3.028 billion. It increased by 263 percent from $835 million in 2000.</li>
    <li>Private sector accounted for 50.5 percent of overall R&D spending in the province in 2021, highest in Canada.</li>
    <li>B.C.’s private sector has seen a sharp increase in R&D spending in 2018, with an annual growth rate at 26.1 percent, the highest in the past 20 years.</li>
    <li>B.C. surpassed Alberta in private sector R&D spending in 2016 and have remained third in Canada, following Ontario and Quebec.</li>
    <li>Canada’s R&D intensity remained at 1.9 percent, below the G7 average (2.6) in 2020. In 2020, B.C.’s R&D spending was 1.7 percent of its GDP, placing it third in Canada.</li>
  </ul>
  ")
  })
  
  
  
  output$consideration <- renderUI({
    HTML("
  <ul style='text-align: justify;'>
    This dashboard was developed under the supervision of the Economic Strategy Branch, Sustainable Economy Division of the Ministry of Jobs, Economic Development and Innovation.
    <br>
    ---
    <br>
    <b>Data Source:</b>
    <li>The information displayed on this dashboard is derived from StatCan's tables:
      <ul>
        <li>Table 27-10-0273-01: Gross Domestic Expenditures on Research and Development, by Science Type and by Funder and Performer Sector</li>
        <li>Table 27-10-0273-02: Expenditures on Research and Development (R&D) by Performing Sector</li>
        <li>Table 27-10-0359-01: Total Domestic Expenditures on Research and Development (R&D) as Percentage of Gross Domestic Product (GDP), Canada and Provinces, and G-7 Countries</li>
      </ul>
    </li>
  </ul>
")
  })
  
  output$source <- renderText({
    "2024 Ministry of Jobs, Economic Development and Innovation, Sustainable Economy Devision. All rights reserved. "
  })
  
  
}

# Run the app
shinyApp(ui = ui, server = server)

