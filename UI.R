library(shiny)

shinyUI(fluidPage(
  titlePanel(h1("MULTISALIENT OBJECT DETECTION")),
  sidebarLayout(
    sidebarPanel(textInput("name","enter your username",""),
                 passwordInput("pass","enter your password"),
                 submitButton("login"),
                 h5("made by:")),
              
    mainPanel(
    
    )
  )
)
  
)
