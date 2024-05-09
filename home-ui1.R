ui_home <- function(){
  ## Body ----
  style1 <- "background-color:#CAEDF8; height: 500px; padding: 10px; border-radius: 10px; border: 5px solid #ecf0f5;font-size: 16px;"

  style2 <- "background-color:#337AB7; color:white;"
  style3 <- "background-color:#D9F2D0; height: 500px; padding: 10px; border-radius: 10px; border: 5px solid #ecf0f5;font-size: 16px;"
  
tabItem(tabName = "home",
        fluidRow(
          column(width = 12,
                 style = "background-color:#156082;color:white; border-radius: 10px; padding: 2px; text-align: center;",
                 h2(strong("Inclusive Growth"))
          )
        ),
        fluidRow(
          column(width = 4,
                 style = style1, 
                 h3(strong("MISSION 1:"), br(), "Supporting people and families", br()),
                 div(
                   img(src = 'https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/new_homepage/mission1.jpg', 
                       height = 400, 
                       width = 400,
                       style = "display: block; margin-left: auto; margin-right: auto;"),  
              # p (
              #      HTML("
              #                 <li>Investing in people and families to make life more affordable </li>
              #                 <li>Delivering the services - like health care and child care - you can count on  </li>
              #                 <li>Expanding opportunities for education and training  </li>
              #                   ")                             ),
                 ),
                 div(
                   actionButton("button1", "Explore further", icon = icon("line-chart"), style = style2),
                   style = "position: absolute; bottom: 5px; left: 50px;"  
                 )
          ),
          column(width = 4, 
                 style = style1,
                 h3(strong("MISSION 2:"), br(), "Building resilient communities", br()),
                 div(
                   img(src = 'https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/new_homepage/mission2.jpg', 
                       height = 400, 
                       width = 400,
                       style = "display: block; margin-left: auto; margin-right: auto;"),  
                   # p (
                 #   HTML("
                 #              <li>Helping communities thrive with modern infrastructure resilient to changes in the climate and the economy </li>
                 #              <li>Building affordable housing, new schools and hospitals  </li>
                 #              <li>Making sure every community in B.C. has access to high-speed internet </li>
                 #                ")                           ),
                 ),
                 div(
                   actionButton("button1", "Explore further", icon = icon("line-chart"), style = style2),
                   style = "position: absolute; bottom: 5px; left: 50px;"  
                 )
          ),
          column(width = 4,
                 style = style1,
                 h3(strong("MISSION 3:"), br(), "Advancing true, lasting and meaningful reconciliation with Indigenous Peoples"),
                 div(
                   img(src = 'https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/new_homepage/mission3.jpg', 
                       height = 400, 
                       width = 400,  
                   style = "display: block; margin-left: auto; margin-right: auto;"),
                 # p (
                 #   HTML("
                 #              <li>Working to advance our commitments to reconciliation with Indigenous Peoples</li>
                 #              <li>Partnering with First Nations and Indigenous communities to support new economic initiatives</li>
                 #              <li>Acknowledging, respecting and upholding Indigenous rights, First Nations title and Indigenous control of their land and resources </li>
                 #                ")                           ),
                 ),
                 div(
                   actionButton("button1", "Explore further", icon = icon("line-chart"), style = style2),
                   style = "position: absolute; bottom: 5px; left: 50px;"  
                 )
          )
        ),
        fluidRow(
          column(width = 12,
                 style = "background-color:#275317; color:white; border-radius: 10px; padding: 2px; text-align: center;",
                 h2(strong("Clean Growth"))
          )
        ),
        fluidRow(
          column(width =4,
                 style=style3,
                 h3(strong("MISSION 4:"), br(), "Meeting B.C.’s climate commitments"),
                 div(
                   img(src = 'https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/new_homepage/mission4.jpg', 
                       height = 400, 
                       width = 400,  
                       style = "display: block; margin-left: auto; margin-right: auto;"),                 # p (
                 #   HTML("
                 #              <li>Delivering on B.C.’s commitment to reduce climate pollution and build a cleaner B.C.</li>
                 #              <li>Helping people and business transition to clean energy solutions </li>
                 #              <li>Supporting industries to become low-carbon </li>
                 #                ")                          
                 # ),
                 ),
                 div(
                   actionButton("button1", "Explore further", icon = icon("line-chart"), style = style2),
                   style = "position: absolute; bottom: 5px; left: 50px;"  
                 )
          ),
          column (width=4,
                  style=style3,
                  h3(strong("MISSION 5:"), br(), "Leading on environmental and social responsibility"),
                  div(
                    img(src = 'https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/new_homepage/mission5.jpg', 
                        height = 400, 
                        width = 400,  
                        style = "display: block; margin-left: auto; margin-right: auto;"),                  # p (
                  #   HTML("
                  #             <li>Helping develop, promote, and market environmentally and socially responsible goods and services </li>
                  #             <li>Positioning B.C. to compete and win in a global economy that puts a premium on ESG  </li>
                  #             <li>Investing in the development of low carbon goods and technology </li>
                  #               ")
                  # ),
                  ),
                  div(
                    actionButton("button1", "Explore further", icon = icon("line-chart"), style = style2),
                    style = "position: absolute; bottom: 5px; left: 50px;"  
                  )
          ),
          column (width=4,
                  style=style3,
                  h3(strong("MISSION 6:"), br(), "Fostering Innovation across Economy"),
                  div(
                    img(src = 'https://raw.githubusercontent.com/mehdi-naji/StrongerBC-Project/new_homepage/mission6.jpg', 
                        height = 400, 
                        width = 400,  
                        style = "display: block; margin-left: auto; margin-right: auto;"),                  # p (
                  #   HTML("
                  #             <li>Helping B.C.’s high-tech sector find talent and scale-up</li>
                  #             <li>Creating new manufacturing opportunities in an innovative economy </li>
                  #             <li>Adding value to natural resources </li>
                  #               ")
                  # ),
                  ),
                  div(
                    actionButton("button6", "Explore further", icon = icon("line-chart"), style = style2),
                    style = "position: absolute; bottom: 5px; left: 50px;"  
                  )
          )
        )
)}