# server.R

library(shiny)
library(ggplot2)


set.seed(8765432)

# CLT normalize function
clt_func <- function(x, n, mu, sigma) (mean(x) - mu) / (sigma / sqrt(n))



# 
shinyServer(function(input, output) {
  
  # pool of simus
#   pool <- reactiveValues()
#   
#   pool$simus <- matrix(rexp(input$nosim * input$n, input$lambda), ncol = input$n, byrow = TRUE)
#   
#   
#   sim_mean <- reactive({
#     apply(isolate(pool$simus), 1, mean)
#   })
#   

  output$plotSample <- renderPlot({
    demo_exp <- rexp(input$n, input$lambda)
    hist(demo_exp, freq = FALSE, col = "blue", 
         xlim = c(0, 20),
         xlab = "Exp. value", 
         main =  "Histogram of the sample distribution of 40 exponentials")    
  })
  
  output$plotDistSimMean <- renderPlot({
    simus <- matrix(rexp(input$nosim * input$n, input$lambda), ncol = input$n, byrow = TRUE)
    sim_mean <- apply(simus, 1, mean)
    hist(sim_mean)
  })
  
  output$stats <- renderPrint({
    summary(rexp(input$n, input$lambda))
  })
  
  
  
})
