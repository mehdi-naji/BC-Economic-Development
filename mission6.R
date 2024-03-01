
# Loading data----
    ## Canada Map----
    load_canada_map <- function(){
      canada_url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/supplementary%20materials/canada-with-provinces_795.geojson"
      geojson_content <- httr::GET(canada_url, httr::write_disk(tf <- tempfile(fileext = ".geojson"), overwrite = TRUE))
      sf::st_read(dsn = tf, quiet = TRUE)
    }
    
    ## RnD----
    load_m6_RnD1 <- function() {
      url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Research_and_Development_1.csv"
      df <- read.csv(url, header = TRUE)
      df <- na.omit(df)
      return(df)
    }
    
    load_m6_RnD2 <- function() {
      url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Research_and_Development_3.csv"
      df <- read.csv(url, header = TRUE)
      df <- na.omit(df)
      return(df)
    }
    
    ## VAEX----
    load_m6_VAEX1 <- function() {
      url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/VA_Exporsts_1.csv"
      df <- read.csv(url, header = TRUE)
      df <- na.omit(df)
      df <- df |>   mutate(Industry = str_remove(Industry, "\\s\\[.*\\]$"))
    
      return(df)
    }
    
    ## Non-residential Investment----
    load_m6_nRinv1 <- function() {
      url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Non_Residential_Investment_1.csv"
      df <- read.csv(url, header = TRUE)
      df <- na.omit(df)
      return(df)
    }
    
    ## LabourProductivity
    load_m6_lp1 <- function() {
      url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Labour_Productivity_1.csv"
      df <- read.csv(url, header = TRUE)
      df <- na.omit(df)
      df<- df |> filter(
        Labour.productivity.and.related.measures %in% c("Total number of jobs",
                                                        "Labour productivity"))
      return(df)
    }
    
    ## Export----
    load_m6_exp1 <- function() {
      url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Export_1.csv"
      df <- read.csv(url, header = TRUE)
      df <- df|> filter(EXP_type != "Export Percent Change")
      return(df)
    }
    
    load_m6_exp2 <- function() {
      url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Export_2.csv"
      df <- read.csv(url, header = TRUE)
      return(df)
    }
    
    load_m6_exp3 <- function() {
      url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Export_3.csv"
      df <- read.csv(url, header = TRUE)
      return(df)
    }
    
    load_m6_exp4 <- function() {
      url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Export_4.csv"
      df <- read.csv(url, header = TRUE)
      df <- na.omit(df)
      
      return(df)
    }
    

