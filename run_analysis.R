library(dplyr)
library(reshape2)

## Reads and Downloads the data

filename <- "Assessment on Data Cleaning.zip"

## Checks to see if we've already downloaded the file
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename, method="curl")
}  

## Checking if the folder for our file exists prior to unzipping
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}

## Read the various required data into data frames
## Read the feature file for the column names of the X_test and X_train files
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("i", "functions"))

## Read the activity label file to get labels for y_test and y_train data
activity_label <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("Label Number", "Activity"))


## Test Variables
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "Activity")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")

## Train Variables
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "Activity")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")


## Merge the training and test sets
x_datacombined <- rbind(x_train, x_test)
y_datacombined <- rbind(y_train, y_test)
subject_datacombined <- rbind(subject_train, subject_test)
alldatacombined <- cbind(subject_datacombined, y_datacombined, x_datacombined)

## Calls for the data columns we need for the assignment, those with the mean and std
meandata <- alldatacombined[,grepl("mean", names(alldatacombined), ignore.case = TRUE)]
stddata <- alldatacombined[,grepl("std", names(alldatacombined), ignore.case = TRUE)]

## Begin combined our data into one singular tidy set
tidyset <- cbind(subject_datacombined, y_datacombined, meandata, stddata)

## Use our activity_label data to give more detailed information on activity
tidyset$Activity <- activity_label[tidyset$Activity, 2]

## Look at names in our set to see how they can be improved
names(tidyset)

## Now we start to relabel our columns with more descriptive labels
names(tidyset) <- gsub("Acc", " Acceleration ", names(tidyset)) ## From README of data
names(tidyset) <- gsub("Gyro", " Gyroscope ", names(tidyset)) ## From README of data
names(tidyset) <- gsub("BodyBody", " Body ", names(tidyset)) ## Fix possible type
names(tidyset) <- gsub("Mag", " Magnitude ", names(tidyset))

## README tells us that starting with t means time variable and f means frequency
names(tidyset) <- gsub("^t", "TimeBased ", names(tidyset))
names(tidyset) <- gsub("^f", "FrequencyBased " , names(tidyset))

## Remove Shorthand of std, capitalize mean for neatness
names(tidyset) <- gsub("Jerk", "Jerk ", names(tidyset))
names(tidyset) <- gsub("std", "Standard Deviation", names(tidyset))
names(tidyset) <- gsub("mean", "Mean", names(tidyset))
names(tidyset) <- gsub("MeanFreq", "Mean Frequency", names(tidyset))
names(tidyset) <- gsub("\\.", "", names(tidyset))
names(tidyset) <- gsub("X$", " of X" , names(tidyset))
names(tidyset) <- gsub("Y$", " of Y" , names(tidyset))
names(tidyset) <- gsub("Z$", " of Z" , names(tidyset))
names(tidyset) <- gsub("anglet", "Anglet ", names(tidyset))
names(tidyset) <- gsub("gravity", " Gravity ", names(tidyset))
names(tidyset) <- gsub("angle", "Angle ", names(tidyset))
## Give a new check of column names
names(tidyset)

FinalData <- tidyset %>%
    group_by(Subject, Activity) %>%
    summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)

