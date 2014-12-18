#######################
## DOWNLOADING FILES ##
#######################     

# Download .zip file
if (!file.exists("./Course Project")) {dir.create("./Course Project")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if (!file.exists("./Course Project/getdata-projectfiles-UCI HAR Dataset.zip")) {
     download.file(fileUrl,destfile="./Course Project/getdata-projectfiles-UCI HAR Dataset.zip") }

# Unzip .zip file
if (!file.exists("./Course Project/UCI HAR Dataset")) {
     unzip("./Course Project/getdata-projectfiles-UCI HAR Dataset.zip",exdir="./Course Project") }
unlink(fileUrl)


###################
## READING FILES ##
###################

# activity_labels and features files
activity_labels <- read.table("./Course Project/UCI HAR Dataset/activity_labels.txt",col.names=c("id_activity","activity"))
features <- read.table("./Course Project/UCI HAR Dataset/features.txt",col.names=c("id_feature","feature"))

# Test files
subject_test <- read.table("./Course Project/UCI HAR Dataset/test/subject_test.txt",col.names="subject")
X_test <- read.table("./Course Project/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./Course Project/UCI HAR Dataset/test/y_test.txt",col.names="id_activity")

# Train files
subject_train <- read.table("./Course Project/UCI HAR Dataset/train/subject_train.txt",col.names="subject")
X_train <- read.table("./Course Project/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./Course Project/UCI HAR Dataset/train/y_train.txt",col.names="id_activity")


######################################################################
## 1- Merges the training and the test sets to create one data set. ##
######################################################################

# Concatenating tables
data <- rbind(X_test,X_train)
subject <- rbind(subject_test,subject_train)
activity <- rbind(y_test,y_train)

# Data set variables names
names(data) <- features$feature

# Merging tables
dataset <- cbind(subject,activity,data)


################################################################################################
## 2- Extracts only the measurements on the mean and standard deviation for each measurement. ##
################################################################################################

# Variable names with "mean()" or "std()"
meanStdVars <- names(dataset)[grep("mean\\(\\)|std\\(\\)", names(dataset))]

# Subsetting the data set
selectedNames <- c("subject","id_activity",meanStdVars)
meanStdDataset <- dataset[,selectedNames]

# Cheking subset
#str(meanStdDataset)


################################################################################
## 3- Uses descriptive activity names to name the activities in the data set. ##
################################################################################

# Merging the activity labels to the id of the activities
dataset2 <- merge(activity_labels,meanStdDataset,by.x="id_activity",by.y="id_activity",all=TRUE)


###########################################################################
## 4- Appropriately labels the data set with descriptive variable names. ##
###########################################################################

dataset3 <- dataset2

# prefix t is replaced by "time"
names(dataset3) <- gsub("^t", "time", names(dataset3))

# prefix f is replaced by "frequency"
names(dataset3) <- gsub("^f", "frequency", names(dataset3))

# "Acc" is replaced by "Accelerometer"
names(dataset3) <- gsub("Acc", "Accelerometer", names(dataset3))

# "Gyro" is replaced by "Gyroscope"
names(dataset3) <- gsub("Gyro", "Gyroscope", names(dataset3))

# "Mag" is replaced by "Magnitude"
names(dataset3) <- gsub("Mag", "Magnitude", names(dataset3))

# "BodyBody" is replaced by "Body"
names(dataset3) <- gsub("BodyBody", "Body", names(dataset3))

# Checking
#names(dataset3)


#######################################################################################################################################################
## 5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ##
#######################################################################################################################################################

# Averaging each variable for each activity and each subject
library(plyr)
tidyDataset <- aggregate(. ~ subject + activity, dataset3, mean)

# Ordering the tidy data set by "subject" and "id_activity"
tidyDataset <- tidyDataset[order(tidyDataset$subject,tidyDataset$id_activity),]
tidyDataset

# Exporting the tidy data set
write.table(tidyDataset, "./Course Project/tidyDataset.txt", row.name=FALSE)
write.table(tidyDataset, "./Course Project/tidyDataset.csv", row.name=FALSE)
