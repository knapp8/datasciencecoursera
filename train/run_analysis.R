run_analysis <- function(){
  setwd("~")
  ## read
  main_features <- read.table("features.txt",header=FALSE)
  
  ## read test data
  setwd("~/test")
  x_test <- read.table("X_test.txt",header=FALSE)
  y_test <- read.table("y_test.txt",header=FALSE)
  subject_test <- read.table("subject_test.txt", header = FALSE)
  
  ## read train data
  setwd("~/train")
  x_train <- read.table("X_train.txt",header=FALSE)
  y_train <- read.table("y_train.txt",header=FALSE)
  subject_train <- read.table("subject_train.txt", header= FALSE)

  #appending X and Y
  mergedX <- rbind(x_test,x_train)
  mergedY <- rbind(y_test,y_train)
  mergedsubject <- rbind(subject_test,subject_train)
  
  ## adding the activity to the mergeX
  names(mergedX) <- main_features$V2
  mergedX$activity <- mergedY
  mergedX$subject <- mergedsubject
  
 ## getting array of mean and std by searching
  temp <- subset(main_features,grepl("mean(", main_features$V2,fixed =TRUE))
  temp2 <- subset(main_features,grepl("std(", main_features$V2,fixed =TRUE))
  temp3 <- c(562)
  temp4 <- c(563)
  mean_std <- rbind(temp,temp2,temp3,temp4)
  mean_std <- sort(mean_std$V1)
  mergedX[,mean_std]
  
  for (i in 1:nrow(mergedX)){
    if (mergedX[i,562]== 1)
        mergedX[i,562] = "WALKING"
    else if (mergedX[i,562]== 2)
      mergedX[i,562] = "WALKING_UPSTAIRS"
    else if (mergedX[i,562]== 3)
      mergedX[i,562] = "WALKING_DOWNSTAIRS"
    else if (mergedX[i,562]== 4)
      mergedX[i,562] = "SITTING"    
    else if (mergedX[i,562]== 5)
      mergedX[i,562] = "STANDING"    
    else if (mergedX[i,562]== 6)
      mergedX[i,562] = "LAYING"
      }
  
  ##split data into subject
  split_by_subject <- split(mergedX[,mean_std],mergedX$subject)
  
  ##creating empty data frame with same columns
  tidy_data_set <- as.data.frame(mergedX[1,mean_std])
  tidy_data_set$activity = NULL
  tidy_data_set$subject = NULL
  tidy_data_set$tSubject <- "0"
  tidy_data_set$tActivity <- "0"
  
  line_num <- 1
  ##loop through by activiy and add mean to update the tidy_data_set
  for (i in 1:30){
    tempSplit <- split_by_subject[[i]]
    split_by_activity <- split(tempSplit, tempSplit$activity)
    
    for (n in c("LAYING","SITTING","STANDING","WALKING","WALKING_DOWNSTAIRS","WALKING_UPSTAIRS")){
      tempActivityMean <- split_by_activity[[n]]
      ## calculating Mean for the first 66 columns (avergages and standard deviation)
      tempActivityMean <- colMeans(tempActivityMean[1:66])
      tidy_data_set[line_num,1:66] <- tempActivityMean
      tidy_data_set[line_num,"tSubject"] <- i
      tidy_data_set[line_num,"tActivity"] <- n
      line_num <- line_num+1
    }
  }
  head(tidy_data_set)
  
  
  
 
}