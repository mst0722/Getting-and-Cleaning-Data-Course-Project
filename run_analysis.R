## Human Activity Recognition Using Smartphones Data Set 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#


# Packages for data tidying data
library(tidyr)
library(dplyr)
library(reshape2)

# Package for fast data aggregation, joins, and fast column modification 
library(data.table)

# Add all the training and test data together
X_train <- read.table("X_train.txt")
X_test <- read.table("X_test.txt")
X_all <- rbind(X_train, X_test)

# Give the columns a descriptive name
features <- read.table("features.txt")
names(X_all) <- features$V2

# Add the subject training and test data together
subject_train <- read.table("subject_train.txt")
subject_test <- read.table("subject_test.txt")
subject_all <- rbind(subject_train, subject_test)

# Assign descriptive activity names for all the activities in the data set on each subject
# Join tables to include all rows
activity_labels <- read.table("activity_labels.txt")
subject_activity <- full_join(subject_all, activity_labels) 

# Create two data frames (1)all the X data and (2)all the subject & activity data.
subject.activity <- data.frame(subject_activity$V1, subject_activity$V2)
all_data <- cbind(as.data.frame(X_all),(subject_activity))

# Combine the training and test data together
y_train <- read.table("y_train.txt")
y_test <- read.table("y_train.txt")
y_all <- rbind(y_train, y_test) 

# Select mean and std measurements and add descriptive labels.
# Bind the results with subject/activity data.  
mean.std <- all_data[,grepl("mean|std", colnames(all_data))]
mean.std.subject.activity <- cbind(as.data.table(mean.std), (subject.activity))

# Create a tidy data set with average of each variable for each activity by each subject
# Export results
tidy <- na.omit(mean.std.subject.activity)
write.table(tidy, row.name=FALSE, "tidy.csv")

# Export other files
write.csv(all_data, "all_data.csv")
write.csv(subject_activity, "subject_activity.csv")
write.csv(all_data, "all_data.csv")

