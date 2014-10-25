CodeBook.md
=============================

Input
-----
A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Transformations 
---------------
Extensive descriptions of the transformation can be found in the comments of the file run_analysis.R

Output
------
tidy_data_set.txt consisting of 5 variables
activity_id: unique identifier of the activity 
activity_name: descriptive name of the activity
subject_id: unique identifier of the person measured
measurement: type of measurement
mean_of_measurement: mean value of the measurement
