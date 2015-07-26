# ui.R

library(shiny)
library(shinythemes)


shinyUI(fluidPage(
  theme = shinytheme("united"),
  
  navbarPage(
    "DS9 Project",
    
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
            "Rate of the exponential distribution, lambda:",
            min = 0.05,
            max = 1,
            step = 0.05,
            value = 0.2
          ),
          hr(),
          
          sliderInput(
            "n",
            "Number of exponentials per simulation, n:",
            min = 10,
            max = 50,
            step = 5,
            value = 25
          ),
          hr(),
          
          sliderInput(
            "nosim",
            "Number of simulations, nosim:",
            min = 100,
            max = 1000,
            step = 50,
            value = 500
          )
        ),
        

        # mainPanel for tabPanel 1
        mainPanel(tabsetPanel(

          #
          # Help tabPanel
          #
          tabPanel(
            "Help", 
            br(),
            p("This ShinyApp allows the user to experiment with the exponential distribution and to assess the validity of the Central Limit Theorem (CLT) as also done in the first project of Course DS6 - Statistical Inference"),
            p("This app generates first a 1000 simulations of 50 exponentials each for a user specified rate of the exponential distribution (the lambda parameter)."),
            p("From this overall pool of simulations the user is able to select a subset (n, nosim) of the pre-computed simulations in order to assess the impact of these parameters on the statistical analysis of the mean of each simulation. The app presents the following results in different numbered panels:"),
            tags$ol(
              tags$li("Basic statistical analysis of a given simulation"),
              tags$li("Plot of the mean value of each simulation"),
              tags$li("CLT: Distribution of mean values"),
              tags$li("CLT: Q-Q plot of mean values")
            ),
            br(),
            p("On the left panel (Overall Settings) the user can set 3 main parameters for his experimentation:"),
            tags$ol(
              tags$li("Lambda, the rate of the exponential distribution (range: [0.05, 1] for this app)"),
              tags$li("n, the number of exponentials per simulation"),
              tags$li("nosim, the number of simulations")
              ),
            br(),
            p("Enjoy!")
          ),
          
          
          #
          # Simulation sample
          #
          tabPanel(
            "1. Simulation sample",
            br(),
            p("Please select below the given number of the simulation you want to analyse:"),
            
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
            
            p("Mean: Theoritical (Red line above) vs Computed (Purple line)"),
            verbatimTextOutput("textMeanSample"),
            
            p("SDev: Theoritical vs Computed"),
            verbatimTextOutput("textSDevSample")
          ),
          
          #
          # Mean Values
          #
          tabPanel(
            "2. Mean Values",
            br(),
            p(""),
            plotOutput("plotMeanValues"),
            br(),
            p("Overall Mean: CLT Theory (Red line above) vs Simulated (Purple line)"),
            verbatimTextOutput("meanValue"),
            br(),
            p("Overall Variance: CLT Theory vs Simulated"), 
            verbatimTextOutput("varianceValue"),
            br(),
            p("Summary"),
            verbatimTextOutput("summaryMeanValues")
          ),
          
          
          #
          # CLT: Distribution
          #
          tabPanel(
            "3. CLT: Distribution",
            br(),
            p(""),
            plotOutput("plotDistSimMean"),
            br(),
            p("Summary of normalized mean values"),
            verbatimTextOutput("stats")
          ),
          
          
          #
          # CLT: Q-Q plot
          #
          tabPanel(
            "4. CLT: Q-Q plot",
            br(),
            p(""),
            plotOutput("plotQQSimMean"),
            br()
          )
          
          
        ))
        
      )
    ),

        
    tabPanel(
      "About this ShinyApp",
      titlePanel("About"),
      br(),
      p("This ShinyApp has been developed for the course DS9 - Developing Data Products from John Hopkins University available on coursera.org")
    )
  ),

  # Overall Basic footer
  hr(),
  fluidRow(column(6, offset = 1, h5("Developed by CChevalier, July 2015")))
  
))
