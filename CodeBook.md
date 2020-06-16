# Getting and Cleaning Data Course Project
## Jae Myung Park

This "GettingCleaningDataProject" repository contains instructions analyzing the Human Activity Recognition Using Smartphones Data Set. This data set can be obtained from this link: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Files
This "README.md" file contains the overall concept of the project and Code Book for the analysis.

"UCI HAR Dataset" folder contains the testing and training human activity recognition data text files obtained from the link above.

"run_analysis.R"" file performs the data preparation and data cleaning using the "UCI HAR Dataset" text files as the input. The output of this R script is the "FinalTidyData.txt" file.

"FinalTidyData.txt" file is the output of the "run_analysis.R" file that contains the average of each variable for each activity and subject.

### Code Book
This Code Book describes the variables and method in analyzing the human activity recognition data set. There are the data importing step and five additional steps for this analysis project.

**1. Data Importing** First, a list of feature names is imported from the "features.txt" file into a "features" variable. A matrix of activities and their corresponding codes are imported from the "activity_labels.txt" file into a "activities" variable. 

Then, the test subject, measurements, and activity data records are imported into variables "test.subject", "test.x", "test.activity" respectively. These are combined to create "test.data" dataframe. The same is done for the train subject, measurements, and activity data records with the variables "train.subject", "train.x", "train.activity", and "train.data". 

**2. Merge training and testing data into one set** Here, the rbind() function is used to merge "test.data" and "train.data" dataframes.

**3. Extract Mean and Standard Deviation for each measurement** Here, the grep() function finds the location of the mean and standard deviation features and saves its data in the dataframe "meanstdev"

**4. Use descriptive names to name activities** Here, normal subsetting technique is used to do so.

**5. Label dataset with descriptive variable names** Here, the gsub() function and a number of regular expressions are used to relabel the dataset features with descriptive names.

**6. Tidy data with average of each variable for each activity and subject** In this final step, dplyr functions group_by() and summarize_all() are used to group the "meanstdev" dataframe by activity and subject, then find the mean with these groups. The write.table() function is used to output a "FinalTidyData.txt" file.