# ui.R

library(shiny)
library(shinythemes)


shinyUI(fluidPage(
  theme = shinytheme("united"),
  
  navbarPage(
    "My DDD Project",
    
    # tabPanel 1: Exp dist
    tabPanel(
      "Exp dist & CLT",
      titlePanel("Exponential Distribution and Central Limit Theorem"),
      
      # sidebarLayout for Panel 1
      sidebarLayout(
        # Overall settings
        sidebarPanel(
          h4('Overall Settings'),
          
          hr(),
          
          # Lambda
          sliderInput(
            "lambda",
            "Lambda value:",
            min = 0.05,
            max = 1,
            step = 0.05,
            value = 0.2
          ),
          
          hr(),
          
          # bins
          sliderInput(
            "n",
            "Number of exponentials per simulation:",
            min = 10,
            max = 50,
            step = 5,
            value = 25
          ),
          
          
          hr(),
          
          # nosim
          sliderInput(
            "nosim",
            "Number of simulations:",
            min = 100,
            max = 1000,
            step = 50,
            value = 500
          )
        ),
        

        # mainPanel for tabPanel 1
        mainPanel(tabsetPanel(
          
          tabPanel(
            "Sample Simulation",
            br(),
            p("Here you can see the distribution of a given simulation"),
            
#             sliderInput(
#               "i",
#               "Simulation:",
#               min = 0,
#               max = 499,
#               step = 1,
#               value = 1
#             ),
            
            plotOutput("plotSample")
          ),
          
          tabPanel(
            "Distribution", 
            plotOutput("plotDistSimMean")
          ),
          tabPanel(
            "Misc.", 
            br(),
            verbatimTextOutput("stats")
          )
        )
        )
        
      )
    ),
    
#     tabPanel(
#       "mtcars & lm",
#       titlePanel("mtcars")
#     ),
    
    tabPanel(
      "Help",
      titlePanel("Help"),
      br()
    ),
    
    tabPanel("About",
             titlePanel("About"),
             br()
    )
  ),

  # Overall Basic footer
  hr(),
  fluidRow(column(6, offset = 1, h5("CChevalier, July 2015")))
  
))
