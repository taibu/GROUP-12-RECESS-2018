library("shiny")
library("shinydashboard")
library("datasets")
library("EBImage")
library("keras")
library("tools")
shinyServer(function(input,output,session){
  ##########################################################
  setwd("E:/Data_set_12_Multi-Salient-Object(MSO)Dataset/mso-dataset/MSO_img")
  dataset<-c() #create empty object for storing animal IDs
  images<-character() #create empty object for storing image basenames
  for(j in dir()){
    if( file_ext(j) == 'jpg'){ 
      ID<-basename(j) #extract ID of folder
      dataset<-append(dataset, ID)
    }
  }
  pics<-list()
  for(i in 1:120){pics[[i]]<-readImage(dataset[i])}
  mypic<-list()
  for(i in 1:120){mypic[[i]]<-readImage(dataset[i])}
  print(mypic[[1]])
  hist(mypic[[2]])
  str(mypic)
  output$ploty<-renderPlot({
    hist(mypic[[50]])
  })
  output$images<-renderDisplay({
    display(pics[[2]])
  })
  eilabel<-bwlabel(mypic[[50]])
  output$obj<-renderText({
    max(eilabel)
  })
  #RESIZE
  for(i in 1:120){mypic[[i]]<-resize(mypic[[i]],28,28)}
  #RESHAPE
  for(i in 1:120){mypic[[i]]<-array_reshape(mypic[[i]],c(28,28,3))}
  #ROW BIND
  trainx<-NULL
  for(i in 1:100){trainx<-rbind(trainx,mypic[[i]])}
  str(trainx)
  testx<-NULL
  testx<-rbind(mypic[[101]],mypic[[102]],mypic[[103]],mypic[[120]],mypic[[119]],mypic[[118]],
               mypic[[117]],mypic[[116]],mypic[[115]],mypic[[114]],mypic[[113]],mypic[[112]],
               mypic[[111]],mypic[[110]],mypic[[109]],mypic[[108]],mypic[[107]],mypic[[106]],
               mypic[[105]]
  )
  str(testx)
  #Response
  display(mypic[[101]])
  trainy<-c(2,1,4,4,1,1,1,1,4,1,4,4,4,1,4,1,1,4,1,4,4,1,4,1,1,3,1,4,4,2,1,2,2,4,4,
            4,1,4,3,4,1,4,2,1,3,2,4,4,4,4,1,2,4,2,1,3,1,1,1,2,1,2,4,1,4,4,1,1,4,2,
            1,4,2,1,2,1,4,1,1,1,2,1,2,4,1,1,1,4,4,1,1,1,3,4,3,1,1,3,4,1)
  length(trainy)
  testy<-c(1,2,1,1,1,4,1,1,4,1,2,1,1,4,4,0,4,1,2)
  length(testy)
  
  #one hot encoding
  trainLabels<-to_categorical(trainy)
  trainLabels
  testLabels<-to_categorical(testy)
  testLabels
  #MODEL
  model <- keras_model_sequential()
  model %>% 
    layer_dense(units = 256, activation = 'relu',input_shape = c(2352)) %>%
    layer_dense(units=128,activation = 'relu') %>%
    layer_dense(units = 5,activation = 'softmax')
  
  output$summary<-renderPrint({
    summary(model) 
  })
  model %>%
    compile(loss='categorical_crossentropy',
            optimizer = optimizer_rmsprop(),
            metrics = c('accuracy'))
  
  
  history<-model %>%
    fit(
      trainx,trainLabels,
      epochs = 30,
      batch_size = 32,
      validation_split = 0.2
      #validation_data = list(test,testLabels)
    ) 
  output$modelplot<-renderPlot({
    plot(history)
  })
  model %>% evaluate(trainx,trainLabels)
  pred<-model %>% predict_classes(trainx)
  table(predicted=pred,Actual=trainy)
  
  prob<-model %>% predict_proba(trainx)
  cbind(prob,predicted=pred,Actual=trainy)
  
  #Evaluation & prediction -training data
  model %>% evaluate(testx,testLabels)
  pred<-model %>% predict_classes(testx)
  table(predicted=pred,Actual=testy)
  ##########################################################
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
  output$imageplot<-renderPlot({
   plot(img()) 
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
    paste0("This is the home page of the multi salient object detection system. 
It is the first page that is shown to the user when he/she opens the system in 
 the browser window. It contains menu tabs in the dashboard 
           which links to the rest of the functionality of the system.")
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
      
    })
    



