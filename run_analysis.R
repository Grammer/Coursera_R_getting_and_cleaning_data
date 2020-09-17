#install.packages("data.table")
#install.packages("reshape2")
#install.packages("plyr")

#install packages when needed, download file and unzip dataset
require("data.table")
require("reshape2")
require("plyr")

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
unzip(zipfile="./data/Dataset.zip",exdir="./data")

#get data from txts
activity_labels <- read.table("data/UCI HAR Dataset/activity_labels.txt")
subject_test <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt")
features <- read.table("data/UCI HAR Dataset/features.txt")

#set names
names(activity_labels) <- c("activity_id","activity_name")
names(subject_test) <- c("Subject_id")
names(X_test) <- features$V2
names_combine_1 <- grepl("mean|std", names(X_test))
X_test <- X_test[,names_combine_1]
names(y_test) <- c("activity_id")
names(subject_train) <- c("Subject_id")
names(X_train) <- features$V2
names_combine_2 <- grepl("mean|std", names(X_train))
X_train <- X_train[,names_combine_2]
names(y_train) <- c("activity_id")

#merge data
test_bind <- cbind(subject_test,X_test,y_test)
train_bind <- cbind(subject_train,X_train,y_train)
combine <- rbind(test_bind,train_bind)

combine$activity_id <- as.numeric(combine$activity_id)
activity_labels$activity_id <- as.numeric (activity_labels$activity_id)
combine$activity_name <- as.factor(combine$activity_name)
combine$Subject_id <- as.factor(combine$activity_id)
combine <- merge(combine, activity_labels,by.x="activity_id")

#Covert combine into data.table and mean of the combine data.table
combine <-  data.table(combine)
data_tidy <- aggregate(. ~Subject_id + activity_name, combine, mean)

#Order data_tidy
data_tidy <- data_tidy[order(data_tidy$Subject_id,data_tidy$activity_name),]

# Export data_tidy
write.table(data_tidy, file = "data_tidy.txt", row.names = FALSE)

