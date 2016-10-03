# README
Ajit Dingankar  
October 2, 2016  



We start with the data acquisition process: the dataset is downloaded and extrated 
as described in the CodeBook.
The aActual data processing is performed in the run_analysis.R script in the following steps.

# Merge the training and the test sets
The merge is obtained simply by concatenation of the feature vecors for the training 
and test sets. 


```r
all_data = rbind(train_features, test_features)
```

# Extract means and standard deviations 
To compute the mean and standard deviation for each measurement, match the feature 
names to 'mean()' or 'std()'. The requirement in the project description, that the 
script "Extracts only the measurements on the mean and standard deviation" dictated 
this choice, since 'feature_info.txt' file explicitly states that these functions 
are used to calculate the mean and standard deviation. It leaves out some features, 
e.g. those containing 'meanFreq' in the name, but those denote the "Weighted average 
of the frequency components" but not the measurements themselves, according to the 
description in the 'feature_info.txt' file. 


```r
mean_std_features = grep("mean\\(\\)|std\\(\\)", feature_names$V2)
mean_std_data = all_data[, mean_std_features]
```
Note the extra back-slash to prevent it being "eaten up"" by the string interpolator! :-)

# Use descriptive activity names
First read activity label names:

```r
activity_labels  = read.csv("activity_labels.txt", header = FALSE, sep = "")
```
Then read the numeric values for the activity labels from the "y" column:

```r
train_activities = read.csv(file.path("train", "y_train.txt"), header = FALSE)
test_activities  = read.csv(file.path("test",  "y_test.txt"),  header = FALSE)
```
Then we can transform these data frames by looking up the labels with the numeric 
values as indices, and replacing them in place.

```r
train_labels = transform(train_activities, V1=activity_labels$V2[train_activities$V1])
test_labels  = transform(test_activities,  V1=activity_labels$V2[test_activities$V1])
```
The last task is to append the training and test labels and renaming the column.

```r
all_activities = rbind(train_labels, test_labels)
all_activities = rename(all_activities, c("V1" = "activity"))
```

# Use descriptive variable names
We use the same pattern as in Step 2 above but now get the 'value' and simply assign 
it to the names of the data frame columns.

```r
mean_std_feature_names = grep("mean\\(\\)|std\\(\\)", feature_names$V2, value = TRUE)
names(all_data) = mean_std_feature_names 
```

# Create a tidy data set with averages
In order to compute the average values of each variable for each activity and each subject, all we need is to add the labelled activities created in Step 3 above to 
the feature data set: 

```r
all_activity_data = cbind(all_activities, all_data)
```
We also add all the subjects in a similar manner: 

```r
train_subjects = read.csv(file.path("train", "subject_train.txt"), header = FALSE,
                            col.names = c("subject"))
test_subjects = read.csv(file.path("test", "subject_test.txt"), header = FALSE,
                           col.names = c("subject"))
all_subjects = rbind(train_subjects, test_subjects)
all_subject_activity_data = cbind(all_subjects, all_activity_data)
```
Then we set the grouping columns in the order specified in the project requirements 
("average of each variable for each activity and each subject") and aggregate 'by' 
those columns, applying the 'mean' functions to the groups:

```r
grouping_column_names = list("activity", "subject")
tidy = aggregate(all_subject_activity_data[, 3:563], 
          lapply(grouping_column_names, 
                 function(name) {all_subject_activity_data[, name]}),
          mean)
```
All that's left is to give meaningful names to the grouped columns to really 
tidy up the data frame! 

```r
names(tidy)[1:2] = grouping_column_names
```
Now we have an independent "tidy" data set!
 
 
