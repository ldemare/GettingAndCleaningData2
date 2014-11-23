GettingAndCleaningData2
=======================

Course project for Coursera 'Getting and Cleaning Data' class

The source code (run_analysis_v2.R) will create two tidy data sets combining both the training and test data from Samsung accelerometer and gyroscope measurements downloaded from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

To use run_analysis.R, download the script in your current working directory. The script will download the compressed file from the above URL and only extract pertinent files for the analysis in a newly created folder called "data. The output of the script is two text files, "tidyData.txt" and "tidyData_means.txt" in a newly created directory called "analysis. Details about these two files are below:

*tidyData.txt - contains all mean and standard deviation values for each observed activity (walking, walking_upstairs, walking_downstairs, sitting, standing, and laying) by participants (1-30) combining both the training and testing phases

*tidyData_means.txt - average value for each variable by participant and activity
