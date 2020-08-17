#Getting data - setwd must be changed to the directory where the files are
setwd( "C:/Users/danie/OneDrive/Documentos/Daniel/Formación Complementaria/Data Analysis/Getting and Cleaning Data")
xtest<-read.csv("X_test.txt",sep=" ",header = FALSE)
ytest<-read.csv("y_test.txt",sep=" ",header = FALSE)
xtrain<-read.csv("X_train.txt",sep=" ",header = FALSE)
ytrain<-read.csv("y_train.txt",sep=" ",header = FALSE)
features<-read.csv("features.txt",sep=" ",header = FALSE)
features<-features$V2
#Cleaning data
library(dplyr)
xtest<-select(xtest,V2:V562)
xtrain<-select(xtrain,V2:V562)
data<-rbind(xtest,xtrain)
labels<-rbind(ytest,ytrain)
#Well naming observations
for (i in 1:length(labels$V1)){
  if (labels$V1[i]==1){
    labels$V1[i]<-"Walking"
  }else if(labels$V1[i]==2){
    labels$V1[i]<-"Walking upstairs"
  }else if(labels$V1[i]==3){
    labels$V1[i]<-"Walking downstairs"
  }else if(labels$V1[i]==4){
    labels$V1[i]<-"Sitting"
  }else if(labels$V1[i]==5){
    labels$V1[i]<-"Standing"
  }else if(labels$V1[i]==6){
    labels$V1[i]<-"Laying"
  }
}
#Tidying up data
data<-cbind(labels,data)
names(data)<- c("Activity",features)
#Extracting only the measurements on the mean and standard deviation for each measurement
data<-select(data,grep("mean",names(data)),grep("std",names(data)))
#Giving variables readable names
names<-names(data)
names<-sub("Gyro"," gyroscope",names)
names<-sub("Acc"," accelerometer",names)
names<-sub("fBody"," Fourier",names)
names<-sub("tBody","Body",names)
names<-sub("tGravity","Gravity",names)
names<-sub("-std()"," standar deviation",names)
names(data)<-names
data<-cbind(labels,data)
names(data)<-c("Activity",names)
#Showing tidy data
View(data)
#Second, independent tidy data set with the average of each variable for each activity and each subject
result<-aggregate(try[, 2:ncol(try)], list(try$Activity), mean)
View(result)
