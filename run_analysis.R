## set working directory to the directory containing the extracted data
setwd("C:/Users/QBIC/Documents/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset")

## read the meta data
features   <- read.table("features.txt",col.names=c("column_id","column_name"))
act_labels <- read.table("activity_labels.txt",col.names=c("activity_id","activity_name"))
# add the subselection column to the features data frame
features$mean_std <- grepl("*mean*|*std*",features$column_name,TRUE)

## training data
# read the training data applying the appropriate column_names
x.train <- read.table("train/X_train.txt",col.names=features[,2])
# subset the relevant columns
x.train <- x.train[,features$mean_std]
y.train <- read.table("train/Y_train.txt",col.names="activity_id")
subject.train <- read.table("train/subject_train.txt",col.names="subject_id")

# combine the separate data set into one large set and cleanup other data to free memory
train <- cbind(subject.train,y.train,x.train)
rm(x.train)
rm(y.train)
rm(subject.train)

## test data
# read the test data applying the appropriate column_names
x.test <- read.table("test/X_test.txt",col.names=features[,2])
# subset the relevant columns
x.test <- x.test[,features$mean_std]
y.test <- read.table("test/Y_test.txt",col.names="activity_id")
subject.test <- read.table("test/subject_test.txt",col.names="subject_id")

# combine the separate data set into one large set and cleanup other data to free memory
test <- cbind(subject.test,y.test,x.test)
rm(x.test)
rm(y.test)
rm(subject.test)

## combine the training and the test data and cleanup other data to free memory
fulldata <- rbind(train,test)
rm(train)
rm(test)

## add the activity names, since act_id is the only matching column name no conditions specified
fulldata <- merge(act_labels,fulldata)

## Load library dplyr and reshape for use
library(dplyr)
library(reshape2)

## Prepare data for dlyr by converting it to factors
fulldata$activity_id   <- as.factor(fulldata$activity_id)
fulldata$activity_name <- as.factor(fulldata$activity_name)
fulldata$subject_id    <- as.factor(fulldata$subject_id)

## Melt the data so all measurements are set to rows
fdm <- melt(fulldata)

## Use group by on all variables and then summarize mean
fdm <- group_by(fdm,activity_id,activity_name,subject_id,variable)
fds <- summarize(fdm,mean=mean(value))

## Set usefull fieldnames
names(fds) <- c("activity_id","activity_name","subject_id","measurement","mean_of_measurement")

## Write to output
write.table(fds, file="tidy_data_set.txt", row.names=FALSE)


