==================================================================
Run analysis - Coursera project for getting and cleaning data
Version 1.0
==================================================================

The cleaning was conduded as follows:
==================================================================

Use the samsung galaxy data provided here 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script run_analysis.R needs to be run to extract the data from these files and turn it into clean data. 
Note: uncomment the download files section of the script the first time this is run.

The R script does the following when run:
The raw data set are to be loaded onto a local drive first.
From the raw data sets, the training and the test sets are extracted and merged to create one data set.
The single data set is then limited to only the the measurements with mean and standard deviation. 
Finally the means are taken from the resulting dataset.
The final output is delivered into a clean text file


The analysis includes the following files:
=========================================

- 'README.md'

- run_analysis.R

- codebook.md

- run_analysis.txt

