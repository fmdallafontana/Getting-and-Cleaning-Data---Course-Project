# Code Book

This file describes the variables, the data, and the transformations and work that have been performed to clean up the data.

### Raw data set collection

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

The set of variables that were estimated from these signals are: 

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window
- angle(): Angle between to vectors

### Data transformation steps

For cleaning the data and creating a tidy data set, the run_analysis.R script performs 5 steps described below.

##### 1. Merge the training and the test sets to create one data set

Test and training data sets (X_train.txt, X_test.txt), subject ids files (subject_train.txt, subject_test.txt) and activity ids files (y_train.txt, y_test.txt) are merged to obtain a single data set. Variables are labelled with the names assigned by original collectors (features.txt).

##### 2. Extract only the measurements on the mean and standard deviation for each measurement

A subset of the merged data set is extracted selecting only the values of estimated means (variables with labels that contain "mean()") and standard deviation (variables with labels that contain "std()").

##### 3. Use descriptive activity names to name the activities in the data set

A new column containing the activity description (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING) is linked to the data set using an activity id. This activity descriptions are locaded in the file activity_labels.txt.

##### 4. Appropriately label of the data set with descriptive variable names

In this step the labels of the original variables are changed in order to represent more clearly what the variable is measuring. The label changes are the following:

- prefix t is replaced by "time"
- prefix f is replaced by "frequency"
- "Acc" is replaced by "Accelerometer"
- "Gyro" is replaced by "Gyroscope"
- "Mag" is replaced by "Magnitude"
- "BodyBody" is replaced by "Body"

##### 5. Creation of a tidy data set

The tidy data set is created averaging each measurement of the intermediate data set for each subject and each activity.
Final data set is ordered in ascending order by subjects and activity, and exported to .txt and .csv files, called tidyDataset.txt and tidyDataset.csv respectively. It is consisted of 10299 observations and 69 variables.
