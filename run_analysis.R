## R script for course project of "Getting and Cleaning Data" ##

## Script expects current working directory to be "UCI HAR Dataset"
## Specifically, it contains files activity_labels.txt, features.txt 
## and two folders, test and train, along with their sub files as 
## extracted from data for this course. 
##
## Script also require data.table package to be installed and loaded.
## This can be done by using following two commands:
## 1. install.packages("data.table")
## 2. library(data.table)

####################################################################
## SECTION 1
#  Reads test data (X), adds descriptive column names to it. 
#  Reads activity data (Y), gives descriptive column name.
#  Combines the two data sets by binding columns.
#  Reads subject file, gives descriptive column name to it.
#  binds the column to prior data to get merged testData.

x <- data.table(read.table(".\\test\\X_test.txt")) # read measurements.
colNames <- read.table(".\\features.txt") # read feature names
setnames(x, names(x), as.vector(colNames[,2])) # give descriptive column names.

activity <- read.table(".\\test\\y_test.txt") # read label for activity of the subject at measurement.
names(activity) <- c("Activity") # give descriptive name

merged.test <- cbind(activity, x) # add this column to first data set.

subject <- read.table(".\\test\\subject_test.txt") # read label for subject who sent these measurements.
names(subject) <- c("Subject") # give descriptive name

merged.test <- cbind(subject, merged.test) # add this column to merged data set.


####################################################################
## SECTION 2
#  This section does the same steps as section 1 except that its done 
#  on training set.

x <- data.table(read.table(".\\train\\X_train.txt")) # read measurements.
setnames(x, names(x), as.vector(colNames[,2]))  # give descriptive column names and read earlier in section 1.

activity <- read.table(".\\train\\y_train.txt") # read label for activity of the subject at measurement.
names(activity) <- c("Activity") # give descriptive name

merged.train <- cbind(activity, x) # add this column to first data set.

subject <- read.table(".\\train\\subject_train.txt") # read label for subject who sent these measurements.
names(subject) <- c("Subject") # give descriptive name

merged.train <- cbind(subject, merged.train) # add this column to merged data set.


####################################################################
## SECTION 3
# combine training and test data sets into one.

merged <- rbind(merged.test, merged.train)

# Remove not needed variables to reduce memory consumptionVie
rm(merged.test)
rm(merged.train)
rm(colNames)
rm(activity)
rm(subject)
rm(x)


####################################################################
## SECTION 4
#  Reduces columns in merged set to only include those which have 
#  mean and std in them. 

reduced <- merged[, c(1, 2)] # get subject and activity columns
reduced <- cbind(reduced, merged[, grep("-mean[^F]|-std", names(merged))]) # doesn't include meanFrequency


####################################################################
## SECTION 5
#  Creates tidy data set with the average of each variable for each
#  activity and each subject.

tidyData <- aggregate(reduced, by = list(reduced$Activity, reduced$Subject), FUN = mean, na.rm = TRUE)
tidyData <- tidyData[, 3:70]  # remove extra columns not needed.

# Remove not needed variables to reduce memory consumptionVie
rm(merged)
rm(reduced)


####################################################################
## SECTION 6
#  Now that we have a small tidy data set. Lets replace activity 
#  label with actual activity string. Also, improve the names of 
#  columens.

aLabels <- read.table("activity_labels.txt") # read activity labels.
# replace activity labels with english activity string. 
tidyData$Activity <- factor(tidyData$Activity, labels = aLabels[,2])

write.table(tidyData, "tidy-data.txt", row.names = FALSE) # write it to a file. 

rm(aLabels)

print("tidy-data.txt file has been written to current working directory.") 
