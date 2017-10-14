
#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
shinyUI(fluidPage(
  titlePanel("Parent vs. Child Height"),
    sidebarPanel(
      selectInput("yvar", "Choose your dependent variable", c("Parent", "Child"), selected = "child"),
      selectInput("smooth", "With or without fit line", c("With", "Without"), selected = "Without"),
      submitButton("Submit")
    ),
    mainPanel(
      plotOutput("plot"),
      h3("Slope:"),
      textOutput("slope")
    )
))