# GettingCleaningDataCourseProject
Public repo for the Getting and Cleaning Data course project on Coursera. This repository contains three deliverables:

## run_analysis.R
Code file containing the (commented) download link for the raw data, and all code required for the data preparation steps. In-line comments describe the steps taken to produce the result. They follow roughly the following steps:

0. Download the files and give the columns proper names

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## aggrData.txt
Resulting output file, containing the averages of all mean and standard deviation measures in the original dataset, grouped by subject and activity. The columns are the subject identifier column, and all mean and std columns from the original dataset.

## Codebook.MD
Describes the dataset, and lists the variables used to group by, and containing the actual measures.

