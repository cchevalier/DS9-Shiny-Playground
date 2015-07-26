# server.R

#
# External code
#

# External libraries
library(shiny)
library(ggplot2)


# CLT normalize function
clt_func <- function(x, n, mu, sigma) (mean(x) - mu) / (sigma / sqrt(n))


#
# Server side code
#
shinyServer(function(input, output, clientData, session) {
  
  # Update Simulation number Slider based on nosim  
  observe({
    i <- input$i
    imax <- input$nosim
    if (i > imax) i <- imax
    updateSliderInput(session, "i", 
                      value = i,
                      max = input$nosim)
  })
  
  # Overall pool of simulations (1000 sims of 50 exp using user lambda)
  simus_pool <- reactive({
    set.seed(8765432)
    matrix(rexp(1000 * 50, input$lambda), ncol = 50, byrow = TRUE)
  })
  
  # Theoritical values for mean and sdev of lambda exp distribution
  exp_mean_th <- reactive(1/input$lambda)
  exp_sdev_th <- reactive(1/input$lambda)

  # User defined subset of simulations (nosim, n)  
  simus <- reactive({
    simus_pool()[1:input$nosim, 1:input$n]
  })
  
  # Vector of mean value
  simus_mean <- reactive({
    apply(simus(), 1, mean)
  })

  # Vector of mean value normalized
  simus_mean_normalized <- reactive({
    apply(simus(), 1, clt_func, input$n, exp_mean_th(), exp_sdev_th())
  })
  
  
  simus_selected <- reactive({ 
    simus()[input$i,]
  })

  
  
  #
  # Sample Simulation Panel
  #
  output$plotDistSample <- renderPlot({
    hist(
      simus_selected(), freq = TRUE, col = "blue",
      xlab = "Exp. value",
      main =  paste("Histogram of sample simulation no: ",
                    input$i,
                    " - (",
                    input$n,
                    " exponentials)",
                    sep = ''))
    abline(v = mean(simus_selected()), col = "purple", lwd = 2)
    abline(v = exp_mean_th(), col = "red", lwd = 2)
  })
  
  output$textMeanSample <- renderPrint({
    c(exp_mean_th(), mean(simus_selected()))
  })
  
  output$textSDevSample <- renderPrint({
    c(exp_sdev_th(), sd(simus_selected()))
  })
  
  
  
  #
  # Mean Values Panel
  #
  output$plotMeanValues <- renderPlot({
    plot(simus_mean(), 
         main = "Mean value of each simulation",
         xlab = "Index of the simulation",
         ylab = "Mean Value")
    abline(h = mean(simus_mean()), col = "purple", lwd = 2)
    abline(h = exp_mean_th(), col = "red", lwd = 2)
  })
  
  output$meanValue <- renderPrint({
    c(exp_mean_th(), mean(simus_mean()))
  })
  
  output$varianceValue <- renderPrint({
    c(exp_sdev_th()*exp_sdev_th()/input$n, var(simus_mean()))
  })
  output$summaryMeanValues <- renderPrint(
    summary(simus_mean())
  )
  
  
  
  #
  # Distribution Panel
  #
  output$plotDistSimMean <- renderPlot({
    
    sim_mean_norm <- simus_mean_normalized()
    df_sim_mean_norm <- data.frame(sim_mean_norm)
    h2 <- ggplot(df_sim_mean_norm, 
                 aes(x = sim_mean_norm)) 
    h2 <- h2 + geom_histogram(alpha = .20, 
                              binwidth=.3, 
                              colour = "black", 
                              aes(y = ..density..))
    h2 <- h2 + stat_function(fun = dnorm, 
                             size = 1, 
                             colour = "red")
    h2 <- h2 + labs(title = "Histogram of normalized mean values",
                   x = "Normalized Mean Values")
    h2
    })
  
  output$stats <- renderPrint({
    summary(simus_mean_normalized())
  })
  
  
  #
  # Q-Q plot Panel
  #
  output$plotQQSimMean <- renderPlot({
    qqnorm(simus_mean_normalized())
    qqline(simus_mean_normalized(), col = "red", lwd = 2)
  })

})
