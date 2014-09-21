run_analysis <- function () {
  #Prepare useful reference variables
  Main_Directory <- paste(getwd(),"/UCI HAR Dataset/",sep="")
  Test_Directory <- paste(getwd(),"/UCI HAR Dataset/test/",sep="")
  Train_Directory <- paste(getwd(),"/UCI HAR Dataset/train/",sep="")
  
  #Read in activity_label.txt to be used later to provide activity description
  Activity_Labels <- read.table(paste(Main_Directory,"activity_labels.txt",sep=""),as.is=T)
  names(Activity_Labels) <- c("activity.id","activity.description")
  
  #Read in features.txt and remove unecessary punctuation  
  Features <- read.table(paste(Main_Directory,"features.txt",sep=""), as.is=T)
  names(Features) <- cbind("feature.id", "feature.description")
  Features[["feature.description"]] = gsub("-",".",Features[["feature.description"]])
  Features[["feature.description"]] = gsub("[()]","",Features[["feature.description"]])
  
  #Extract out all the features that specifically state mean/std and not meanFreq
  Mean_And_Std_Cols <- grepl("[.]mean[.]|[.]std[.]",Features[["feature.description"]])
  Features <- Features[Mean_And_Std_Cols,]
  
  #Read in datasets
  Train_Feature_Data <- read.table(paste(Train_Directory,"X_train.txt",sep=""))
  Train_Feature_Data <- Train_Feature_Data[,Mean_And_Std_Cols]
  Train_Activity_Data <- read.table(paste(Train_Directory,"y_train.txt",sep=""))
  Train_PersonID_Data <- read.table(paste(Train_Directory,"subject_train.txt",sep=""))
  Test_Feature_Data <- read.table(paste(Test_Directory,"X_test.txt",sep=""))
  Test_Feature_Data <- Test_Feature_Data[,Mean_And_Std_Cols]
  Test_Activity_Data <- read.table(paste(Test_Directory,"y_test.txt",sep=""))
  Test_PersonID_Data <- read.table(paste(Test_Directory,"subject_test.txt",sep=""))
  
  #Start merging test and train data
  Combined_Feature_Data <- rbind(Train_Feature_Data,Test_Feature_Data)
  names(Combined_Feature_Data) <- Features[["feature.description"]]
  
  Combined_Activity_Data <- rbind(Train_Activity_Data,Test_Activity_Data)
  
  #Convert the numeric data into text based using the activity_label.txt info
  for(i in 1:nrow(Combined_Activity_Data)){
    for(j in 1:nrow(Activity_Labels)){
      if(Combined_Activity_Data[i,1] == Activity_Labels[j,1]) Combined_Activity_Data[i,2] = Activity_Labels[j,2]
    }
  }
  names(Combined_Activity_Data) <- c("activity.id", "activity.description")
  
  Combined_PersonID_Data <- rbind(Train_PersonID_Data,Test_PersonID_Data)
  names(Combined_PersonID_Data) <- "id.of.person.performing.activity"
  
  #Merge feature, activity and subject data
  Combined_Data <- data.frame(Combined_Feature_Data,Combined_Activity_Data[["activity.description"]],Combined_PersonID_Data)  
  names(Combined_Data)[ncol(Combined_Data)-1] <- "activity.description"
  
  write.table(Combined_Data,"combined_data.txt",row.name=F)
  
  #Begin calculating average of the data in Combined_Data
  Averaged_Data <- NULL
  Activity_Data <- NULL
  PersonID_Data <- NULL
  for(i in 1:30) {
    for(j in 1:nrow(Activity_Labels)) {
      Rows_To_Average <- Combined_Data[(Combined_Data[["activity.description"]] %in% Activity_Labels[j,2]) & (Combined_Data[["id.of.person.performing.activity"]] %in% i),1:(ncol(Combined_Data)-2)]
      Averages <- sapply(Rows_To_Average, mean)
      Averaged_Data <- rbind(Averaged_Data, Averages)
      Activity_Data <- rbind(Activity_Data, Activity_Labels[j,2])
      PersonID_Data <- rbind(PersonID_Data, i)
    }
  }
  
  Averaged_Data <- data.frame(Averaged_Data, Activity_Data, PersonID_Data, row.names=NULL)
  #Create names for the new variables
  names(Averaged_Data) <- paste("average.of.",names(Combined_Data),sep="")
  names(Averaged_Data)[ncol(Averaged_Data)-1] = "activity.description"
  names(Averaged_Data)[ncol(Averaged_Data)] = "id.of.person.performing.activity"
  
  write.table(Averaged_Data,"averaged_data.txt",row.name=F)
  
}