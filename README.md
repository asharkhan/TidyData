TidyData
========
Introduction
------------
This script expects current working directory to be "UCI HAR Dataset"
Specifically, it contains files activity_labels.txt, features.txt 
and two folders, test and train, along with their sub files as 
extracted from data for this course. 

Script also require data.table package to be installed and loaded.
This can be done by using following two commands:
1. install.packages("data.table")
2. library(data.table)

Step 1
---------
Reads test data (X), adds descriptive column names to it. 
Reads activity data (Y), gives descriptive column name.
Combines the two data sets by binding columns.
Reads subject file, gives descriptive column name to it.
binds the column to prior data to get merged testData.

Step 2
----------
This section does the same steps as section 1 except that its done 
on training set

Step 3
---------
combine training and test data sets into one.

Step 4
---------
Reduces columns in merged set to only include those which have 
mean and std in them. 

Step 5
-----------
Creates tidy data set with the average of each variable for each
activity and each subject.

Step 6
-----------
Now that we have a small tidy data set. Lets replace activity 
label with actual activity string. Also, improve the names of 
columens.

Output
------
Output of this script is a tidy data set of dimensions 180 x 68.
Its stored in R in tidyData variable. Its also written to a file
called tidy-data.txt in current working director. This file can be
read back in R using command: read.table("tidy-data.txt", header = TRUE)
