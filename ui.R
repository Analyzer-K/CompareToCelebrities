library(shiny)
library(png)

shinyUI(pageWithSidebar(
      
      headerPanel("How much do you get paid compared to a top celebrity ?"),
      
      sidebarPanel(
            numericInput("salary","Enter your annual income here ($)",0),
            uiOutput("choose_dataset"),
            uiOutput("choose_celeb"),
            br(),
            actionButton("submit","Go !")
      ),
      
      mainPanel(
            br(),
            h4(textOutput("result"),style="color:blue"),
            br(),
            h4(textOutput("result3"),style="color:red"),
            br(),
            h4(textOutput("result4"),style="color:blue"),
            br(),
            imageOutput("image1")
            
      )
))