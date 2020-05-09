# Code Book

## Variable Descriptions
features - this is the features.txt file, used for column labeling
activity_label - this is the activity_labels.txt file. it is used for replacing the activity coding of 1-5 with descriptive labels
x_test, x_train, y_test, y_train, subject_test, subject_train - these all contain the data from the downloaded .zip and their corresponding .txt file

x_datacombined - combines the test and train data of the x_test and x_train data
y_datacombined - combines the test and train data of the y_test and y_train data
subject_datacombined - combined the test and train data of the subject_test and subject_train data

alldatacombined - combines the subject_datacombined, y_datacombined, and x_datacombined data in that order

meandata - collects the columns from alldatacombined which have to do with mean measurements
stddata - collects the columns from alldatacombined which have to do with standard deviation measurements

tidyset - combineds subject_datacombined, y_datacombined, meandata, and stddata in that order

FinalData - summary of tidy set taking means of each variable for each activity and subject. It was then grouped by those respectively.
