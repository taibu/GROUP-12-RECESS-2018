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
                     menuItem("Dataset",tabName="two"
                     ),
                     menuItem("Training",tabName="Train",
                              menuSubItem("Model Training History",tabName = "plt"),
                              menuSubItem("Model Summary",tabName = "smr"
                                          )
                                          )
                              
                     , menuItem("Analyse Images",tabName="analyse"
                     ),
                     menuItem("Test",tabName="test",
                              menuSubItem("Plot Accuracy",tabName = "Tplt"),
                              menuSubItem("Testing Data Summary",tabName = "Testsmr")  
                     ),
                     menuItem("HELP",tabName="helpmenu"
                     )
                 
                   )),
  dashboardBody(
               #Including the css for the project
               tags$head(
                 tags$link(rel="stylesheet",type="text/css",href="rcss.css")
               ),
               tabItems(
                 tabItem(tabName = "helpmenu",
                        fluidRow(box(title="HELP",
                         h3("Read Documentation below for help"),
                         hr(),
                         h4("1. How to analyse and know the number of objects in a scene"),
                        textOutput("help1"),
                        tags$img(src="help/analyse.png",class="imac1",width=50,height=150),
                        tags$img(src="help/imageanalyse.png",class="imac",width=50,height=150),
                        hr(),
                        h4("2. How to see images with a given number of salient objects"),
                        textOutput("help2"),
                        h4("3. How to use the tabs on the menu"),
                        textOutput("help3"),
                        hr(),
                        h5("i. HOME tab"),
                        textOutput("help4"),
                        hr(),
                        h5("ii. 1 Object, 2 Objects, 3 Objects,4+ Objects tabs"),
                        textOutput("help5"),
                        hr(),
                        h5("iii. Visualisation tab"),
                        textOutput("help6"),
                        br(),
 
                     width=12))),
                 tabItem(tabName = "home",box(
                     h3("Welcome to MSO software, Your number one multisalient object detection system"),
                     tags$img(src="img/home2.PNG"),
                         width = 12
                     )),
                 tabItem(tabName = "Tplt",
                 fluidRow(box(title = "Training summary",tableOutput("data"),width=12
                                      
                              ))
                 ),
                 tabItem(tabName = "analyse",
                         fluidRow(box(width=12,
                           
                            br(),
                                #fileInput("img", "Choose Image Files Here",multiple = T,
                                          #accept = c(
                                          #  "image/PNG","image/JPG","image/JPEG","image/TIFF"
                                            
                                        #  )
                               # ), 
                                selectInput("image", "CHOOSE IMAGE HERE:", list.files("www/MSO")),
                                
                            box(id="mbox",width = 6,height =340,displayOutput("images")),
                            #,tags$img(src="img/COCO_COCO_train2014_000000001737.jpg",class="ima",width=100,height=600)
                            
                          tabBox(id="imager",height = 340,
                                tabPanel("OBJECTS",h4("Number of Salient Objects:",id="no"),textOutput("obj"),active=T),
                                tabPanel("IMAGE PLOT",plotOutput("ploty"))
                                 ),
                         
                            
                          br(),br()
                         ))
                 ),
                tabItem(tabName = "plt",plotOutput("modelplot")),
                tabItem(tabName = "smr",verbatimTextOutput('summary'))
               )
                )
)
)

 