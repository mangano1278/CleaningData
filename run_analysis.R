
run_analysis <- function(directory)
{
  
  #This function loads the data from the UCI HAR Dataset study and combinds the test and train groups
  #Once both data sets have been loaded, it then summarizes the total data of both sets,
  #taking the average of each measured value of the individual subjects and activities.
  
  #Activities are decoded and saved as their actual event, where subjects remain numbered
  #Columns are given their variable names as represented in the data set file
  
  
  final<-data.frame()
  singlerow<-data.frame()
  
  finaltest<-data.frame()
  finaltrain<-data.frame()
  
  if(directory==NULL){directory<=""}
  
  features<-read.table(file=paste(directory,"/UCI HAR Dataset/features.txt",sep=""))
  sub_test<-read.csv(file=paste(directory,"/UCI HAR Dataset/test/subject_test.txt",sep=""))
  x_test<-read.table(file=paste(directory,"/UCI HAR Dataset/test/X_test.txt",sep=""),header=FALSE)
  y_test<-read.csv(file=paste(directory,"/UCI HAR Dataset/test/y_test.txt",sep=""))
  #Step 4, appropriately names columns
  colnames(x_test)<-features[,2]

  
  #Step 3, uses descriptors for the activity names instead of codes.
  for(i in 1:2946)
  {
    if(y_test[i,1]=="1"){ activity<-"WALKING"}
    if(y_test[i,1]=="2"){ activity<-"WALKING_UPSTAIRS"}
    if(y_test[i,1]=="3"){ activity<-"WALKING_DOWNSTAIRS"}
    if(y_test[i,1]=="4"){ activity<-"SITTING"}
    if(y_test[i,1]=="5"){ activity<-"STANDING"}
    if(y_test[i,1]=="6"){ activity<-"LAYING"}
  
  singlerow<-cbind(sub_test[i,1],activity,x_test[i,])
  finaltest<-rbind(finaltest,singlerow)
  }
  
  
  sub_train<-read.csv(file=paste(directory,"/UCI HAR Dataset/train/subject_train.txt",sep=""))
  x_train<-read.table(file=paste(directory,"/UCI HAR Dataset/train/X_train.txt",sep=""),header=FALSE)
  y_train<-read.csv(file=paste(directory,"/UCI HAR Dataset/train/y_train.txt",sep=""))
  colnames(x_train)<-features[,2]
  
  for(i in 1:7351)
  {
    if(y_train[i,1]=="1"){ activity<-"WALKING"}
    if(y_train[i,1]=="2"){ activity<-"WALKING_UPSTAIRS"}
    if(y_train[i,1]=="3"){ activity<-"WALKING_DOWNSTAIRS"}
    if(y_train[i,1]=="4"){ activity<-"SITTING"}
    if(y_train[i,1]=="5"){ activity<-"STANDING"}
    if(y_train[i,1]=="6"){ activity<-"LAYING"}
    
    singlerow<-cbind(sub_train[i,1],activity,x_train[i,])
    finaltrain<-rbind(finaltrain,singlerow)
  }

  #Finalizes column names of step 4
  colnames(finaltest)[1]<-"Subject"
  colnames(finaltest)[2]<-"Activity"
  colnames(finaltrain)[1]<-"Subject"
  colnames(finaltrain)[2]<-"Activity"
  
  #Merges both files of train and test data (step 1)
  final<-rbind(finaltest,finaltrain)
  
  #Writes total data to file named "Aggregate Data", comma separated
  write.table(final,"Aggregate Data.txt",sep=",",row.names=FALSE)
  
  #Summarizes data using aggregate function.  Returns the means of all observed values
  #summarized by subject and activity.
  #Writes summarized data to file named "Summarized Data", comma separated
  
  #Step 5, creates smaller, summary data set
  aggfinal<-aggregate(final, by=list(final$Subject,final$Activity), FUN=mean)
  
  #Step 2, removes all non-mean, non-st. dev columns from total data
  writeagg<-aggfinal[,grep("[Mm]ean|[Ss][Tt][Dd]|Group",colnames(aggfinal))]
  
  colnames(writeagg)[1]<-"Subject"
  colnames(writeagg)[2]<-"Activity"
    
  write.table(writeagg,"Summarized Data.txt",sep=",",row.names=FALSE)  
  
  return(writeagg)
}
