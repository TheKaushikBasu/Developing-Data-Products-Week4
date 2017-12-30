# ------------------------------------------------------------------------------------
# Course Name    : Developing Data Products
# Assignment Name: Peer-graded Assignment: Shiny Application and Reproducible Pitch
# File Name      : ui.R
# Student Name   : Kaushik Basu
# Created By     : 27-DEC-2017
# ------------------------------------------------------------------------------------

#Load in necessary libraries
library(shiny)
library(ggplot2)

# Load Library to add support for graphical tooltips and popovers to enrich UI.
library(shinyBS) 

# Load Library to add Bootstrap themes to the Shiny app.
library(shinythemes)

dataset <- diamonds

# 'mtcars' dataset, user for setting up limits in UI widgets.
data("mtcars")
minCylinders = min(mtcars$cyl)
maxCylinders = max(mtcars$cyl)

minDisp = min(mtcars$disp)
maxDisp = max(mtcars$disp)

minHp = min(mtcars$hp)
maxHp = max(mtcars$hp)

minDrat = min(mtcars$drat)
maxDrat = max(mtcars$drat)

minWt = min(mtcars$wt)
maxWt = max(mtcars$wt)

minQsec = min(mtcars$qsec)
maxQsec = max(mtcars$qsec)

minGear = min(mtcars$gear)
maxGear = max(mtcars$gear)

minCarb = min(mtcars$carb)
maxCarb = max(mtcars$carb)


# Initialize the UI widgets for a hypothetical car 
defaultCar <- data.frame(
  cyl = 5, 
  disp = 100, 
  hp = 65, 
  drat = 4.6, 
  wt = 2.3, 
  qsec = 25, 
  vs = 1, 
  am = 1, 
  gear = 4, 
  carb = 2)

shinyUI(
  navbarPage("Fuel Consumption Prediction",
    theme = shinytheme("simplex"),
    tabPanel(
      "Prediction",
      sidebarPanel(
        width = 4,
        radioButtons("vs", label = "Engine shape", choices = list("V-Shape" = 1, "Straight" = 0), selected = 1, inline = TRUE),
        bsTooltip(id = "vs", title = "Engine cylinder configuration (V-shape or straight)", placement = "right", options = list(container = "body")),
        
        radioButtons("am", label = "Transmission", choices = list("Automatic" = 1, "Manual" = 0), selected = 1, inline = TRUE),
        bsTooltip(id = "am", title = "Transmission type (automatic or manual)", placement = "right", options = list(container = "body")),
        
        sliderInput("gear", "Gears", min = minGear, max = maxGear, value = defaultCar$gear, step = 1),
        bsTooltip(id = "gear", title = "Number of forward gears in the transmission", placement = "right", options = list(container = "body")),
        
        sliderInput("carb", "Carburetors", min = minCarb, max = maxCarb, value = defaultCar$carb, step = 1),
        bsTooltip(id = "carb", title = "Number of carburetor barrels", placement = "right", options = list(container = "body")),
        
        
        sliderInput("cyl", "Cylinders", min = minCylinders, max = maxCylinders, value = defaultCar$cyl, step = 1),
        bsTooltip(id = "cyl", title = "Number of cylinders in the engine", placement = "right", options = list(container = "body")),
        
        sliderInput("disp", "Displacement", min = minDisp, max = maxDisp, value = defaultCar$disp, step = 1),
        bsTooltip(id = "disp", title = "Engine displacement (in cu.in.)", placement = "right", options = list(container = "body")),
        
        sliderInput("hp", "Power", min = minHp, max = maxHp, value = defaultCar$hp, step = 1),
        bsTooltip(id = "hp", title = "Engine's gross horsepower in HP", placement = "right", options = list(container = "body")),
        
        sliderInput("drat", "Rear axle ratio", min = minDrat, max = maxDrat, value = defaultCar$drat, step = 0.01),
        bsTooltip(id = "drat", title = "Rear axle ratio", placement = "right", options = list(container = "body")),
        
        sliderInput("wt", "Weight", min = minWt, max = maxWt, value = defaultCar$wt, step = 1),
        bsTooltip(id = "wt", title = "Weight in 1000 lbs", placement = "right", options = list(container = "body")),
        
        sliderInput("qsec", "1/4 mile time", min = minQsec, max = maxQsec, value = defaultCar$qsec, step = 0.1),
        bsTooltip(id = "qsec", title = "1/4 mile time in seconds", placement = "right", options = list(container = "body"))
        
      ),
      
      mainPanel(
        width = 8,
        h3("Fuel Consumption"),
        br(),
        p("Consumption for the selected options will be: "),
        tableOutput("prediction")
        
      )
      
    ),
    
    tabPanel(
      "Help",
      p("A Random Forest prediction model is generated for a specific dataset of cars."),
      p("User can select values to simulate the parameters of a hypothetical car and be able to predict its MPG consumption."),
      p("Dataset used by the application is in ",
        a(href = "https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html", "Motor Trend Car Road Tests"),
        "The data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption with 10 aspects of automobile design and performance for 32 automobiles (1973-74 models)."
      ),
      
      tags$div("The dataset structure is given below:",
           tags$ul(
             tags$li(strong("mpg"), "Miles/(US) gallon"),
             tags$li(strong("cyl"), "Number of cylinders"),
             tags$li(strong("disp"), "Displacement (cu.in.)"),
             tags$li(strong("hp"), "Gross horsepower"),
             tags$li(strong("drat", "Rear axle ratio"),
             tags$li(strong("wt"), "Weight (1000 lbs)"),
             tags$li(strong("qsec"), "1/4 mile time"),
             tags$li(strong("vs"), "V/S (V-shape or straight engine)"),
             tags$li(strong("am"), "Transmission (0 = automatic, 1 = manual)"),
             tags$li(strong("gear"), "Number of forward gears"),
             tags$li(strong("carb"), "Number of carburetor"))
           ),
           
           tableOutput("dataStructure")
           
      )
      
    ),
    
    tabPanel(
      "About",
      h3("Developing Data Products - Week 4 Assignment - Shiny Application and Reproducible Pitch"),
      h3("Author: Kaushik Basu - December, 2017"),
      br(),
      p("This application shows an example of making a web application using R and ",
        a(href = "https://shiny.rstudio.com/", "Shiny library"),
        "corresponds to the week 4 assigment of the course - ",
        a(href = "https://www.coursera.org/learn/data-products", "Developing Data Products"), " from Coursera"
      ),
      
      p("Source code of this application is available at",
        a(href = "https://github.com/TheKaushikBasu/Developing-Data-Products-Week4",
          "https://github.com/TheKaushikBasu/Developing-Data-Products-Week4")
      )
      
    )
    
    
  )
  
)