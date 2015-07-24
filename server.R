# server.R

library(shiny)
library(ggplot2)


set.seed(8765432)

# CLT normalize function
clt_func <- function(x, n, mu, sigma) (mean(x) - mu) / (sigma / sqrt(n))




shinyServer(function(input, output) {
  
  #
  simus_pool <- reactive({
    matrix(rexp(1000 * 50, input$lambda), ncol = 50, byrow = TRUE)
  })
  
  exp_mean_th <- reactive(1/input$lambda)
  exp_sdev_th <- reactive(1/input$lambda)
  
  simus <- reactive({
    simus_pool()[1:input$nosim, 1:input$n]
  })
  
  simus_mean <- reactive({
    apply(simus(), 1, mean)
  })

  simus_mean_norm <- reactive({
    apply(simus(), 1, clt_func, input$n, exp_mean_th(), exp_sdev_th())
  })
  
  
  demo_exp <- reactive({
    simus()[input$i,]
    })
  
  
  
  #
  # Sample Simulation Panel
  #
  output$plotDistSample <- renderPlot({
    hist(
      demo_exp(), freq = TRUE, col = "blue",
      xlab = "Exp. value",
      main =  paste("Histogram of sample simulation no: ",
                    input$i,
                    " - (",
                    input$n,
                    " exponentials)",
                    sep = '')
    )
  })
  
  output$textMeanSample <- renderPrint({
    c(exp_mean_th(), mean(demo_exp()))
  })
  
  output$textSDevSample <- renderPrint({
    c(exp_sdev_th(), sd(demo_exp()))
  })
  
  
  
  #
  # Distribution Panel
  #
  output$plotDistSimMean <- renderPlot({
    sim_mean_norm <- simus_mean_norm()
    df_sim_mean_norm <- data.frame(sim_mean_norm)
    h2 <- ggplot(df_sim_mean_norm, aes(x = sim_mean_norm)) 
    h2 <- h2 + geom_histogram(alpha = .20, binwidth=.3, colour = "black", aes(y = ..density..))
    h2 <- h2 + stat_function(fun = dnorm, size = 2, colour = "red")
    h2  })
  
  
  #
  # Q-Q plot Panel
  #
  output$plotQQSimMean <- renderPlot({
    qqnorm(simus_mean_norm())
    qqline(simus_mean_norm(), col = "red", lwd = 2)
  })
  
  output$stats <- renderPrint({
    summary(rexp(input$n, input$lambda))
  })
  
  
  
})
