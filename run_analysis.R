#Load required libraries
library(data.table)
library(sqldf)
library(dplyr)
library(stats)


#Read the List of all Features from features.txt
features<-fread("./Getting and Cleaning Data/Peer Graded Assignment/UCI HAR Dataset/features.txt")

#Create a data frame with the list of feature names
fts<-features[,"V2"]

#Unlist fts to convert into a character vector
fts<-unlist(fts)


#Read the activity labels from activity_labels.txt
labels<-fread("./Getting and Cleaning Data/Peer Graded Assignment/UCI HAR Dataset/activity_labels.txt")


#Read the Test data set
set_test<-fread("./Getting and Cleaning Data/Peer Graded Assignment/UCI HAR Dataset/test/X_test.txt")
subject_test<-fread("./Getting and Cleaning Data/Peer Graded Assignment/UCI HAR Dataset/test/subject_test.txt")
label_test<-fread("./Getting and Cleaning Data/Peer Graded Assignment/UCI HAR Dataset/test/y_test.txt")


#Read the Train data set
set_train<-fread("./Getting and Cleaning Data/Peer Graded Assignment/UCI HAR Dataset/train/X_train.txt")
subject_train<-fread("./Getting and Cleaning Data/Peer Graded Assignment/UCI HAR Dataset/train/subject_train.txt")
label_train<-fread("./Getting and Cleaning Data/Peer Graded Assignment/UCI HAR Dataset/train/y_train.txt")


#Get actvity names associated to its Train label
train_activity_name<-data.frame()
for (i in 1:nrow(label_train))
{
        act_indices<-which(labels[,V1]==label_train[i,V1])
        act<-labels[act_indices,2]
        train_activity_name<-rbind(train_activity_name,act)
}

#Cbind Set_name, Subject ,Activity name and Original Training data set
set_train<-cbind(Set_name="Training Set",Subject=subject_train,Activity_Name=train_activity_name,set_train)


#Get activity names associated to its Test label
test_activity_name<-data.frame()
for (i in 1:nrow(label_train))
{
        act_indices<-which(labels[,V1]==label_test[i,V1])
        act<-labels[act_indices,2]
        test_activity_name<-rbind(test_activity_name,act)
}

#Cbind Set_name, Subject,Activity name and Original Test data set
set_test<-cbind(Set_name="Test Set",Subject=subject_test,Activity_Name=test_activity_name,set_test)


#Merge Test and Train data sets
test_train<-merge(set_test,set_train,all=TRUE)

#Assign column names to merged set
fts<-c("Set_name","Subject","Activity_Name",fts)
colnames(test_train)<-fts

#get mean and standard deviation columns from the fts
mean_std_cols<- grep("\\bmean()\\b|\\bstd()\\b",fts)

#Append Set name, Subject and Activity name columns to above variable
mean_std_cols<- c(1,2,3,mean_std_cols)

#subset the data table to retain only mean and standard deviation columns
final_data_set<-test_train[,mean_std_cols,with=FALSE]

#Create the final Tidy Independent Set  with the average of each variable for each activity and each subject.
tidy_set<-aggregate(final_data_set[, 4:69], list(Set_name=final_data_set$Set_name,Subject=final_data_set$Subject,Activity_name=final_data_set$Activity_Name), mean)
tidy_set<-arrange(tidy_set,Set_name,Subject,Activity_name)
View(tidy_set)

