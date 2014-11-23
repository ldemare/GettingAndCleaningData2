library(data.table)
library(dplyr)
library(tidyr)

#create directory named "data" for storing downloaded data:
if (!file.exists("data")) {dir.create("data")}

#download (zipped) directory:
dirUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dirUrl, "../data", method = 'curl')

#uncompress files that will will use in analysis:
files <- c("UCI HAR Dataset/train/subject_train.txt", "UCI HAR Dataset/train/X_train.txt","UCI HAR Dataset/train/y_train.txt", "UCI HAR Dataset/test/subject_test.txt", "UCI HAR Dataset/test/X_test.txt", "UCI HAR Dataset/test/y_test.txt", "UCI HAR Dataset/activity_labels.txt")
unzip("../GettingAndCleaningData/data//data", files = files)

#create directory named "analysis" to write tidy data:
if (!file.exists("analysis")) {dir.create("analysis")}

#get feature names (will be column names for data.table):
features <-read.table("../UCI HAR Dataset//features.txt")
colNames <-data.table(features$V2)

#get activity descriptors (this will be matched to numeric activity labels in training/test data set) 
activityLabels <- read.table("../UCI HAR Dataset/activity_labels.txt", quote = "")
DT_activityLabels<- data.table(activityLabels)
setattr(DT_activityLabels, 'names', c("Numerical_activity_label", "Activity_descriptor"))

#read in training and testing measurement vectors:
training_measurements <-read.table("../UCI HAR Dataset/train//X_train.txt", quote="")
testing_measurements <-read.table("../UCI HAR Dataset/test/X_test.txt", quote="")

#get participant IDs for training and test data:
tmp1 <- read.table("../UCI HAR Dataset//train/subject_train.txt", quote = "")
tmp2 <- read.table("../UCI HAR Dataset/test//subject_test.txt", quote = "")
participant_ID <- rbind(tmp1, tmp2)

#get numerical activity descriptors for training and test data:
tmp3 <- read.table("../UCI HAR Dataset/train//y_train.txt", quote = "")
tmp4 <- read.table("../UCI HAR Dataset/test//y_test.txt", quote = "")
activity <- rbind(tmp3, tmp4)

#create data table with training/testing measurement data:
DT <- data.table(rbind(training_measurements, testing_measurements))

#add column names to data table:
setattr(DT, 'names', as.character(t(colNames)))

#select mean and standard deviation calculations from data table:
DT_mean_stdev <- DT[, grep("*mean*|*std*", names(DT)), with=FALSE]

#add columns to data table with participant ID and activity descriptor        
DT_mean_stdev[,"Participant_id":=participant_ID] 
DT_mean_stdev[,"Numerical_activity_label":=activity]    

#merge data table with activity descriptors by numerical activity labels
DT_withActivity <-merge(DT_mean_stdev, DT_activityLabels, by = "Numerical_activity_label")
DT_withActivity <- DT_withActivity[,2:83, with = FALSE]

#write out tidy data set to Analysis folder
setwd("./analysis/")
write.table(DT_withActivity, file = "./tidyData.txt", row.names=FALSE)

#get mean measurements for each participant, activity, and variable (using dplyr and tidyr)
DT_withActivity %>% 
        select(-Numerical_label) %>% 
        gather(variable, count, -c(Participant_id, Activity_descriptor)) %>% 
        group_by(Activity_descriptor, Participant_id, variable) %>% 
        summarize(mean = mean(count)) %>% 
        
#print out mean variables to second file, tidyData_means.txt, in Analysis folder        
        write.table(file = "../analysis/tidy_data_means.txt", row.names= FALSE)
