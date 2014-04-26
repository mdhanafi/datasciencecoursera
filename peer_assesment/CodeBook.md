[COURSERA] Peer Assessments /Getting and Cleaning Data Project - CodeBook
========================================================

Class by:  Jeff Leek

Students: Hanafi

Date: April 2014

-----
# About project
Source: https://class.coursera.org/getdata-002/human_grading/view/courses/972080/assessments/3/submissions

Extracted from the source URL:

*The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.*

-----
# Purpose
To describe the variables, the data, and any transformations or work that has been performed to clean up the data.

-----
# Data

## Source data and associate data frame variables
Following are the source data and the respective used data frame:

1. **Training data set**
 - Read > train_data = read.table("UCI HAR Dataset/train/X_train.txt")
 - Example > 2.8858451e-001 -2.0294171e-002 ...
1. **Test data set** 
 - Read > test_data = read.table("UCI HAR Dataset/test/X_test.txt") 
 - Example > 2.8858451e-001 -2.0294171e-002 ...
1. **List of feature in the data set i.e. column description**
 - Read > dfeature = read.table("UCI HAR Dataset//features.txt")
 - Example > 7 tBodyAcc-mad()-X
 - See also > UCI HAR Dataset/features_info.txt
1. **List of activity constant and description carried out by subject**
 - Read > activity_label = read.table("UCI HAR Dataset//activity_labels.txt")
 - Example > 2 WALKING_UPSTAIRS
1. **Activity label carried out by each subject in training dataset based on code in List of activity</b> 
 - Read > train_label = read.table("UCI HAR Dataset/train/y_train.txt")
1. **Activity label carried out by each subject in test dataset based on code in List of activity</b>
 - Read > test_label = read.table("UCI HAR Dataset/test/y_test.txt")
1. **List of subject id in training dataset**
 - Read > train_subject = read.table("UCI HAR Dataset/train/subject_train.txt")
1. **List of subject id in test dataset**
 - Read  > test_subject = read.table("UCI HAR Dataset/test/subject_test.txt")  

## Data transformation works and cleanup

Following are the steps have been taken to find the needed "tinydata"

1. **(Q1)** Merges the training and the test sets to create one data set 
 - Read and performing row merge of **train_data** with **test_data** via **_data_set = rbind(train_data,test_data)_** 
1. Update column name for data set
 - Read **dfeature** data, i.e. column description of of data set.
 - Update the column name for data set **_names (data_set) = dfeature$V2_**
1. **(Q2)** Extracts only the measurements on the mean 'mean()' and standard deviation 'std()' for each measurement from data set into selected dataset **dselect** 
 - This is via **_dselect = data_set[,grep("{1}.-mean{1}.{1})|{1}.-std{1}.{1})",names(data_set))]_**
1. **(Q3), (Q4)** Uses descriptive activity names to name the activities in the data set by adding new column for activity labelling
 - Read **train_label** via **_train_label$activity_label = activity_label[train_label$V1,2]_**
 - Read **test_label** via **_test_label$activity_label = activity_label[test_label$V1,2]_**
 - Then row combined them via **_label_bind = rbind(train_label,test_label)_**
 - Finally add this column into selected dataset via **_dselect = cbind(dselect,"activity_label"= label_bind$activity_label)_**
1. Assign subject id to the selected data set **dselect**
 - Read **train_subject** via  **_train_subject = read.table("UCI HAR Dataset/train/subject_train.txt")_**
 - Read **test_subject** via  **_test_subject = read.table("UCI HAR Dataset/test/subject_test.txt")_**
 - Then row combined them via **_label_subject = rbind(train_subject, test_subject)_**
 - Finally add this column into selected dataset via **_dselect = cbind(dselect,"subject"= label_subject$V1)_**
1. **(Q5)**Finally generating **tinydata** that is an independent tidy data set with the average of each variable for each activity and each subject.
 - This is via simple agregate function, **_tinydata = aggregate(dselect[1:66], by=list("subject"=dselect$subject,"activity_label"=dselect$activity_label), FUN=mean, na.rm=TRUE)_**
 - Usage of **_dselect[1:66]_** is due to that is the column consist of features list needed in **(Q2)**, **mean()** and **std()** 

#### [End of document] ####
