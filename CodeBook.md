# CodeBook
Ajit Dingankar  
October 2, 2016  



# Data 

The data is obtained from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip> 
with the following commands: 


```r
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipDest = "Dataset.zip"
if (!file.exists(zipDest)) {
  download.file(url, destfile = zipDest, method = "curl")
  unzip(zipDest)
}
```

# Variables 

The variables are the features extracted from raw measurements, as described in the README.txt provided by the researchers in the downloaded dataset. In the fit part of 
the project, these feature are read in as numeric type, with default column names of 
V1..V561. 


```r
# ---- ---- Training set 
train_features  = read.csv(file.path("train", "X_train.txt"), header = FALSE, sep = "") 
print(paste("#training set feature vectors read: ", length(train_features)))

# ---- ---- Test set 
test_features  = read.csv(file.path("test", "X_test.txt"), header = FALSE, sep = "")
print(paste("#test set feature vectors read: ", length(train_features)))
```

# Code book for "tidy"
The variable names are encoded as two or three parts separated by a hyphen "-" 
with the third part being optional, indicating the direction in space that the 
variable corrseponds to, namely X, Y or Z. The second part denotes the mean or 
standard deviation (std). 

The first part starts with "t" or "f" denoting time- or frequency domain respectively. 
It is followed by "Body" or "Gravity" denoting whether the following components pertain 
to the body itself or to the gravity. After that come "Acc", "Gyro", "Jerk" or some 
combinations, denoting the measurement device (accelerometer or gyroscope) or if it's 
computed from time derivatives to detect jerky motion. 


```r
"tBodyAcc-mean()-X"           
"tBodyAcc-mean()-Y"          
"tBodyAcc-mean()-Z"           
"tBodyAcc-std()-X"           
"tBodyAcc-std()-Y"            
"tBodyAcc-std()-Z"           
"tGravityAcc-mean()-X"        
"tGravityAcc-mean()-Y"       
"tGravityAcc-mean()-Z"        
"tGravityAcc-std()-X"        
"tGravityAcc-std()-Y"         
"tGravityAcc-std()-Z"        
"tBodyAccJerk-mean()-X"       
"tBodyAccJerk-mean()-Y"      
"tBodyAccJerk-mean()-Z"       
"tBodyAccJerk-std()-X"       
"tBodyAccJerk-std()-Y"        
"tBodyAccJerk-std()-Z"       
"tBodyGyro-mean()-X"          
"tBodyGyro-mean()-Y"         
"tBodyGyro-mean()-Z"          
"tBodyGyro-std()-X"          
"tBodyGyro-std()-Y"           
"tBodyGyro-std()-Z"          
"tBodyGyroJerk-mean()-X"      
"tBodyGyroJerk-mean()-Y"     
"tBodyGyroJerk-mean()-Z"      
"tBodyGyroJerk-std()-X"      
"tBodyGyroJerk-std()-Y"       
"tBodyGyroJerk-std()-Z"      
"tBodyAccMag-mean()"          
"tBodyAccMag-std()"          
"tGravityAccMag-mean()"       
"tGravityAccMag-std()"       
"tBodyAccJerkMag-mean()"      
"tBodyAccJerkMag-std()"      
"tBodyGyroMag-mean()"         
"tBodyGyroMag-std()"         
"tBodyGyroJerkMag-mean()"     
"tBodyGyroJerkMag-std()"     
"fBodyAcc-mean()-X"           
"fBodyAcc-mean()-Y"          
"fBodyAcc-mean()-Z"           
"fBodyAcc-std()-X"           
"fBodyAcc-std()-Y"            
"fBodyAcc-std()-Z"           
"fBodyAccJerk-mean()-X"       
"fBodyAccJerk-mean()-Y"      
"fBodyAccJerk-mean()-Z"       
"fBodyAccJerk-std()-X"       
"fBodyAccJerk-std()-Y"        
"fBodyAccJerk-std()-Z"       
"fBodyGyro-mean()-X"          
"fBodyGyro-mean()-Y"         
"fBodyGyro-mean()-Z"          
"fBodyGyro-std()-X"          
"fBodyGyro-std()-Y"           
"fBodyGyro-std()-Z"          
"fBodyAccMag-mean()"          
"fBodyAccMag-std()"          
"fBodyBodyAccJerkMag-mean()"  
"fBodyBodyAccJerkMag-std()"  
"fBodyBodyGyroMag-mean()"     
"fBodyBodyGyroMag-std()"     
"fBodyBodyGyroJerkMag-mean()" 
"fBodyBodyGyroJerkMag-std()" 
```
