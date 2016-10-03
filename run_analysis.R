url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
setwd("project")
zipDest = "Dataset.zip"
if (!file.exists(zipDest)) {
  download.file(url, destfile = zipDest, method = "curl")
  unzip(zipDest)
}
dataDir = "UCI HAR Dataset"
setwd(dataDir)

library(plyr)

# --------------------------------- 
# Step 1: Merge the training and the test sets
# ---------------------------------

# ---- ---- Training set 
feature_names  = read.csv("features.txt", header = FALSE, sep = "")
train_features  = read.csv(file.path("train", "X_train.txt"), header = FALSE, sep = "") 
#                           col.names = feature_names$V2
# training_data = cbind(train_subjects, train_labels, train_features)

# ---- ---- Test set 
test_features  = read.csv(file.path("test", "X_test.txt"), header = FALSE, sep = "")
#                           col.names = feature_names$V2
# test_data = cbind(test_subjects, test_labels, test_features)

# ---- ---- Merge
#all_data = rbind(training_data, test_data)
all_data = rbind(train_features, test_features)

# --------------------------------- 
# Step 2: Extract means and standard deviations 
# ---------------------------------

# Need an extra back-slash to prevent being eaten up by the string interpolator :-)
mean_std_features = grep("mean\\(\\)|std\\(\\)", feature_names$V2)
mean_std_data = all_data[, mean_std_features]

# --------------------------------- 
# Step 3: Use descriptive activity names
# ---------------------------------
# Read activity label names 
activity_labels  = read.csv("activity_labels.txt", header = FALSE, sep = "")

# Read activity label numeric values as y column
train_activities = read.csv(file.path("train", "y_train.txt"), header = FALSE)
test_activities  = read.csv(file.path("test",  "y_test.txt"),  header = FALSE)

# Label activities
#get_activity_label = function(i) { activity_labels$V2[i] }
#train_labels = transform(train_activities, V1=get_activity_label(train_activities$V1))
#test_labels  = transform(test_activities,  V1=get_activity_label(test_activities$V1))

train_labels = transform(train_activities, V1=activity_labels$V2[train_activities$V1])
test_labels  = transform(test_activities,  V1=activity_labels$V2[test_activities$V1])

all_activities = rbind(train_labels, test_labels)
all_activities = rename(all_activities, c("V1" = "activity"))

# --------------------------------- 
# Step 4: Use descriptive variable names
# ---------------------------------
mean_std_feature_names = grep("mean\\(\\)|std\\(\\)", feature_names$V2, value = TRUE)
names(all_data) = mean_std_feature_names 
#sub("$V([0..9]*)", mean_std_feature_names["\\1"], names(all_data))

# --------------------------------- 
# Step 5: Create a tidy data set with averages
# ---------------------------------
# Add labelled activities to the feature data set
all_activity_data = cbind(all_activities, all_data)

train_subjects = read.csv(file.path("train", "subject_train.txt"), header = FALSE,
                            col.names = c("subject"))
test_subjects = read.csv(file.path("test", "subject_test.txt"), header = FALSE,
                           col.names = c("subject"))
all_subjects = rbind(train_subjects, test_subjects)
all_subject_activity_data = cbind(all_subjects, all_activity_data)

grouping_column_names = list("activity", "subject")
tidy = aggregate(all_subject_activity_data[, 3:563], 
          # list(all_subject_activity_data$activity, all_subject_activity_data$subject),
          lapply(grouping_column_names, 
                 function(name) {all_subject_activity_data[, name]}),
          mean)
names(tidy)[1:2] = grouping_column_names

write.table(tidy, file = "tidy.txt", row.names = FALSE)
