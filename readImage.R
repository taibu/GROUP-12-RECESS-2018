library(EBImage)
library(keras)

pic1 <- c('p1.jpg','p2.jpg','p3.jpg','p4.jpg','p5.jpg','p6.jpg','p7.jpg','p8.jpg')
train <-list()
for (i in 1:8) {
  train[[i]] <- readImage(pic1[i])
}

pic2 <- c('p9.jpg','p10.jpg','p11.jpg','p12.jpg')
test <-list()
for (i in 1:4) {
  test[[i]] <- readImage(pic2[i])
}
#explore
print(train[[6]])
summary(train[[6]])
display(train[[6]])
plot(train[[6]])

par(mfrow= c(2,4))
for (i in 1:8) {
  plot(train[[i]])
}
#structure of data
str(train)
#resize data
for (i in 1:8) {
  train[[i]] <- resize(train[[i]],100,100)
}

for (i in 1:4) {
  test[[i]] <- resize(test[[i]],100,100)
}

par(mfrow= c(2,4))
for (i in 1:8) {
  plot(train[[i]])
}
