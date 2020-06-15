## Overview
For a more detailed explanation of each variable, we are able to consult the README.txt file of the zip file that is downloaded.

### Project Intro
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

#### Info provided
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

#### The dataset includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

#### Notes: 
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.


## Processing of the Data
For this project we followed each one of the following steps and they will be explained in detail

1. Merges the training and the test sets to create one data set.
    - As was mentioned above, there are two versions of our three main sets of files. X, Y and subject. 
    - It was necessary to combine both of these data sets to have a complete data set, but it was convenient to first process the next steps and then combine the data sets at the end. 
    - This was achieved by first combining the test and training data sets individually and then combining both sets into a master set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
    - In features.txt there is a list of all the available features.
    - To extract the features that correspond to the mean and std it was necessary to use a regular expressions that look for mean() and std(). Just looking for mean or std won't work because some features share the word mean as well.
    - Once we have a logical vector of features that are mean and std we can continue to extract only those columns from the data set x (training and testing).
3. Uses descriptive activity names to name the activities in the data set
   - In activity_labels.txt there is a list of numbers and text related to that number which are the labels. 
   - Since they are ordered we just need to match up the name of the activity with the activity label used in the 'y' files. 
   - I found it to be a good idea to add these names as it's own column next to the y number, just in case future users want to manipulate the number instead of the name (although converting to a label is also an options).
4. Appropriately labels the data set with descriptive variable names.
    - This step can be done before step 3.
    - We extract the labels from features.txt and apply the contents as column names to our x files.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    - In this step we get our merged data set from step 1 and use the reshape2 library to be able to group our rows by activity and subject.
    - Once grouped we can apply our mean function to all of the variables that are not part of our id vector. 
        
6. Extra step to save the information to .txt files

## Var names
- Subject_ID Contains the id of the person who recorded the information
- Activity Number associated with a certain activity
- Activity_Name Gives an actual name for the activity used.

##### The following vars are self describing. 
"tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"           "tBodyAcc-mean()-Z"          
"tBodyAcc-std()-X"            "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"           
"tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"        "tGravityAcc-mean()-Z"       
"tGravityAcc-std()-X"         "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
"tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"       "tBodyAccJerk-mean()-Z"      
"tBodyAccJerk-std()-X"        "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
"tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"          "tBodyGyro-mean()-Z"         
"tBodyGyro-std()-X"           "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
"tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"      "tBodyGyroJerk-mean()-Z"     
"tBodyGyroJerk-std()-X"       "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
"tBodyAccMag-mean()"          "tBodyAccMag-std()"           "tGravityAccMag-mean()"      
"tGravityAccMag-std()"        "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
"tBodyGyroMag-mean()"         "tBodyGyroMag-std()"          "tBodyGyroJerkMag-mean()"    
"tBodyGyroJerkMag-std()"      "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
"fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"            "fBodyAcc-std()-Y"           
"fBodyAcc-std()-Z"            "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
"fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"        "fBodyAccJerk-std()-Y"       
"fBodyAccJerk-std()-Z"        "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
"fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"           "fBodyGyro-std()-Y"          
"fBodyGyro-std()-Z"           "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
"fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"   "fBodyBodyGyroMag-mean()"    
"fBodyBodyGyroMag-std()"      "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()" 