# RnD Dash ----
    ## Line plot----
    m6_RnD_lineplot_data <- function(df, geo, funder, performer, science_type, prices) {
      df |>
        filter(GEO == geo,
               Funder == funder,
               Performer == performer,
               Science.type == science_type,
               Prices == prices)
    }
    
    m6_RnD_render_lineplot <- function(df, input){
      df1 <- m6_RnD_lineplot_data(df, input$m6_RnD_lineplot_geo, input$m6_RnD_lineplot_funder, input$m6_RnD_lineplot_performer, input$m6_RnD_lineplot_science_type, input$m6_RnD_lineplot_prices)
      p1 <- df1 |> 
        plot_ly(x = ~Year, y = ~VALUE, type = 'scatter', mode = 'lines') |>
        layout(xaxis = list(
          title = "", 
          rangeslider = list(
            visible = T,
            thickness = 0.02,  
            bgcolor = "darkgrey"  
          )
        ),
        yaxis = list(title = paste ("million $")))
      validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
      
      p1 <- ggplotly(p1)
      return(p1)
    }
    
    ## Bar plot----
    
    m6_RnD_barplot_data <- function(df, year){
      df |> 
        filter (Year == year,
                GEO %in% c("British Columbia", 
                           "Ontario", 
                           "Quebec", 
                           "Alberta", 
                           "Canada", 
                           "France", 
                           "Germany", 
                           "Italy", 
                           "Japan", 
                           "United Kingdom", 
                           "United States")
        )|>
        arrange(VALUE) %>%
        mutate(GEO = factor(GEO, levels = GEO),
               color = case_when(
                 GEO == "Ontario" ~ "lightblue1" ,
                 GEO == "Quebec" ~ "lightskyblue1" ,
                 GEO == "Alberta" ~ "lightskyblue2" ,
                 GEO == "British Columbia" ~ "steelblue3",
                 GEO == "Canada" ~ "royalblue4",
                 GEO == "United States" ~ "#00868B",
                 TRUE ~ "darkgrey"))
    }
    
    m6_RnD_render_barplot <- function(df, input){
      df2 <- m6_RnD_barplot_data(df, input$m6_RnD_barplot_year)
      df2$formatted_VALUE <- sprintf("<b>%.1f%%</b>", df2$VALUE)
      df2$adjusted_VALUE <- df2$VALUE + 0.1
      p2 <- df2 |> 
        plot_ly(x = ~VALUE,y=~GEO, color=~GEO, type = 'bar',
                colors = ~color, showlegend = FALSE)  |>
        add_text(x = ~adjusted_VALUE,text = ~formatted_VALUE, textposition = 'outside')
      validate(need(nrow(df2) > 0, "The data for this year is inadequate. To obtain a proper visualization, please modify the year selection in the sidebar."))
      return(p2)
    }
    
    ## Table ----
    
    m6_RnD_table_data <- function(df, year , funder, performer, science_type, prices){
        df |>
          arrange(GEO, Funder, Performer, Science.type, Prices, Year) |>
          filter(Year %in% c(as.numeric(as.character(year)) -5, 
                             as.numeric(as.character(year))-3, 
                             as.numeric(as.character(year)))) |>
          group_by(GEO, Funder, Performer, Science.type, Prices) |>
          mutate(Maxyear = year,
                 GR5 = ifelse(all(c(as.numeric(as.character(year))-5, 
                                    as.numeric(as.character(year))) %in% Year), 
                              (VALUE[Year == as.numeric(as.character(year))] / VALUE[Year == as.numeric(as.character(year))-5]) - 1, NA),
                 GR3 = ifelse(all(c(as.numeric(as.character(year))-3, 
                                    as.numeric(as.character(year))) %in% Year), 
                              (VALUE[Year == as.numeric(as.character(year))] / VALUE[Year == as.numeric(as.character(year))-3]) - 1, NA))|>
          select(GEO, Funder, Performer, Science.type, Prices, GR5, GR3, Maxyear, Year)|>
          distinct(.keep_all = TRUE) |>
          filter (GEO %in% c("British Columbia", "Ontario", "Quebec", "Alberta", "Canada"),
                  Year == as.numeric(as.character(year)),
                  Funder == funder,
                  Performer == performer,
                  Science.type == science_type,
                  Prices == prices)|>
          ungroup()|>
          select (GEO, GR3, GR5, Maxyear) |>
          mutate(GR5 = paste0(round(GR5*100,1),"%"),
                 GR3 = paste0(round(GR3*100,1),"%"))|>
          mutate(GEO = factor(GEO, levels = c("British Columbia", "Ontario", "Quebec", "Alberta", "Canada")))|>
          arrange(GEO)|>
          rename(Region = GEO) |>
          rename_with(~paste0("3-year growth <br>(", as.numeric(as.character(year))-3, "-", as.numeric(as.character(year)) ,")") , GR3)|>
          rename_with(~paste0("5-year growth <br>(", as.numeric(as.character(year))-5, "-", as.numeric(as.character(year)) ,")") , GR5)|>
          select(-Maxyear)
        
      }
    
    
    
    m6_RnD_render_table <- function(df, input){
      data <- m6_RnD_table_data(df, input$m6_RnD_table_year, input$m6_RnD_table_funder, input$m6_RnD_table_performer, input$m6_RnD_table_science_type, input$m6_RnD_table_prices )
      DT::datatable(data, options = list(dom = 't'), escape = FALSE, rownames = FALSE)
    }
    
    ## Sankey Plot----
    m6_RnD_sankey_data <- function(df, year , geo, science_type){
      df |>
        filter(Year == year,
               GEO == geo,
               Science.type == science_type,
               Prices == "Current prices",
               Funder != " total, all sectors",
               Performer != " total, all sectors") |>
        mutate(Funder = paste(Funder, "(F)", sep = " "),
               Performer = paste(Performer, "(P)", sep = " "))
    }
    
    m6_RnD_render_sankey <- function(df, input){
      df1 <- m6_RnD_sankey_data(df, input$m6_RnD_sankey_year, input$m6_RnD_sankey_geo, input$m6_RnD_sankey_science_type)
      nodes <- data.frame(name = c(as.character(df1$Funder), as.character(df1$Performer)))
      nodes <- unique(nodes)
      links <- data.frame(source = match(df1$Funder, nodes$name) - 1,
                          target = match(df1$Performer, nodes$name) - 1,
                          value = df1$VALUE)
      
      
      node_colors <- c(                      " total, all sectors (F)" = "grey",
                                             " federal government sector (F)" = "#8DB6CD", 
                                             " provincial governments sector (F)" = "#00EEEE", 
                                             " provincial research organizations sector (F)" = "#edbf33",
                                             " business enterprise sector (F)" = "#4F94CD",
                                             " higher education sector (F)" = "#27408B", 
                                             " private non-profit sector (F)" = "#27aeef", 
                                             " foreign sector (F)" = "#BFEFFF",
                                             " total, all sectors (P)" = "grey",
                                             " federal government sector (P)" = "#8DB6CD", 
                                             " provincial governments sector (P)" = "#00EEEE", 
                                             " provincial research organizations sector (P)" = "#edbf33",
                                             " business enterprise sector (P)" = "#4F94CD",
                                             " higher education sector (P)" = "#27408B", 
                                             " private non-profit sector (P)" = "#27aeef")
      
      
      nodes$color <- node_colors[nodes$name]
      
      links$source_name <- nodes$name[links$source + 1]
      links$target_name <- nodes$name[links$target + 1]
      
      fig <- plot_ly(
        type = "sankey",
        domain = list(
          x = c(0,1),
          y = c(0,1)
        ),
        orientation = "h",
        valueformat = "$,.0f",
        valuesuffix = "M",
        node = list(
          label = nodes$name,
          color = nodes$color,
          pad = 15,
          thickness = 30,
          line = list(
            color = "grey",
            width = 0.5
          ),
          hovertemplate = '%{label}<br>Total Value: %{value}<extra></extra>'
          
        ),
        
        
        link = list(
          source = links$source,
          target = links$target,
          value = links$value
        ))
    
      validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the 'Year',  'Price type', or 'Region' selection in the sidebar."))
      
      return(fig)
    }
    
