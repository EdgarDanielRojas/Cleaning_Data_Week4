# NOTE: If for any reason lines of code are commented it is due to the fact that it takes
# a lot of time to take those steps so they were disabled for speed
# Run once to download the data for the project
url_data = 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(url_data,'assignment.zip')
unzip('assignment.zip')

# Read data into data tables 
data_x_test = read.table('UCI HAR Dataset/test/X_test.txt')
data_y_test = read.table('UCI HAR Dataset/test/y_test.txt')
data_subject_test = read.table('UCI HAR Dataset/test/subject_test.txt')
data_x_train = read.table('UCI HAR Dataset/train/X_train.txt')
data_y_train = read.table('UCI HAR Dataset/train/y_train.txt')
data_subject_train = read.table('UCI HAR Dataset/train/subject_train.txt')
feature_names = read.table('UCI HAR Dataset/features.txt')
activity_labels = read.table('UCI HAR Dataset/activity_labels.txt')

# We give our data sets some var names
colnames(data_x_test) <- feature_names[,2]
colnames(data_x_train) <- feature_names[,2]

# We locate the columns that have mean or std in their name so we can extract 
# the mean and standar deviation columns.
location_meanstd <- grepl('-(mean|std)\\(\\)',feature_names[,2])
data_x_test <- data_x_test[,location_meanstd]
data_x_train <- data_x_train[,location_meanstd]

# Give subject a descriptive name
colnames(data_subject_test) <- c('Subject_ID')
colnames(data_subject_train) <- c('Subject_ID')

# Give activity a descriptive Col name
colnames(data_y_test) <- c('Activity')
colnames(data_y_train) <- c('Activity')

# Get Activity Name from our label ds and create a data frame from the result 
activity_test <- data.frame(Activity_Name = activity_labels[data_y_test[,1],2])
activity_train <- data.frame(Activity_Name = activity_labels[data_y_train[,1],2])

# Bring together x,y and subject for testing and training and 
# join testing and training aftwards
joined_test = cbind.data.frame(data_subject_test,data_y_test,activity_test,data_x_test)
joined_train = cbind.data.frame(data_subject_train,data_y_train,activity_train,data_x_train)
joined_general = rbind.data.frame(joined_train,joined_test)

# Create a second data set with the mean of each variable
type_fix_mean <- function(x){mean(as.numeric(x))} # Needed for types
group_data = melt(joined_general, id= c('Subject_ID','Activity','Activity_Name'))
mean_data = dcast(group_data, Subject_ID + Activity + Activity_Name ~ variable, type_fix_mean)

# Save the data
write.table(joined_general,file = 'tidy_data.txt', row.names = F)
write.table(mean_data,file = 'tidy_data_means.txt', row.names = F)