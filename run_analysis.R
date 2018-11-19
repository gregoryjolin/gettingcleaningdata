#load dplyr package for future use
library(dplyr)
#read in all the necessary data
features=read.table("./UCI HAR Dataset/features.txt")
activity_labels=read.table("./UCI HAR Dataset/activity_labels.txt")
subject_train=read.table("./UCI HAR Dataset/train/subject_train.txt")
observation_train=read.table("./UCI HAR Dataset/train/X_train.txt")
activity_train=read.table("./UCI HAR Dataset/train/y_train.txt")
subject_test=read.table("./UCI HAR Dataset/test/subject_test.txt")
observation_test=read.table("./UCI HAR Dataset/test/X_test.txt")
activity_test=read.table("./UCI HAR Dataset/test/y_test.txt")
#bind together the training and test data for subjects, observations, and activities
subject_all=rbind(subject_train,subject_test)
observation_all=rbind(observation_train,observation_test)
activity_all=rbind(activity_train,activity_test)
#rename the column names in the observations data based on the features table
colnames(observation_all)=features$V2
#get a list of the columns that have text string "mean" or "std"
meanstdcols=grep("mean|std",features$V2)
#keep only columns that contain "mean" or "std"
observation_all=observation_all[,meanstdcols]
#remove the parentheses from these column names
colnames(observation_all)=gsub("[()]","",colnames(observation_all))
#replace the numbers with activity labels
activity_all=activity_labels[match(activity_all[,1],activity_labels[,1]),2]
#bind everything together into one data frame
alldata=cbind(subject_all,activity_all,observation_all)
#rename the first two columns to "subject" and "activity" for clarity
colnames(alldata)[1:2]=c("subject","activity")
#get the averages of each observation for each subject and activity
averageddata = alldata %>% group_by(subject,activity) %>% summarize_all(mean)
averageddata