# VAEX Dash----
    ## Line Plot ----
    m6_VAEX_lineplot_data <- function(df, geo){
      df |>
        filter(GEO == geo,
               Industry == "Total industries",
               Value.added.exports.variable == "Value added exports" )
    }
    
    m6_VAEX_render_lineplot <- function(df, input){
      df1 <- m6_VAEX_lineplot_data(df, input$m6_VAEX_lineplot_geo)
      p1 <- df1 |> 
        plot_ly(x = ~Year, y = ~VA_EXP*1000, type = 'scatter', mode = 'lines') |>
        layout(xaxis = list(
                 title = "", 
                 rangeslider = list(
                   visible = T,
                   thickness = 0.03,  
                   bgcolor = "darkgrey"  
                 )
               ),
               yaxis = list(title = paste ("$ ")))
      validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
      
      p1 <- ggplotly(p1)
      return(p1)
    }
    
    ## Bar Plot ----
    m6_VAEX_bar_data <- function(df, year, industry){
      df |> 
        filter (Year == year,
                Industry == industry,
                Value.added.exports.variable == "Value added exports")|>
        mutate (EXP_GDP = 100 * VA_EXP / (GDP*1000))
    }
    
    m6_VAEX_render_barplot <- function(df, input){
      df2 <- m6_VAEX_bar_data(df, input$m6_VAEX_barplot_year, input$m6_VAEX_barplot_industry)
      df2$GEO <- reorder(df2$GEO, df2$EXP_GDP)
      df2$formatted_VALUE <- sprintf("%.2f%%", df2$EXP_GDP)
      df2$adjusted_VALUE <- df2$EXP_GDP + max(df2$EXP_GDP) / 10
      p2 <- df2 |>
        plot_ly(x = ~EXP_GDP, y=~GEO, color=~GEO, type = 'bar',
                showlegend = FALSE)  |>
        add_text(x = ~adjusted_VALUE,text = ~formatted_VALUE, textposition = 'outside') 
      
      validate(need(nrow(df2) > 0, "The data for this year is inadequate. To obtain a proper visualization, please modify the year selection in the sidebar."))
      return(p2)
    }
    
    ## Pie Chart ----
    
    m6_VAEX_pie_data <- function(df, geo, year){
      df |>
        filter(Industry != "Total industries",
               GEO == geo,
               Year == year,
               Value.added.exports.variable == "Value added in exports, within-province" )
    }
    
    m6_VAEX_render_pie <- function(df, input){
      df1 <- m6_VAEX_pie_data(df, input$m6_VAEX_pie_geo, input$m6_VAEX_pie_year)
      sorted_data <- df1 |>
        arrange(desc(VA_EXP))
      
      # Create a pie chart
      fig <- plot_ly(sorted_data, labels = ~Industry, values = ~VA_EXP, type = 'pie', textposition = 'inside')
      fig <- fig |> layout(showlegend = FALSE)
      
      return(fig)
    }
    
