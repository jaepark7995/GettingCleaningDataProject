### This file contains the code to analyzing the data collected 
### from the accelerometers from the Samsung Galaxy S smartphone

# Load dplyr and data.table
library(dplyr)
library(data.table)

## Assuming you have openned the zipfile and you are in the directory with the "UCI HAR Dataset" folder

# obtain feature names
features <- read.table('./UCI HAR Dataset/features.txt')
features <- as.character(features[,2])

# obtain activity names
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# obtain test data
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test.x <- read.table("UCI HAR Dataset/test/X_test.txt")
test.activity <- read.table("UCI HAR Dataset/test/y_test.txt")
test.data <- data.frame(test.subject, test.activity, test.x)

# obtain training data
train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train.x <- read.table("UCI HAR Dataset/train/X_train.txt")
train.activity <- read.table("UCI HAR Dataset/train/y_train.txt")
train.data <- data.frame(train.subject, train.activity, train.x)

# 1. Merge training and test data into one dataset
data<- rbind(train.data, test.data)
names(data) <- c(c("subject", "code"), features)

# 2. Extract mean and stdev for each measurement
meanstdev.index <- grep('mean|std', features)
meanstdev <- data[,c(1,2,meanstdev.index + 2)]

# 3. use descriptive names to name activities
meanstdev$code <- activities[meanstdev$code, 2]

# 4. label dataset with descriptive variable names
names(meanstdev)[2] <- "activity"
names(meanstdev) <- gsub("[(][)]", "", names(meanstdev))
names(meanstdev) <- gsub("^t", "TimeDomain_", names(meanstdev))
names(meanstdev) <- gsub("^f", "FrequencyDomain.", names(meanstdev))
names(meanstdev) <- gsub("Acc", "Accelerometer", names(meanstdev))
names(meanstdev) <- gsub("mean", "Mean", names(meanstdev))
names(meanstdev) <- gsub("std", "StandardDeviation", names(meanstdev))
names(meanstdev) <- gsub("Gyro", "Gyroscope", names(meanstdev))
names(meanstdev) <- gsub("Mag", "Magnitude", names(meanstdev))
names(meanstdev) <- gsub("Freq", "Frequency", names(meanstdev))

# 5. Tidy data with average of each variable for each activity and subject
finalTidy <- meanstdev %>%
        group_by(subject, activity) %>%
        summarize_all(funs(mean))
write.table(finalTidy, "FinalTidyData.txt", row.name=FALSE)
