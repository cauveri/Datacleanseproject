require(plyr)

# Load Data files

features <- read.table("features.txt", strip.white=TRUE, stringsAsFactors=FALSE)

# activity_labels <- read.table(activity_labels_file, col.names = c("ActivityId", "Activity"))

activity_labels <- read.table("activity_labels.txt", col.names = c("ActivityIdentifier", "Activityname"))

xtrain <- read.table("train/X_train.txt")
ytrain <- read.table("train/y_train.txt")

xtest <- read.table("test/X_test.txt")
ytest <- read.table("test/y_test.txt")

subjecttrain <- read.table("train/subject_train.txt")
subjecttest <- read.table("test/subject_test.txt")



# Assignment Part 1: Merges the training and the test sets to create one data set.

trainingdata <- cbind(cbind(xtrain, subjecttrain), ytrain)
testdata <- cbind(cbind(xtest, subjecttest), ytest)
sensordata <- rbind(trainingdata, testdata)


 
# Label columns
 
labelsensors <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityIdentifier"))[,2]
names(sensordata) <- labelsensors 

 
# Assignment Part 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
 

mean_std_sensordata <- sensordata[,grepl("mean|std|Subject|ActivityIdentifier", names(sensordata))]

# 3. Uses descriptive activity names to name the activities in the data set
 
mean_std_sensordata <- join(mean_std_sensordata, activity_labels, by = "ActivityIdentifier", match = "first")
mean_std_sensordata <- mean_std_sensordata[,-1]

# 4. Appropriately labels the data set with descriptive names.

names(mean_std_sensordata) <- gsub('\\(|\\)',"",names(mean_std_sensordata), perl = TRUE)

names(mean_std_sensordata) <- make.names(names(mean_std_sensordata))
# Make Names
names(mean_std_sensordata) <- gsub('Acc',"Acceleration",names(mean_std_sensordata))
names(mean_std_sensordata) <- gsub('GyroJerk',"AngularAcceleration",names(mean_std_sensordata))
names(mean_std_sensordata) <- gsub('Gyro',"AngularSpeed",names(mean_std_sensordata))
names(mean_std_sensordata) <- gsub('Mag',"Magnitude",names(mean_std_sensordata))
names(mean_std_sensordata) <- gsub('^t',"TimeDomain.",names(mean_std_sensordata))
names(mean_std_sensordata) <- gsub('^f',"FrequencyDomain.",names(mean_std_sensordata))
names(mean_std_sensordata) <- gsub('\\.mean',".Mean",names(mean_std_sensordata))
names(mean_std_sensordata) <- gsub('\\.std',".StandardDeviation",names(mean_std_sensordata))
names(mean_std_sensordata) <- gsub('Freq\\.',"Frequency.",names(mean_std_sensordata))
names(mean_std_sensordata) <- gsub('Freq$',"Frequency",names(mean_std_sensordata))

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

average_by_act_subject_sonor = ddply(mean_std_sensordata, c("Subject","Activityname"), numcolwise(mean))
write.table(average_by_act_subject_sonor, file = "average_by_act_subject_sensor.txt", row.names=FALSE)