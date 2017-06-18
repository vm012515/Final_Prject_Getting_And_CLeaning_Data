
#Datasets downloading and unzipping
if(!file.exists("./final_asn")) {
        dir.create ("./final_asn")
        Url<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(Url, destfile="./final_asn/Dataset.zip")
        unzip(zipfile="./final_asn/Dataset.zip", exdir="./final_asn")
        
        }
#Reading train train files)
x_train <- read.table("./final_asn/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./final_asn/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./final_asn/UCI HAR Dataset/train/subject_train.txt")

#Reading test files
x_test <- read.table("./final_asn/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./final_asn/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./final_asn/UCI HAR Dataset/test/subject_test.txt")

#Reading feature and activity labels files
features <- read.table("./final_asn/UCI HAR Dataset/features.txt")
activityLabels = read.table("./final_asn/UCI HAR Dataset/activity_labels.txt")

#Naming columns
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activ_Id"
colnames(subject_train) <- "sub_Id"
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activ_Id"
colnames(subject_test) <- "sub_Id"
colnames(activityLabels) <- c('activ_Id','activ_Type')

#Merging all data sets
train_merge <- cbind(x_train, y_train, subject_train)
test_merge <- cbind(x_test, y_test, subject_test)
all_data<- rbind(train_merge, test_merge)

#Reding names of columns
colNames <- colnames(all_data)

#Identifyig ID, mean and sd
IMSD <- (grepl("activ_Id" , colNames) | 
                         grepl("sub_Id" , colNames) | 
                         grepl("mean.." , colNames) | 
                         grepl("std.." , colNames)) 
#Creating the subset for ID, mean and sd
sub_IMSD <-all_data [ ,IMSD == TRUE]

#Merging data sets
mrgActivity<- merge(sub_IMSD, activityLabels, 
               by='activ_Id', all.x=TRUE)

#Making new data set with mean for each variable for each subject
new_set <- aggregate(. ~sub_Id + activ_Id, mrgActivity,mean)
final_new_set<- new_set[order(new_set$sub_Id, new_set$activ_Id),]
#Creating txt file
write.table(final_new_set, "final_new_set.txt", row.name=FALSE)