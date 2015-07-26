# ui.R

library(shiny)
library(shinythemes)


shinyUI(fluidPage(
  theme = shinytheme("united"),
  
  navbarPage(
    "My DDD Project",
    
    tabPanel(
      "Exponential distribution & CLT",
      titlePanel("Exponential Distribution and Central Limit Theorem"),
      br(),
      
      # sidebarLayout for Panel 1
      sidebarLayout(

        # Overall settings
        sidebarPanel(
          h4('Overall Settings'),
          hr(),
          
          sliderInput(
            "lambda",
            "Lambda value:",
            min = 0.05,
            max = 1,
            step = 0.05,
            value = 0.2
          ),
          hr(),
          
          sliderInput(
            "n",
            "Number of exponentials per simulation:",
            min = 10,
            max = 50,
            step = 5,
            value = 25
          ),
          hr(),
          
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
            "Help", 
            br()
          ),
          
          tabPanel(
            "Sample Simulation",
            br(),
            p("Here you can see the distribution of a given simulation"),
            
            sliderInput(
              "i",
              "Simulation:",
              min = 1,
              max = 500,
              step = 1,
              value = 1
            ),
            
            plotOutput("plotDistSample"),
            br(),
            
            p("Mean: Theoritical vs Computed"),
            verbatimTextOutput("textMeanSample"),
            
            p("SDev: Theoritical vs Computed"),
            verbatimTextOutput("textSDevSample")
          ),
          
          tabPanel(
            "Distribution",
            br(),
            plotOutput("plotDistSimMean"),
            verbatimTextOutput("TODO")
          ),
          
          tabPanel(
            "Q-Q plot",
            br(),
            plotOutput("plotQQSimMean"),
            br(),
            verbatimTextOutput("stats")
          )
          
          
        ))
        
      )
    ),

        
    tabPanel(
      "About this ShinyApp",
      titlePanel("About"),
      br()
    )
  ),

  # Overall Basic footer
  hr(),
  fluidRow(column(10, offset = 1, h5("by CChevalier, July 2015")))
  
))
