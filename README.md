CleaningData
============

Course Project for the Coursera "Getting and Cleaning Data" Course


This repo contains the R script, ouput data, and readme file for the course project.

The R scprit requires the UCI HAR Data set to be unzipped.  The scrip should be passed a string with the unzipped directory path from the working directory location.  If the UCI HAR data is in the same location as the working directory, no information is required to run the script.

The R script executes the 5 required steps from the assignment however not in sequence.  The script first reads the "features" file which holds the titles of the x-variables.  The subject test file and the y-test files are also read at this time.  The variable names from "features" are then assigned to the table of 561 x-variables.

Looping through each row, the y-test is checked and assigned to a holder variable.  A place-holder row is created to hold first the subject ID (1-30), the verbalized name of the activity, then each of the 561 variable tests.

The same process is then done for the train data, repeating the same steps, creating a separate data frame.

Following the creation of the two data frames, they are added togehter using the rbind function.  The total combined informaiton is then written to a text file, to preserve the total combined data.

The total combined data frame is then processed by the aggregate function to summarize the multiple observations.  Processed by both subject and activity, the funciton returns the mean of ever observation of each variable.

Per the instructions, only columns containing mean or standard deviation values are relavent, and the grep function is leveraged to remove all unecessary columns.

Following the processing of the data, proper column names are restored to the subject and activity columns.

The final summary file is then written to a text file, comma delimmited.
