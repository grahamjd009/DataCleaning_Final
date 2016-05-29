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

1) Load the features (aka measurements) and activity labels from their respective files, and add appropriate column names
2) Remove innapropriate characters from measurements so that they can be used as column names
3) Load test and 

