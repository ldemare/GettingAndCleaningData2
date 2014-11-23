GettingAndCleaningData2
=======================

Course project for Coursera 'Getting and Cleaning Data' class

The source code (run_analysis_v2.R) will create two tidy data sets combining both the training and test data from Samsung accelerometer and gyroscope measurements downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

To use run_analysis.R, download in script in your current working directory. This directory must also contain the UCI HAR Dataset folder, which can be downloaded from the above url.

The script will create a folder called "analysis" and deposit two tidy datasets within:

tidyData.txt - contains all mean and standard deviation values for each observed activity (walking, walking_upstairs, walking_downstairs, sitting, standing, and laying) by participants (1-30) combining both the training and testing phases

tidyData_means.txt - average value for each variable by participant and activity
