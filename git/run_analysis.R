# run_analysis.R
# This script will combine the train and test datasets
# It will prune the data vector from 561 viariables down to the 
# ones that are mean or std related
# It will also give meaning column names and rownames
# finally it will summarize the data by resource and activity

library(data.table)
library(dplyr)

#set working dir based on home dir
home <- Sys.getenv("HOME")
assignment_dir <- paste(home,"/../desktop/datasciencecoursera/Assignment3/UCI HAR Dataset",sep="")
setwd(assignment_dir)

# read features, subjects, activity labels
features <- read.table("features.txt")
subject_train <- read.table("./train/subject_train.txt")
subject_test <- read.table("./test/subject_test.txt")
subject <- rbind(subject_train,subject_test)
colnames(subject) <- c("subject_name")

activity_labels <- read.table("./activity_labels.txt")
# convert activity lables to lower case
activity_labels$V2 <- tolower(activity_labels$V2)

# read train & test observations
f_train <- fread("./train/X_train.txt")
f_test <- fread("./test/X_test.txt")
# combine train & test observations
combined_data <- rbind(f_train,f_test)

# read train & test activity info
f_train_col <- read.table("./train/y_train.txt")
f_test_col <- read.table("./test/y_test.txt")
# combine train & test activities
activity <- rbind(f_train_col,f_test_col)

# identify features that are mean or std related
cols <- lapply(features,function(x){grepl("mean\\(\\)",x)|grepl("std\\(\\)",x)})
cols <- cols$V2

# prune combined data set to columns of interest
combined_data_pruned <- combined_data[,cols,with=FALSE]


# get variable names and tidy them
variables <- factor(features[cols,]$V2)
variables <- gsub("\\(\\)","",variables)
variables <- gsub("-","_",variables)

#set column names based on variable names
colnames(combined_data_pruned) <- levels(as.factor(variables))

# build a vector of friendly activity names
act_names <- as.data.table(lapply(activity,function(x){activity_labels[[2]][x]}))
colnames(act_names) <- c("act_names")


# bind activity names with the observations
act_data <- cbind(act_names,combined_data_pruned)

# bind subject number with the observations
act_data <- cbind(subject,act_data)

# write output table
write.table(act_data,"combined_data.txt")


# build summary data frame using dplyr commands
summary_data <- act_data %>% 
  group_by(subject_name,act_names) %>% 
  summarise_at(vars(-act_names,-subject_name), funs(mean(., na.rm=TRUE)))

# write summary output
write.table(summary_data,"summary_data.txt")
