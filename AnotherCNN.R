library("keras")
#library("tensorflow")
library("tools")
library("EBImage")
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

summary(model)
model %>%
  compile(loss='categorical_crossentropy',
          optimizer = optimizer_rmsprop(),
          metrics = c('accuracy'))


history<-model %>%
  fit(
    trainx,trainLabels,
    epochs = 60,
    batch_size = 32,
    validation_split = 0.2
    #validation_data = list(test,testLabels)
  )  
plot(history)
#Evaluation & prediction -training data
model %>% evaluate(trainx,trainLabels)
pred<-model %>% predict_classes(trainx)
table(predicted=pred,Actual=trainy)

prob<-model %>% predict_proba(trainx)
cbind(prob,predicted=pred,Actual=trainy)

#Evaluation & prediction -training data
model %>% evaluate(testx,testLabels)
pred<-model %>% predict_classes(testx)
table(predicted=pred,Actual=testy)
#display(pics[[120]])
prob<-model %>% predict_proba(train)
cbind(prob,predicted_class=pred,Actual=trainy)