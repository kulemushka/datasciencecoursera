
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

setwd("~/Documents/Experiments_2014/Coursera_R_programing")
###Download a data
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- "getdata-projectfiles-UCI-HAR-Dataset.zip"
download.file(fileUrl, destfile=paste("data", destfile, sep="/"), method="curl")
unzip(paste("data", destfile, sep="/"), exdir="data")
data_dir <- setdiff(dir("data"), destfile)
dateDownloaded <- date()
dateDownloaded
setwd("~/Documents/Experiments_2014/Coursera_R_programing/data")
# 1. Merges the training and the test sets to create one data set.
features <- read.table("./UCI HAR Dataset/features.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=features[,2])
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names=features[,2])
X <- rbind(x_test, x_train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
goalFeatures <- features[grep("(mean|std)\\(", features[,2]),]
mean_and_std <- X[,goalFeatures[,1]]

# 3. Uses descriptive activity names to name the activities in the data set.
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c('activity'))
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c('activity'))
y <- rbind(y_test, y_train)

labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
for (i in 1:nrow(labels)) {
  code <- as.numeric(labels[i, 1])
  name <- as.character(labels[i, 2])
  y[y$activity == code, ] <- name
}

# 4. Appropriately labels the data set with descriptive activity names. 
X_with_labels <- cbind(y, X)
mean_and_std_with_labels <- cbind(y, mean_and_std)

# 5. Creates a second, independent tidy data set with the average of each variable 
#    for each activity and each subject. 
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c('subject'))
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c('subject'))
subject <- rbind(subject_test, subject_train)
averages <- aggregate(X, by = list(activity = y[,1], subject = subject[,1]), mean)

write.csv(averages, file='result.txt', row.names=FALSE)


