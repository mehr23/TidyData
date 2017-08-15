# Tidy Data Assignment

## Repo files
In this repo the following files exist:
1. "README.md" : contains the information about the files and how the code (.R) file works.
2. "run_analysis.R" : R code that creates a tidy dataset containing the average values for the dataset provided for 
  Coursera's tidy data assignement.
3. "codebook.md" : The code book explaining the dataset's variables

## Descriptions
This repo contains the project for coursera Tidy Data course assignment.

The code "run_analysis.R" reads the data files in the working directory : "./UCI HAR Dataset/"
Then it creats the datasets in R from the read data.

### 1. Merging the Train and Test data

X_total: merges train and test data for X
y_total: merges train and test data for y
subject_total: merges train and test data for 30 different subjects

### 2. Variable Names
From the features file the Variable Names for the data set is created.

### 3. Man and standard deviation
Man and standard deviation for each measurement are then extracted.\

### 4. Activity Names
Activity names are then assigned to each level of activity vector.

### 5. New dataset for Averages over subjects and activities
New more readable names have been used for the variables.
mean of each variable for the activities and subjects are made.


