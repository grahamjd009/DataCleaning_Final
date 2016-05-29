## preload required libraries 
library(dplyr)
library(tidyr)

# create data directory if doesn't already exist

if(!file.exists("./data"))
{dir.create("./data")}

# download dataset and extract to data directory

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,"./data/sp_data.zip")
unzip("./data/sp_data.zip",exdir = "./data")

# load measure and activity labels, add column names and remove any unfriendly characters 

measures <- read.table("./data/UCI HAR Dataset/features.txt")
names(measures) <- (c("measure.id","measure.type"))
measures$measure.type <- make.names(measures$measure.type)
#
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
names(activities) <- (c("activity.id","activity.type"))

# Load training and test subsets including activity and subject ids

train.raw <- read.table("./data/UCI HAR Dataset/train/x_train.txt")
train.activities <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
train.subjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
# 
test.raw <- read.table("./data/UCI HAR Dataset/test/x_test.txt")
test.activities <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
test.subjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

# Add colnames to subsets
names(train.raw) <- measures[,"measure.type"]
names(train.activities) <- ("activity.id")
names(train.subjects) <- ("subject.id")
#
names(test.raw) <- measures[,"measure.type"]
names(test.subjects) <- ("subject.id")
names(test.activities) <- ("activity.id")

# Complete each data subset by appending activity and subject labels
train.data <- cbind(train.subjects["subject.id"], train.activities["activity.id"],record.type="train",train.raw)
test.data <- cbind(test.subjects["subject.id"], test.activities["activity.id"],record.type = "test",test.raw)

# merge the train and test data into one dataset, and remove columns with duplicated names
merge.data <- rbind(train.data,test.data)
merge.data <- merge.data[,!duplicated(colnames(merge.data))]

# subset keeping only mean and std measurements, then add activity descriptions and re-order columns, all factors to front
merge.data <- 
  select(merge.data, subject.id, activity.id, record.type, matches("mean()|std()",ignore.case = FALSE),-matches("meanFreq()")) %>%
  merge(activities,merge.data,by.x = "activity.id",by.y = "activity.id") %>%
  select(subject.id,activity.type,record.type,tBodyAcc.mean...X:fBodyBodyGyroJerkMag.std..)  

# melt merged dataset to allow for easier grouping and mean calc
melt.data <- gather(merge.data,key = measurement, value = val,tBodyAcc.mean...X:fBodyBodyGyroJerkMag.std..)
    
# group melted data by subject and activity, then calculate mean
group.data <- 
    group_by(melt.data,subject.id,activity.type, measurement) %>%
    summarize(average = mean(val))

# re-spread for preferred tidy set display
final.data <- spread(group.data,measurement,average)

## clean up un-needed variables from workspace
 rm(list=setdiff(ls(),c("merge.data","final.data")))
