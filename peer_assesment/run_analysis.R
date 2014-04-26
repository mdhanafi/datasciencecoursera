# [COURSERA] Peer Assessments /Getting and Cleaning Data Project
# ==============================================================
#  Class by:  Jeff Leek
#
# Source: https://class.coursera.org/getdata-002/human_grading/view/courses/972080/assessments/3/submissions
# 
# By: hanafi
# How to use: Just run the entire script. or in Mac press alt-command-R. See also Menu| Code |Run region | Run All
# The end result tiny data is under "tinydata" variable and does not saved.

 
 
#
# =====================
message("Q: 1. Merges the training and the test sets to create one data set.")
# loading train data and test data into respective data frame
train_data = read.table("UCI HAR Dataset/train/X_train.txt")
test_data = read.table("UCI HAR Dataset/test/X_test.txt")

data_set = rbind(train_data,test_data)
 
#
# =====================  
message("Answering question #4 first..  Q: 4. Appropriately labels the data set with descriptive activity names")
  
# reading features.txt and change the header for dataset
dfeature = read.table("UCI HAR Dataset//features.txt")
names (data_set) = dfeature$V2
 
#
# =====================
message("Q: 2. Extracts only the measurements on the mean 'mean()' and standard deviation 'std()' for each measurement.")
 
# extracting required column
dselect = data_set[,grep("{1}.-mean{1}.{1})|{1}.-std{1}.{1})",names(data_set))]
 
# 
# =====================
message("Q: 3. Uses descriptive activity names to name the activities in the data set")

# add new column for activity labelling
activity_label = read.table("UCI HAR Dataset//activity_labels.txt")

train_label = read.table("UCI HAR Dataset/train/y_train.txt")
train_label$activity_label = activity_label[train_label$V1,2]
 
test_label = read.table("UCI HAR Dataset/test/y_test.txt")
test_label$activity_label = activity_label[test_label$V1,2]
  
label_bind = rbind(train_label,test_label)
dselect = cbind(dselect,"activity_label"= label_bind$activity_label)
 
# -- assign subject to activity 
train_subject = read.table("UCI HAR Dataset/train/subject_train.txt")
test_subject = read.table("UCI HAR Dataset/test/subject_test.txt")
 
label_subject = rbind(train_subject, test_subject)
dselect = cbind(dselect,"subject"= label_subject$V1)

#
# =====================
message("Q5: Creates a second, independent tidy data set with the average of each variable for each activity and each subject. ")

tinydata = aggregate(dselect[1:66], by=list("subject"=dselect$subject,"activity_label"=dselect$activity_label), 
                      FUN=mean, na.rm=TRUE)

# end!