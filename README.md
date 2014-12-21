
Objective
List out all the relevant data, documents, scripts to prepare tidy data set as directed by the course as:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The dataset includes the following files:

'README.txt'
'features_info.txt': Shows information about the variables used on the feature vector.
'features.txt': List of all features.
'activity_labels.txt': Links the class labels with their activity name.
'train/X_train.txt': Training set.
'train/y_train.txt': Training labels.
'test/X_test.txt': Test set.
'test/y_test.txt': Test labels.

Data source
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
 
Supportive Document
Codebook.md - Lists out the detailed data analysis process steps

Scripts
run_analysis.R  - R program data preparation scripts

How 'run_analysis.R' performs the prescribed cleansing and prepares the tidy data set?

Process 1 Download data files, merge the training and test sets to create one full data set
	Load the training and test data files, 	Merge  as:
-	x_train.txt, y_train.txt  and subject_train.txt  into ‘trainingdata’ data frame
-	x_test.txt, y_test.txt and subject_test.txt into ‘testdata’ data frame
-	Combine trainingdata’ and testdata’ data frames into single data frame - sensordata

Process 2:  Extracts only the measurements on the mean and standard deviation for each measurement
-	Label data frame columns
-	Extract ‘mean’ and ‘std’(standard deviation) measurements

Process 3:  Uses descriptive activity names to name the activities in the data set
-	Join ‘sensordata’ data frame with ‘activities’ by common column name “ActivityIdentifier”  , and associate descriptive names

Process 4  Appropriately labels the data set with descriptive variable names.
-	By using gsub, substitute label acronyms with expanded descriptive names 

Process 5  Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
-	By using ddply function, compute average value of each variable, each activity and subject


R Program environment
1. Require plyr package
2. Working directory is set to the unzipped data file directory
3. R version
platform       x86_64-w64-mingw32          
arch           x86_64                      
os             mingw32                     
system         x86_64, mingw32             
status                                     
major          3                           
minor          1.2                         
year           2014                        
month          10                          
day            31                          
svn rev        66913                       
language       R                           
version.string R version 3.1.2 (2014-10-31)
nickname       Pumpkin Helmet       


