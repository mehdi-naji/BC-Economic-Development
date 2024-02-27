chart_list <- c("aaa", "bbb", "ccc")

mission5_ui <- fluidRow(
          column(width = 3, 
                 tags$fieldset(
                   tags$legend(h3("Indicator")),
                   selectInput( ## drop-down list
                     inputId = "indicator",
                     label = NULL,
                     choices = str_replace_all(unique(chart_list), pattern = "<br>", replacement = " "),
                     selected = chart_list[1],
                     selectize = FALSE,
                     size = length(unique(chart_list)),
                     width = "100%")
                 )),
          column(width = 9,
                 tags$fieldset(
                   br(),br(),br(),
                   plotlyOutput(outputId = "charts"),
                   uiOutput(outputId = "caption")
                 ))
        )