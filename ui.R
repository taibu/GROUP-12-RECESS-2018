library(shiny)
shinyUI(fluidPage(
  titlePanel("MULTISALIENT OBJECT DETECTION SYSTEM"),
  sidebarLayout(
    sidebarPanel(selectInput("data","select the image you want",c("one salient","two salient","three salient","four salient","none"))),
    mainPanel(tabsetPanel(type = "tab",
                          tabPanel("category",textOutput("choice")),
                          tabPanel("PREVIEW"),
                          tabPanel("VISUALIZE"),
                          tabPanel("HELP")
      
    )
      
    )
  )
)
  
)