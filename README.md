# Getting and Cleaning Data Course Project

This README is for describing the course project for the Getting and Cleaning Data course.

## run_analysis.R

This script will read in all the relevant data sets. It will then bind together the training and test data sets, rename the columns for clarity, and include only the mean and standard deviation observation columns. Finally, the script will return a data frame which gives the averages of each observation for each subject and activity.