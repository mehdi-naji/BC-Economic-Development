# Loading data----
load_df1 <- function() {
  url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Research_and_Development_1.csv"
  df <- read.csv(url, header = TRUE)
  df <- na.omit(df)
  return(df)
}

load_df2 <- function() {
  url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Research_and_Development_3.csv"
  df <- read.csv(url, header = TRUE)
  df <- na.omit(df)
  return(df)
}

# Line plot----

lineplot_data <- function(df, geo, funder, performer, science_type, prices) {
  df |>
    filter(GEO == geo,
           Funder == funder,
           Performer == performer,
           Science.type == science_type,
           Prices == prices)
}

render_lineplot <- function(df, input){
  df1 <- lineplot_data(df, input$geo, input$funder, input$performer, input$science_type, input$prices)
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

# Bar plot----

barplot_data <- function(df, year){
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

render_barplot <- function(df, input){
  df2 <- barplot_data(df, input$year)
  df2$formatted_VALUE <- sprintf("%.1f%%", df2$VALUE)
  df2$adjusted_VALUE <- df2$VALUE + 0.2
  p2 <- df2 |> 
    plot_ly(x = ~VALUE,y=~GEO, color=~GEO, type = 'bar',
            colors = ~color, showlegend = FALSE)  |>
    add_text(x = ~adjusted_VALUE,text = ~formatted_VALUE, textposition = 'outside')
  validate(need(nrow(df2) > 0, "The data for this year is inadequate. To obtain a proper visualization, please modify the year selection in the sidebar."))
  return(p2)
}

# Table ----

table_data <- function(df, year , funder, performer, science_type, prices){
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



render_table <- function(df, input){
  data <- table_data(df, input$year, input$funder, input$performer, input$science_type, input$prices )
  DT::datatable(data, options = list(dom = 't'), escape = FALSE, rownames = FALSE)
}

#Sankey Plot----
sankey_data <- function(df, year , geo, science_type){
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

render_sankey <- function(df, input){
  df1 <- sankey_data(df, input$year, input$geo, input$science_type)
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
