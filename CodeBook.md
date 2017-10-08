# Code book for the Samsung Galaxy S accelerometer dataset cleanup

## Study design

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See below "original feature engineering" for more details.

*Note: the original dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. To build the final tidy dataset, we recombined the training and test sets into a single dataset.*

## Dataset

For each record, we provide:

* A 66-feature vector with time and frequency domain variables (*X.csv*)
* Its activity label, both as numeric ID and friendy name (*y.csv*)
* An identifier of the subject who carried out the experiment (*subject.csv*)

In addition, for each pair of subject (30 in total) and activity (6 in total), we provide a 66-feature vector representing the respective grouped means of the same time and frequency domain variables (*final.csv*).

Additional notes:

* Features are normalized and bounded within [-1,1].
* Each feature vector is a row on the csv file.

## Original feature engineering

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals time.Acc.XYZ and time.Gyro.XYZ. These time domain signals (prefix 'time' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (time.BodyAcc.XYZ and time.GravityAcc.XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (time.BodyAccJerk.XYZ and time.BodyGyroJerk.XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (time.BodyAccMag, time.GravityAccMag, time.BodyAccJerkMag, time.BodyGyroMag, time.BodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing frequency.BodyAcc.XYZ, frequency.BodyAccJerk.XYZ, frequency.BodyGyro.XYZ, frequency.BodyAccJerkMag, frequency.BodyGyroMag, frequency.BodyGyroJerkMag. (Note the 'frequency' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'.XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

time.BodyAcc.XYZ
time.GravityAcc.XYZ
time.BodyAccJerk.XYZ
time.BodyGyro.XYZ
time.BodyGyroJerk.XYZ
time.BodyAccMag
time.GravityAccMag
time.BodyAccJerkMag
time.BodyGyroMag
time.BodyGyroJerkMag
frequency.BodyAcc.XYZ
frequency.BodyAccJerk.XYZ
frequency.BodyGyro.XYZ
frequency.BodyAccMag
frequency.BodyAccJerkMag
frequency.BodyGyroMag
frequency.BodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean: Mean value
std: Standard deviation

## Additional feature engineering

1. The raw data was provided split into a training and a test set. The first step was to recombine them, with the test set appended directly after the training set, for all of X (features), y (labels) and subject (subject data). In this step we also give a friendly name to the only column in the subject set (*subject.id*) and output it as a csv file.

2. The raw data was provided with many more variables than mean and std (e.g. "kurtosis"). In order to filter down the features to only mean and std, we used a regex, thus reducing the total number of features from 561 to 66 (with values unchanged).

3. We joined the y (labels) set and the activity labels so that each line contains both the numeric ID of the activity (*activity.id*) and the friendly name of the activity (*activity.name*). The result is output as csv file.

4. We gave friendlier names to each feature using a small set of regex and output the result as csv file.

5. We joined the subject, labels (y) and features (x) into a single data frame. Then we performed a mean aggregate grouped by subject and activity, resulting in 180 records (30 subjects x 6 activities) of 66 features. The result is output as csv file (*final.csv*).
