library(shiny)
library(dplyr)

actor <- read.csv("wage_actor.csv",sep = ";",header = TRUE)
athlete <- read.csv("wage_athlete.csv",sep = ";",header = TRUE)
data_sets <- c("actor", "athlete")

shinyServer(function(input, output) {
      
      # Drop-down selection box for which data set
      output$choose_dataset <- renderUI({
            selectInput("dataset", "Choose your category", as.list(data_sets))
      })
      
      output$choose_celeb <- renderUI({
            # If missing input, return to avoid error later in function
            if(is.null(input$dataset))
                  return()
            
            # Get the data set with the appropriate name
            dat <- get(input$dataset)
            celebnames <- dat[,1]
            selectInput("celeb", "Choose your celebrity",
                        choices = celebnames)
      })
      
      #Output the data
      celebrity <- eventReactive(input$submit, {
            input$celeb
      })
      
      ur_wage <- eventReactive(input$submit, {
            input$salary
      })
      
      celeb_wage <- eventReactive(input$submit, {
            dat <- get(input$dataset)
            dat <- dat %>% filter(dat[,1] == input$celeb)
            dat[,2]
      })
      
      output$result <- renderText({
            if(is.null(input$dataset))
                  return()
            paste0("The annual income of ",celebrity()," is ",celeb_wage()," $")
      })
      
      nb_years <- eventReactive(input$submit, {
            nb_year <- as.numeric(celeb_wage() / ur_wage())
            round(nb_year)    
      })
      
      output$result3 <- renderText({
            if(is.null(input$dataset))
                  return()
            paste0("With your current salary, It would take you about ",nb_years()," years to earn the same as your selected celebrity annual income")
      })
      
      output$image1 <- renderImage({
            return(list(src="count.jpg",align="center"))
      },deleteFile = FALSE)
      
      fin_year <- eventReactive(input$submit,{
            2017+nb_years()
      })
      
      output$result4 <- renderText({
            if(is.null(input$dataset))
                  return()
            paste0("IF YOU START NOW, you'd almost be finished in ",fin_year()," !")
      })
      
})