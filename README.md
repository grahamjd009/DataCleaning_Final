# DataCleaning_Final
Script and files for Coursera Data Cleaning Final Project

Author: John Graham, grahamjd009
Created: May 29, 2016

Package contents:
* README.md - (this)
* CodeBook.md - description of dataset and its variables 
* run_analysis.R - script as described below

Overview: This is a script written to satisfy the requirements of our final project for Coursera's Data Cleaning class. In it we use various techniques to merge, clean, subset and summarize a dataset collected in a study of the accelerometers from the Samsung Galaxy S smartphone. A full description of that dataset is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

And the original data source is here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# run_analysis.R:

-- Note: As per instructions, script assumes the raw dataset has been downloaded and unzipped in the working directory like so: "./UCI HAR Dataset" 

Steps taken with this script:

* Load the features (aka measurements) and activity labels from their respective files, and add appropriate column names
* Remove innapropriate characters from measurements so that they can be used as column names
* For both test and training data subsets:
  * Load primary data set, corresponding activity labels ("y".csv) and subject labels
  * Add column names, using measurement labels from features.txt to label columns in primary data set
  * Complete dataset by appending activity and subject labels as columns
* Merge test and training subsets into "merge.data" set, combining test and train data
* Remove any columns with duplicate names (to allow for dplyr select later)
* Use dplyr to subset the merged data, keeping only our labels + the mean and std measurements for each smartphone feature
* re-order columns to bring all labels/factors up front
* Melt data into a new dataset using tidyr gather to allow us to easily:
  * group by subject.id and activity.type
  * Calculate average(mean) of the two entries (test+train) for each subject.id,activty.type and measurement
* Spread the data into a final dataset, returning each measurement to its own column
* Cleans up all but the two necessary outputs: merge.data and final.data

run_analysis outputs:

* merge.data: A tidy dataset with 10,299 observations of 69 variables that is a merge of all test and training data with all appropriate labels, removing any measurement that is not either a mean or a standard deviation. 

* final.data: a tidy dataset with 180 observations of 68 variables, with each observation showing the average of a subject's test and training data for every activity across every applicable measure.






