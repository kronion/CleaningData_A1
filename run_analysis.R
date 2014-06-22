## run_analysis.R
## This script assumes that you have downloaded the zip file found at
## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## and put it working directory with the name `data.zip`.

require(plyr)

dataFiles <- unzip('data.zip')

# Feature vectors
x_train <- read.csv(dataFiles[27], FALSE, "")
x_test <- read.csv(dataFiles[15], FALSE, "")
x <- rbind(x_train, x_test)

# Activity labels
y_train <- read.table(dataFiles[28])
y_test <- read.table(dataFiles[16])
y <- rbind(y_train, y_test)

# Subjects
subject_train <- read.table(dataFiles[26])
subject_test <- read.table(dataFiles[14])
subjects <- rbind(subject_train, subject_test)

# Extract only the columns corresponding to mean and std values
meansAndStds <- cbind(x[1:6], x[41:46], x[81:86], x[121:126], x[161:166],
                      x[201:202], x[214:215], x[227:228], x[240:241], x[253:254],
                      x[266:271], x[294:296], x[345:350], x[373:375], x[424:429],
                      x[452:454], x[503:504], x[513], x[516:517], x[526],
                      x[529:530], x[539], x[542:543], x[552])

# Replace activities with factors
labels <- read.table(dataFiles[1])
activities <- factor(y[[1]], labels=c("LAYING", "SITTING", "STANDING", "WALKING",
                                      "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS"))

# Combine columns and add titles
allData <- cbind(meansAndStds, activities, subjects)
colnames(allData) <- c("tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z",
                       "tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z)",
                       "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y",
                       "tGravityAcc-mean()-Z", "tGravityAcc-std()-X",
                       "tGravityAcc-std()-Y", "tGravityAcc-std()-Z",
                       "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y",
                       "tBodyAccJerk-mean()-Z", "tBodyAccJerk-std()-X",
                       "tBodyAccJerk-std()-Y", "tBodyAccJerk-std()-Z",
                       "tBodyGyro-mean()-X", "tBodyGyro-mean()-Y",
                       "tBodyGyro-mean()-Z", "tBodyGyro-std()-X",
                       "tBodyGyro-std()-Y", "tBodyGyro-std()-Z",
                       "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y",
                       "tBodyGyroJerk-mean()-Z", "tBodyGyroJerk-std()-X",
                       "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z",
                       "tBodyAccMag-mean()", "tBodyAccMag-std()",
                       "tGravityAccMag-mean()", "tGravityAccMag-std()",
                       "tBodyAccJerkMag-mean()", "tBodyAccJerkMag-std()",
                       "tBodyGyroMag-mean()", "tBodyGyroMag-std()",
                       "tBodyGyroJerkMag-mean()", "tBodyGyroJerkMag-std()",
                       "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z",
                       "fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z",
                       "fBodyAcc-meanFreq()-X", "fBodyAcc-meanFreq()-Y",
                       "fBodyAcc-meanFreq()-Z", "fBodyAccJerk-mean()-X",
                       "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z",
                       "fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y",
                       "fBodyAccJerk-std()-Z", "fBodyAccJerk-meanFreq()-X",
                       "fBodyAccJerk-meanFreq()-Y", "fBodyAccJerk-meanFreq()-Z",
                       "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z",
                       "fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z",
                       "452 fBodyGyro-meanFreq()-X", "fBodyGyro-meanFreq()-Y",
                       "fBodyGyro-meanFreq()-Z", "fBodyAccMag-mean()",
                       "fBodyAccMag-std()", "fBodyAccMag-meanFreq()",
                       "fBodyBodyAccJerkMag-mean()", "fBodyBodyAccJerkMag-std()",
                       "fBodyBodyAccJerkMag-meanFreq()", "fBodyBodyGyroMag-mean()",
                       "fBodyBodyGyroMag-std()", "fBodyBodyGyroMag-meanFreq()",
                       "fBodyBodyGyroJerkMag-mean()", "fBodyBodyGyroJerkMag-std()",
                       "fBodyBodyGyroJerkMag-meanFreq()", "activity", "subject")

# Get the mean of each variable for each activity and subject
means <- ddply(allData, .(activity, subject), function(y) sapply(y,mean))

# Replace the activity column, which is destroyed in the previous operation
means$activity <- rep(c("LAYING", "SITTING", "STANDING", "WALKING",
                         "WALKING_DOWNSTAIRS", "WALKING_UPSTAIRS"), each=30)

# Save
write.table(means, file='means.txt')