datasciencecoursera
===================

Data science track: "Getting and Cleaning Data": Course project.

R script (run_analysis.R) does the following:
1. Downloads UCI HAR dataset into ./data directory
2. Decompresses the data and notes the time and date of the download
3. Merges the training and the test sets to create one data set.
4. Extracts only the measurements on the mean and standard deviation for each measurement. 
5. Uses descriptive activity names to name the activities in the data set
6. Appropriately labels the data set with descriptive variable names. 
7. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
8. Writes tidy dataset in the csv file (results.txt) 