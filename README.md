---
title: "Getting and cleaning data course project"
output: github_document
---
## ReadMe

Data source is here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Data description is here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Instructions
1. Unzip the input file
2. install package 'dplyr'
3. Within the extracted directory execute the run_analysis.R script
4. Read the tidy data from 'tidydataset.txt' also within the extracted directory

##Data Files

Following data files are read:

features.txt                  This contains the list of feature / variable names
test/X_test.txt               This contains the measurements taken [Test set]
test/y_test.txt               This contains the list of activities being done for each measurement [Test set]
test/subject_test.txt         This contains the id of the subject (person) performing each activity [Test set]
train/X_train.txt             This contains the measurements taken [Trainging set]
train/y_train.txt             This contains the list of activities being done for each measurement [Training set]
train/subject_train.txt       This contains the id of the subject (person) performing each activity [Training set]
activity_labels.txt           This contains the list of activity descriptions


The working directory is assumed to the same as the extracted data set.

e.g. if the zip file is downloaded and extracted to ~/home/code/UCI HAR Dataset/, then the working directory is assumed to be ~/home/code/UCI HAR Dataset/

NB: The set of files under the Intertial* directory were not read, as these are not important for the problem statement

##Process
The code does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Output

The tidy data set is stored in a file called 'tidydataset.txt'

This data set meets the principles of tidy data, by storing the variables in a wide form - please see discussion 
https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/
For details

##Components
* The data files listed above
* CodeBook.md (code book)
* run_analysis.R (Single R script containing all the processing described in this readme)
* tidydataset.txt (Tidy data set with the average of each variable, for each acitivty and each subject)

## Reading data

    data <- read.table("tidydataset.txt", header = TRUE)
    View(data)
