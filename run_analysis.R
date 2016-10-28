# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


### Preparation

setwd("~/datasciencecoursera/Data Cleaning/Week 4")
library(dplyr)

### 0. Properly read the various source files

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "Dataset.zip")
unzip("Dataset.zip")


X_train <- tbl_df(read.table("UCI HAR Dataset/train/X_train.txt", quote="\"", comment.char=""))
y_train <- tbl_df(read.table("UCI HAR Dataset/train/y_train.txt", quote="\"", comment.char=""))
subject_train <- tbl_df(read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"", comment.char=""))

X_test <- tbl_df(read.table("UCI HAR Dataset/test/X_test.txt", quote="\"", comment.char=""))
y_test <- tbl_df(read.table("UCI HAR Dataset/test/y_test.txt", quote="\"", comment.char=""))
subject_test <- tbl_df(read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"", comment.char=""))

features <- tbl_df(read.table("UCI HAR Dataset/features.txt", quote="\"", comment.char=""))
activities <- tbl_df(read.table("UCI HAR Dataset/activity_labels.txt", quote="\"", comment.char=""))

# Rename columns train data

y_train <- rename(y_train, activity = V1)
subject_train <- rename(subject_train, subject = V1)
names(X_train) <- features$V2

# Rename columns test data

y_test <- rename(y_test, activity = V1)
subject_test <- rename(subject_test, subject = V1)
names(X_test) <- features$V2

### 1. Merge the training and the test sets to create one data set

# Create one training set
train <- bind_cols(subject_train, X_train) %>% 
  bind_cols(y_train)

# Create one test set
test <- bind_cols(subject_test, X_test) %>% 
  bind_cols(y_test)

# Create a combined set from train and test
allData <- bind_rows(train, test)


### 2. Extract only the measurements on the mean and standard deviation for each measurement (also keep subject and activity)
# Use select() to select only the relevant columns

filteredData <- select(allData, subject, contains("mean()"), contains("std()"), activity)

### 3. Use descriptive activity names to name the activities in the data set
# Join the text field from activity_labels.txt to the data

filteredData <- left_join(filteredData, rename(activities, activity=V1, activity_text = V2), by="activity") 

### 4. Appropriately label the data set with descriptive variable names

# Remove unnecessary () from variable names
names(filteredData) <- gsub("\\(\\)","", names(filteredData))

# I decided to keep the capitalisation for readability of variable names

### 5. From the set at step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

aggrData <- filteredData %>%                          # Start with the filteredData df
  select(-activity) %>%                               # Drop the numeric activity column
  group_by(subject, activity_text) %>%                # Group by subject and activity_text
  summarise_each(funs(mean))                          # Use summarise_each to apply mean to each column

write.table(aggrData, "aggrData.txt", row.names=FALSE)
