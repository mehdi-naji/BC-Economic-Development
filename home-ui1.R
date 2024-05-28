ui_home <- function(){
  ## Body ----
  ##CAEDF8
  ##D9F2D0
  style1 <- "background-color:white; height: 350px; padding: 4px; border-radius: 10px; border: 5px solid #ecf0f5;font-size: 12px;"
  style2 <- "background-color:#337AB7; color:white;"
  style3 <- "background-color:white; height: 350px; padding: 4px; border-radius: 10px; border: 5px solid #ecf0f5;font-size: 12px;"
  
tabItem(tabName = "home",
        fluidRow(
          column(width = 12,
                 style = "background-color:#156082;color:white; border-radius: 10px; padding: 0px; text-align: center;height:60px;",
                 h3(strong("Inclusive Growth"))
          )
        ),
        fluidRow(
          column(width = 4,
                 style = style1, 
                 h4(style = "text-align: center;",
                    strong("MISSION 1:"), br(), "Supporting people and families", br()),
                 div(
                   style = "display: flex; 
                            justify-content: center; 
                            align-items: center;",
                   actionButton("button1", 
                                label = "", 
                   style = "width: 250px; 
                            height: 250px; 
                            background-image: url('https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/new_homepage/mission1.jpg'); 
                            background-size: cover; 
                            border: none;"
                    )
                  )
            ),
            column(width = 4, 
                 style = style1,
                 h4(style = "text-align: center;",
                    strong("MISSION 2:"), br(), "Building resilient communities", br()),
                 div(
                   style = "display: flex; 
                            justify-content: center; 
                            align-items: center;",
                   actionButton("button2", 
                                label = "", 
                                style = "width: 250px; 
                            height: 250px; 
                            background-image: url('https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/new_homepage/mission2.jpg'); 
                            background-size: cover; 
                            border: none;"
                   )
                  )
            ),
            column(width = 4,
                 style = style1,
                 h4(style = "text-align: center;",
                    strong("MISSION 3:"), br(), "Advancing true, lasting and meaningful reconciliation with Indigenous Peoples"),
                 div(
                   style = "display: flex; 
                            justify-content: center; 
                            align-items: center;",
                   actionButton("button3", 
                                label = "", 
                                style = "width: 250px; 
                            height: 250px; 
                            background-image: url('https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/new_homepage/mission3.jpg'); 
                            background-size: cover; 
                            border: none;"
                   )
                )
              )),
        fluidRow(
          column(width = 12,
                 style = "background-color:#275317; color:white; border-radius: 10px; padding: 0px; text-align: center;height:60px;",
                 h3(strong("Clean Growth"))
          ),
        fluidRow(
          column(width =4,
                 style=style3,
                 h4(style = "text-align: center;",strong("MISSION 4:"), br(), "Meeting B.C.’s climate commitments"),
                 div(
                   style = "display: flex; 
                            justify-content: center; 
                            align-items: center;",
                   actionButton("button4", 
                                label = "", 
                                style = "width: 250px; 
                            height: 250px; 
                            background-image: url('https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/new_homepage/mission4.jpg'); 
                            background-size: cover; 
                            border: none;"            
                  )
                  )
           ),
           column (width=4,
                  style=style3,
                  h4(style = "text-align: center;",strong("MISSION 5:"), br(), "Leading on environmental and social responsibility"),
                  div(
                    style = "display: flex; 
                            justify-content: center; 
                            align-items: center;",
                    actionButton("button5", 
                                 label = "", 
                                 style = "width: 250px; 
                            height: 250px; 
                            background-image: url('https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/new_homepage/mission5.jpg'); 
                            background-size: cover; 
                            border: none;"                 
                    )
                  )
            ),
            column (width=4,
                  style=style3,
                  h4(style = "text-align: center;",
                     strong("MISSION 6:"), br(), "Fostering Innovation across Economy"),
                  div(
                    style = "display: flex; 
                            justify-content: center; 
                            align-items: center;",
                    actionButton("button6", 
                                 label = "", 
                                 style = "width: 250px; 
                            height: 250px; 
                            background-image: url('https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/new_homepage/mission6.jpg'); 
                            background-size: cover; 
                            border: none;"
                    )
                  )
              )
        )))}