# Non residential Investment Dash----
    ## line plot ----
    m6_nRinv_lineplot_data <- function(df, geo, item, prices){
      df |>
        filter(GEO == geo,
               Estimates == item,
               Prices == prices)
    }
    
    m6_nRinv_render_lineplot <- function(df, input){
      df1 <- m6_nRinv_lineplot_data(df, input$m6_nRinv_lineplot_geo, input$m6_nRinv_lineplot_item, input$m6_nRinv_lineplot_prices)
      p1 <- df1 |> 
        plot_ly(x = ~Year, y = ~VALUE, type = 'scatter', mode = 'lines') |>
        layout(xaxis = list(
                 title = "", 
                 rangeslider = list(
                   visible = T,
                   thickness = 0.02,  
                   bgcolor = "darkgrey"  
                 )
               ),
               yaxis = list(title = paste (input$m6_nRinv_lineplot_prices)))
      validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
      
      p1 <- ggplotly(p1)
      return(p1)
    }
    
    ## lines plot data----
    m6_nRinv_lines_data <- function(df, geo, prices){
      df |>
        filter(GEO == geo,
               Prices == prices,
               Estimates %in% c(
                 "Business gross fixed capital formation",
                 "General governments final consumption expenditure",
                 "Non-residential structures, machinery and equipment",
                 "Residential structures"
               ))
    }
    
    m6_nRinv_render_lines <- function(df, input){
      dflines <- m6_nRinv_lines_data(df, input$m6_nRinv_lines_geo, input$m6_nRinv_lines_prices)
      plines <- dflines |>
        plot_ly(x = ~Year, y = ~VALUE, color = ~Estimates , type = 'scatter', mode = 'lines')|>
        layout(title = paste("Non-residential Investment Breakdown in ", input$m6_nRinv_lines_geo),
               font = list(family = 'Arial', size = 10),
               yaxis = list(title = ""),
               xaxis = list(title = ""),
               legend = list(y = -0.3, x=0))
      
      validate(need(nrow(dflines) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
      
      plines <- ggplotly(plines)
      return(plines)
    }
    
    ## Bar plot----
    m6_nRinv_barplot_data <- function(df, year){
      df |> 
        filter (Year == year,
                GEO %in% c("British Columbia", 
                           "Ontario", 
                           "Quebec", 
                           "Alberta", 
                           "Canada"),
                Estimates %in% c("Intellectual property products",
                                 "Non-residential structures",
                                 "Machinery and equipment"))
    }
    
    m6_nRinv_render_barplot <- function(df, input){
      
      df2 <- m6_nRinv_barplot_data(df, input$m6_nRinv_barplot_year)
      p2 <- df2 |> 
        plot_ly(x = ~VALUE,y=~GEO, color=~Estimates, type = 'bar', 
                orientation = 'h', stackgroup = 'group') |>
        layout(title = paste("Non-residential Investment Breakdown in ", input$m6_nRinv_barplot_year),
               font = list(family = 'Arial', size = 10),
               yaxis = list(title = ""),
               xaxis = list(title = ""),
               bargap = 0.2,
               barmode = "stack",
               barnorm = "percent",
               legend = list(y = -0.3, x=0),
               autosize = TRUE)
      
      validate(need(nrow(df2) > 0, "The data for this year is inadequate. To obtain a proper visualization, please modify the year selection in the sidebar."))
      return(p2)
    }
    
# Labour Productivity Dash----
    ## line plot ----
    m6_lp_lineplot_data <- function(df, geo, industry, labourtype){
      df |>
        filter(GEO == geo,
               Industry == industry,
               Labour.productivity.and.related.measures == labourtype)
    }
    
    m6_lp_render_lineplot <- function(df, input){
      df1 <- m6_lp_lineplot_data(df, input$m6_lp_lineplot_geo, input$m6_lp_lineplot_industry, input$m6_lp_lineplot_labourtype)
      unit1 <- df1 |> pull(UOM) |> unique()
      p1 <- df1 |> 
        plot_ly(x = ~Year, y = ~VALUE, type = 'scatter', mode = 'lines') |>
        layout(xaxis = list(
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
    }
    ## lines plot ----
    m6_lp_lines_data <- function(df, geo, labourtype ){
      df |>
        filter(
          GEO == geo,
          Labour.productivity.and.related.measures == labourtype,
          Industry %in% c("Business sector industries",
                          "Energy sector",
                          "Information and communication sector",
                          "Finance and insurance, and holding companies [BS5B]",
                          "Industrial production",
                          "Non-business sector industries")
        )
    }
    
    m6_lp_render_lines <- function(df, input){
      df2 <- m6_lp_lines_data(df, input$m6_lp_lines_geo, input$m6_lp_lines_labourtype)
      p <- df2 |>
        plot_ly(x = ~Year, y =~Y1_growth, color = ~Industry, type = 'scatter', mode = 'lines') |>
        layout(legend = list(orientation = 'h', x = 0.5, xanchor = 'center', y = -0.3, yanchor = 'top'))
      p
    }
    
    ## Treemap ----
    m6_lp_treemap_data <- function(df, geo, year){
      df |>
        filter(GEO == geo,
               Year == year,
               Labour.productivity.and.related.measures == "Total number of jobs",
               parent != "NONE") |>
        group_by(parent) |>
        mutate(total_value = sum(VALUE))|>
        ungroup()|>
        mutate(per_val = (VALUE / total_value) * parent_val)
    }
    
    m6_lp_render_treemap <- function(df, input){
      df2 <- m6_lp_treemap_data(df, input$m6_lp_treemap_geo, input$m6_lp_treemap_year)
      p <- df2 |>
        plot_ly(
          type = 'treemap',
          branchvalues = "total",
          labels = ~Industry,
          parents = ~parent,
          values = ~per_val)
      validate(need(nrow(df2) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
      p}
    
    ## table----
    m6_lp_table_data <- function(df, year, labourtype, industry){
      df |>
        filter(
          Year == year,
          Labour.productivity.and.related.measures == labourtype,
          Industry == industry,
          GEO %in% c("British Columbia", "Ontario", "Quebec", "Alberta", "Canada"))|>
        select (GEO, Y1_growth, Y3_growht, Y5_growth) |>
        mutate(GEO = factor(GEO, levels = c("British Columbia", "Ontario", "Quebec", "Alberta", "Canada")),
               Y1_growth = paste0(round(Y1_growth,1),"%"),
               Y3_growht = paste0(round(Y3_growht,1),"%"),
               Y5_growth = paste0(round(Y5_growth,1),"%"))|>
        arrange(GEO)|>
        rename(Region = GEO) |>
        rename_with(~paste0("one-year growth <br>(", as.numeric(as.character(year))-1, "-", as.numeric(as.character(year)) ,")") , Y1_growth)|>
        rename_with(~paste0("3-year growth <br>(", as.numeric(as.character(year))-3, "-", as.numeric(as.character(year)) ,")") , Y3_growht)|>
        rename_with(~paste0("5-year growth <br>(", as.numeric(as.character(year))-5, "-", as.numeric(as.character(year)) ,")") , Y5_growth)
    }
    
    m6_lp_render_table <- function(df, input){
      data <- m6_lp_table_data(df, input$m6_lp_table_year, input$m6_lp_table_labourtype, input$m6_lp_table_industry)
      DT::datatable(data, options = list(dom = 't'), escape = FALSE, rownames = FALSE, 
                    caption = htmltools::tags$caption("",
                                                      style = "font-family: Arial; font-size: 12px;"))
    }
    
    ## map ----
    m6_lp_map_data <- function(df, year, labourtype, industry){
      df |> 
        filter(
          GEO != "Canada",
          Year == year,
          Labour.productivity.and.related.measures == labourtype,
          Industry == industry
        ) |>
        select(
          GEO, Labour.productivity.and.related.measures, Industry, VALUE 
        )}
    
    m6_lp_render_map <- function(df, canada_map, input){
      df_map <- m6_lp_map_data(df, input$m6_lp_map_year, input$m6_lp_map_labourtype, input$m6_lp_map_industry)
      merged_df <- merge(canada_map, df_map, by.x="prov_name_en", by.y="GEO", all.x = TRUE)
      canada_map$VALUE <- merged_df$VALUE
      # Create a color palette
      pal <- colorNumeric(palette = "viridis", domain = canada_map$VALUE)
      
      p2 <- leaflet(data = canada_map) %>%
        addProviderTiles(providers$CartoDB.Positron) %>%
        addPolygons(fillColor = ~pal(canada_map$VALUE),
                    fillOpacity = 0.8,
                    color = "#BDBDC3",
                    weight = 1,
                    popup = ~paste0("<b>", prov_name_en, "</b><br>Value: ", round(canada_map$VALUE, 2))) |>
        leaflet::addLegend(pal = pal,
                           values = canada_map$VALUE,
                           title = "Value",
                           position = "bottomleft")
      
      validate(need(nrow(df_map) > 0, "The data for this year is inadequate. To obtain a proper visualization, please modify the year selection in the sidebar."))
      p2
    }
    
# Export Dash----
    ## line plot ----
    m6_exp_lineplot_data <- function(df, geo, exptype){
      df |>
        filter(GEO == geo,
               EXP_type == exptype)
    }
    
    m6_exp_render_lineplot <- function(df, input){
      df1 <- m6_exp_lineplot_data(df, input$m6_exp_lineplot_geo, input$m6_exp_lineplot_exptype)
      p1 <- df1 |> 
        plot_ly(x = ~Year, y = ~VALUE, type = 'scatter', mode = 'lines') |>
        layout(xaxis = list(
          title = "", 
          rangeslider = list(
            visible = T,
            thickness = 0.03,  
            bgcolor = "darkgrey"  
          )
        ))
      validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
      
      p1 
    }
    
    ## Heat Map----
    m6_exp_heatmap_data <- function(df){
      return(df)
    }
    
    m6_exp_render_heatmap <- function(df, input){
      df1 <- m6_exp_heatmap_data(df)
      df1$Value <- as.numeric(sub("%", "", df1$Value))
      
      p1 <- plot_ly(
        data = df1,
        x = ~GEO,
        y = ~Sector,
        z = ~Value,
        type = "heatmap",
        colorscale = "Plasma" )
      p1
    }
    ##Stacked Bar Chart ----
    m6_exp_stackbar_data <- function(df, year){
      df |>
        filter(Year == year)
    }
    
    m6_exp_render_stackbar <- function(df, input){
      df1 <- m6_exp_stackbar_data(df, input$m6_exp_stackbar_year)
    
      p1 <- plot_ly(data = df1, 
                    y = ~GEO, 
                    x = ~Value,
                    color = ~Type,
                    type='bar',
                    orientation = 'h') |> 
        layout(barmode = 'stack',
               legend = list(x = 0, y = -0.1, orientation = 'h'))
      p1
    }
    ##Bubble  chart----
    m6_exp_bubble_data <- function(df){
      df 
    }
    
    m6_exp_render_bubble <- function(df, input){
      data <- m6_exp_bubble_data(df)
      data$GDP <- as.numeric(data$GDP)
      data$growth_change <- as.numeric(data$growth_change)
      data$growth <- as.numeric(data$growth)
      data$exports <- as.numeric(data$exports)
      
      p1 <- plot_ly(
        data,
        x = ~exports,
        y = ~growth,
        size = ~GDP,
        # color = ~growth_change,
        type = "scatter",
        mode = "markers",
        marker = list(sizemode = "diameter")) %>%
        layout(
          title = "Bubble Chart with Plotly",
          xaxis = list(title = "Level"),
          yaxis = list(title = "Growth"),
          showlegend = TRUE
        )
      
      p1
    }