library("shiny")
library("shinydashboard")
library("datasets")
shinyServer(function(input,output,session){
  
  output$textDisplay<-renderText({
    paste0("You said'",input$comment,
           "'.there are",nchar(input$comment),
           "characters in this.")
  }
  
  )
  output$image<-renderImage(
    input$img
  )
  output$contents <- renderTable({
    inFile <- input$file1
    if (is.null(inFile))
      return(NULL)
    read.csv(inFile$datapath, header = input$header)
  })
  output$plot <- renderPlot({
    input$newplot
    # Add a little noise to the cars data
    cars2 <- cars + rnorm(nrow(cars))
    plot(cars2)
    
  })
  output$plot2 <- renderPlot({
    # Re-execute this reactive expression after 2000 milliseconds
    invalidateLater(2000)
    hist(rnorm(isolate(input$n)))
  }) 
  
  ##################################################
  output$help2<-renderText({
    "To view all the images/scenes with a given number of salient objects, click on 
    a tab of that category on the tabmenu.All the images/scenes with that number of 
    salient objects will be displayed under that tab"
  }
  
  )
  output$help1<-renderText({
    paste0("To know the number of salient objects in a scene, use the
           search box on the left side of the browser window to upload the image
           .After the image has loaded,it will be displayed in the preview tab
           on the tab menu.Under the image, the number of salient objects it contain
           will be displayed")
  })
  output$help3<-renderText({
    paste0("Te following sections describe and explain what each of the menu tabs 
           does. You are encouraged to read and understand the content before you
           start using the system most especialy if you are anew user")
  })
  output$help4<-renderText({
    paste0("To know the number of salient objects in a scene, use the
           search box on the left side of the browser window to upload the image
           .After the image has loaded,it will be displayed in the preview tab
           on the tab menu.Under the image, the number of salient objects it contain
           will be displayed")
  })
  output$help5<-renderText({
    "To view all the images/scenes with a given number of salient objects, click on 
    .After the image has loaded,it will be displayed in the preview tab
    on the tab menu.Under the image, the number of salient objects it contain
    will be display
    a tab of that category on the tabmenu.All the images/scenes with that number of 
    salient objects will be displayed under that tab"
  }
  
  )
  output$help6<-renderText({
    "To view all the images/scenes with a given number of salient objects, click on 
    .After the image has loaded,it will be displayed in the preview tab
    on the tab menu.Under the image, the number of salient objects it contain
    will be display
    a tab of that category on the tabmenu.All the images/scenes with that number of 
    salient objects will be displayed under that tab"
  })
  output$data<-renderTable({
    head(mtcars)
    
  })
  output$myImage <- renderImage({
    # When input$n is 3, filename is ./images/image3.jpeg
    filename <- normalizePath(file.path('www/MSO',
                                        paste(input$image)))
    
    # Return a list containing the filename and alt text
    list(src =filename,
         alt = paste("Image number", input$n))
    
  }, deleteFile = FALSE)
  img <- reactive({
    f = list.files("input$image")
    readImage(f)
  })
  
  output$widget <- renderDisplay({
    display(img())
  })
  output$salient<-renderText({
    #paste(print(max(eilable(readImage(input$image)))
  })
  })



