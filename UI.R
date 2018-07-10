library("shiny")
library("shinydashboard")
library("datasets")
library("keras")
library("tools")
library("EBImage")
shinyUI(dashboardPage(
  dashboardHeader(title="MULTI SALIENT OBJECT DETECTION SYSTEM", titleWidth = 800),
  dashboardSidebar(collapsed =FALSE,
                   sidebarMenu(
                     menuItem("HOME",tabName="home"
                     ),
                     menuItem("Analyse Images",tabName="analyse"
                     )
                     
                     
                     )
                     
                     
                     
                     )
                     
                   ))
  dashboardBody(
    #Including the css for the project
    tags$head(
      tags$link(rel="stylesheet",type="text/css",href="rcss.css")
    ),
    tabItems(
      
      tabItem(tabName = "home",box(
        h3("Welcome to MSO software, Your number one multisalient object detection system"),
        tags$img(src="img/home.PNG"),
        width = 12
      )),
      
      tabItem(tabName = "analyse",
              fluidRow(box(width=12,
                           
                           br(),
                           #fileInput("img", "Choose Image Files Here",multiple = T,
                           #accept = c(
                           #  "image/PNG","image/JPG","image/JPEG","image/TIFF"
                           
                           #  )
                           # ), 
                           selectInput("image", "CHOOSE IMAGE HERE:", list.files("MSO_img")),
                           
                           box(id="mbox",width = 6,height =340,imageOutput("myImage")),
                           #,tags$img(src="img/COCO_COCO_train2014_000000001737.jpg",class="ima",width=100,height=600)
                           
                           tabBox(id="imager",height = 340,
                                  tabPanel("Objects",h4("Number of Objects: 4",textOutput("eilabel"),id="no"),active=T),
                                  tabPanel("Details")
                           ),
                           
                           
                           br(),br()
              ))
      )
    )
  )



