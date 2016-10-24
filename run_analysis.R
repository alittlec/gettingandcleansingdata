# Coursera: "Getting and cleaning data course project"
# Data description
#   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Data for reading
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
################################################################################################
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
################################################################################################

#dependency on dplyr lib
library(dplyr);

#read the files
features <- read.table("features.txt", col.names = c("index","name"))

measurements_test <- read.table("test/X_test.txt", col.names = unlist(features['name']))
activities_test <- read.table("test/y_test.txt", col.names = c("activity"))
subjects_test <- read.table("test/subject_test.txt", col.names = c("subjectid"))

measurements_train <- read.table("train/X_train.txt", col.names = unlist(features['name']))
activities_train <- read.table("train/y_train.txt", col.names = c("activity"))
subjects_train <- read.table("train/subject_train.txt", col.names = c("subjectid"))

activity_labels <- read.table("activity_labels.txt", col.names = c("id","label"))

#####################################
# Merges the training and the test sets
#######################################
full_subjects <- rbind(subjects_test, subjects_train)
full_activities <- rbind(activities_test, activities_train)                               
full_measurements <- rbind(measurements_test,measurements_train)

#######################################
# Extracts only the measurements on the mean and standard deviation for each measurement.
#######################################

#ascertain the index of the mean and standard deviation measurements
index_measurements_to_keep <- grep("(.*-mean\\(\\).*)|(.*-std\\(\\).*)", unlist(features['name']))

#use the index to keep required measurments
measurements <- full_measurements[,index_measurements_to_keep] #keep only the mean() and std() measurements

#bring the columns together
measurements <- cbind(full_subjects,full_activities, full_measurements) 

########################################
# Uses descriptive activity names to name the activities in the data set
#########################################

#replace activity ids with the labels (e.g. 'sitting' instead of '4')
measurements$activity <- activity_labels[measurements$activity,2]

###########################################
# Appropriately labels the data set with descriptive variable names.
###########################################

names(measurements)<-gsub("^t", "time", names(measurements))
names(measurements)<-gsub("^f", "frequency", names(measurements))
names(measurements)<-gsub("Acc", "accelerometer", names(measurements))
names(measurements)<-gsub("Gyro", "gyroscope", names(measurements))
names(measurements)<-gsub("Mag", "magnitude", names(measurements))

############################################
# creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#############################################

#aggregate and order
tidy_measurements<-aggregate(. ~subjectid + activity, measurements, mean)  #dplyr lib dependency
tidy_measurements<-tidy_measurements[order(tidy_measurements$subjectid,tidy_measurements$activity),]

#output tidy dataset
write.table(tidy_measurements, file = "tidydataset.txt", row.name = FALSE)


