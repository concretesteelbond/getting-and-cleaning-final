 run_analysis.R
Peer Reviewed Assessment: Getting and Cleaning Data Course
The steps below are performed in run_analysis.R

1. Reads Zip Files, extracts test and training data as well as column names, then merges test and training data  
2. Extracts measurements of mean and standard deviation (done by looking for patterns in column names)   
3. Changes the generic activity codes to descriptive activity names   
4. Update variable names to be easier to read and more descriptive   
5. Finally, a new data set is created with the averages of each variable for each activity and subject is created.
6. This new data set is then written into a txt file.
