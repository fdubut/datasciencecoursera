# Instructions to clean up the Samsung Galaxy S accelerometer dataset

The cleanup script is called *run_analysis.R* and assumes the working directory is _UCI HAR Dataset_ (from the original zip file).

Running the script will create a new _merged_ subdirectory (or use the existing one) and output four files there:

* X.csv, the merged and cleaned up features (training + test)
* y.csv, the merged and cleaned up labels (training + test)
* subject.csv, the merged and cleaned up subjects (training + test)
* final.csv, the final tidy data set containing the average of each appropriate feature for each activity/subject pair
