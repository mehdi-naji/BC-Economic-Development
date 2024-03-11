# Loading data----

    ## CEG----
    load_m5_CEG1 <- function() {
      url <- "https://github.com/mehdi-naji/StrongerBC-Project/raw/main/Data/Clean_Energy_Generated_1.csv"
      df <- read.csv(url, header = TRUE)
      df <- na.omit(df)
      return(df)
    }

# CEG Dash----
    ## Line plot----
    m5_CEG_lineplot_data <- function(df, geo, class, type) {
      df |>
        filter(GEO == geo,
               Class.of.electricity.producer == class,
               Type.of.electricity.generation == type)
    }
    
    m5_CEG_render_lineplot <- function(df, input){
      df1 <- m5_CEG_lineplot_data(df, input$m5_CEG_lineplot_geo, input$m5_CEG_lineplot_class, input$m5_CEG_lineplot_type)
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
        yaxis = list(title = paste ("Megawatt hours")))
      validate(need(nrow(df1) > 0, "The data for this set of inputs is inadequate. To obtain a proper visualization, please adjust the inputs in the sidebar."))
      
      p1 <- ggplotly(p1)
      return(p1)
    }
    
    ##Stacked Bar Chart ----
    m5_CEG_stackbar_data <- function(df, geo, class){
      df |>
        filter(GEO == geo,
               Class.of.electricity.producer == class,
               Type.of.electricity.generation %in% c("Solar", "Wind power turbine", "Tidal power turbine", "Hydraulic turbine")
               )
    }
    
    m5_CEG_render_stackbar <- function(df, input){
      df1 <- m5_CEG_stackbar_data(df, input$m5_CEG_stackbar_geo, input$m5_CEG_stackbar_class) |>
        filter(Year >= 2015)

      p1 <- plot_ly(data = df1, 
                    y = ~VALUE, 
                    x = ~Year,
                    color = ~Type.of.electricity.generation,
                    type='bar') |> 
        layout(barmode = 'stack',
               legend = list(x = 0, y = -0.1, orientation = 'h'),
               xaxis = list(title = "",
                            tickmode = 'array',
                            tickvals = ~Year),
               yaxis = list(title = "Megawatt hours"))
      
      p1
    }
