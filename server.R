#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(UsingR)
data(galton)

shinyServer(function(input, output){
  
  slope <- reactive({
    if(input$yvar == "Child"){
      model <- lm(child ~ parent, data=galton)
    }
    else if(input$yvar == "Parent"){
      model <- lm(parent ~ child, data=galton)
    }
    
    coef(model)[2]
    
  })
  
  output$plot <- renderPlot({
    if(input$yvar == "Child"){
        y_var <- galton$child
        x_var <- galton$parent
        
        label_y <- "Child's height"
        label_x <- "Parent's height"
    }

    else if(input$yvar == "Parent"){
      y_var <- galton$parent
      x_var <- galton$child
      
      label_y <- "Parent's height"
      label_x <- "Child's height"
    }
    
    if(input$smooth == "With"){
      g <- ggplot(galton, aes(x=x_var, y=y_var)) +
        xlab(label_x) +
        ylab(label_y) +
        theme(panel.border = element_blank(), axis.line = element_line()) +
        geom_point(shape = 16) +
        xlim(60, 80) +
        ylim(60, 80) +
        geom_smooth(method = "lm")
    }
    
    else if(input$smooth == "Without"){
      g <- ggplot(galton, aes(x=x_var, y=y_var)) +
        xlab(label_x) +
        ylab(label_y) +
        theme(panel.border = element_blank(), axis.line = element_line()) +
        geom_point(shape = 16) +
        xlim(60, 80) +
        ylim(60, 80) 
    }
    
      print(g)

  })
  
  output$slope <- renderText({
    slope()
  })
  
})