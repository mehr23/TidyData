# Peer Graded Assignement: Tidy Data
# ===== READING THE DATA FROM FILES =========
#- 'features.txt': List of all features.
#- 'activity_labels.txt': Links the class labels with their activity name.
features <- read.table(file = "./UCI HAR Dataset/features.txt")
activity_labels <- read.table(file = "./UCI HAR Dataset/activity_labels.txt")

#- 'train/X_train.txt': Training set.
#- 'train/y_train.txt': Training labels.
#- 'test/X_test.txt': Test set.
#- 'test/y_test.txt': Test labels.
X_train <- read.table(file = "./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table(file = "./UCI HAR Dataset/train/y_train.txt")
X_test <- read.table(file = "./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table(file = "./UCI HAR Dataset/test/y_test.txt")

#- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. 
#   Its range is from 1 to 30.
subject_train <- read.table(file = "./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table(file = "./UCI HAR Dataset/test/subject_test.txt")


#- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer
#   X axis in standard gravity units 'g'. Every row shows a 128 element vector. 
#   The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
#- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
#- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. 
#   The units are radians/second.

# Train data reading
total_acc_x_train <- read.table(file = "./UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
total_acc_y_train <- read.table(file = "./UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
total_acc_z_train <- read.table(file = "./UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")

body_acc_x_train <- read.table(file = "./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
body_acc_y_train <- read.table(file = "./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
body_acc_z_train <- read.table(file = "./UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")

body_gyro_x_train <- read.table(file = "./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
body_gyro_y_train <- read.table(file = "./UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
body_gyro_z_train <- read.table(file = "./UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")


# Test data reading
total_acc_x_test <- read.table(file = "./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
total_acc_y_test <- read.table(file = "./UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
total_acc_z_test <- read.table(file = "./UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")

body_acc_x_test <- read.table(file = "./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
body_acc_y_test <- read.table(file = "./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
body_acc_z_test <- read.table(file = "./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")

body_gyro_x_test <- read.table(file = "./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
body_gyro_y_test <- read.table(file = "./UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
body_gyro_z_test <- read.table(file = "./UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")

# ============ Working on the dataset:=====================
# 1. Merges the training and the test sets to create one data set.
library(dplyr)
X_total <- rbind(X_train, X_test)
y_total <- rbind(y_train, y_test)
subject_total <- rbind(subject_train, subject_test)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 4.a Appropriately labels the data set with descriptive variable names.
var_names <- features[,2]
names(X_total) <- var_names


# 3. Uses descriptive activity names to name the activities in the data set
y_total_factor <- factor(y_total$V1, ordered = TRUE)
levels(y_total_factor) <- activity_labels[,2]


Total <- cbind(y_total_factor, X_total)

# 4.b Appropriately labels the data set with descriptive variable names.

vars_std <- grepl("std()", var_names)
vars_mean <- grepl("mean()", var_names)

selectedData <- cbind(y_total_factor, X_total[,(vars_mean | vars_std)])

new_names <- names(selectedData)
new_names <- gsub("tBody","time Body", new_names)
new_names <- gsub("fBody","Fourier Body", new_names)
new_names <- gsub("-"," ", new_names)
new_names <- gsub("y_total_factor","activity", new_names)
new_names <- gsub("\\(\\)","", new_names)

names(selectedData) <- new_names



# head(X_total[,(vars_mean | vars_std)])
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
str(subject_total)
subject_total_factor <- factor(subject_total$V1, ordered = TRUE)
cleanData <- cbind(subject_total_factor, selectedData)
names(cleanData) <- c("subject", new_names)
str(cleanData)

# Here is the list containg the avreages of variables for each activity and each subject:
meanList <- sapply(cleanData[,3:ncol(cleanData)], 
                   function(x) tapply(x, 
                                      INDEX = interaction(cleanData$activity, cleanData$subject), 
                                      FUN = mean, simplify = TRUE))


