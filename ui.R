# ui.R

library(shiny)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  theme = shinytheme("united"),
  
  navbarPage(
    "My Application",
    
    tabPanel("Exp dist & CLT",
      
      # Application title
      titlePanel("Exponential Distribution and Central Limit Theorem"),
      
      # sidebarLayout
      sidebarLayout(
        # Settings
        sidebarPanel(
          h4('Settings'),
          
          # Lambda
          sliderInput(
            "lambda",
            "Lambda value:",
            min = 0.1,
            max = 1,
            step = 0.1,
            value = 0.2
          ),
          
          sliderInput(
            "bins",
            "Number of exponentials per simulation:",
            min = 10,
            max = 50,
            step = 5,
            value = 25
          ),
          sliderInput(
            "nosim",
            "Number of simulations:",
            min = 100,
            max = 1000,
            step = 50,
            value = 500
          )
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
          tabsetPanel(
            tabPanel("Sample"),
            tabPanel("Distribution", plotOutput("distPlot")),
            tabPanel("Misc.")
          )
        )
      )
    ),
    
    tabPanel("mtcars & lm",
             
             # Application title
             titlePanel("Blabla")),
    tabPanel("About & Help")
  ),

  hr(),
  
  fluidRow(column(6, offset = 1,
                  h5("CChevalier")))
  
))
