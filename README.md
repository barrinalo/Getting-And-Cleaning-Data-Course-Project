#Getting And Cleaning Data Course Project
David Chong Tian Wei

##Files
*	UCI HAR Dataset (Folder)
	*	The untouched data and supporting text files that was provided for this assignment.  Please read their "features_info.txt" and "README.txt" for more detailed information about the dataset.
*	average_data
	*	This file contains the average of each mean and standard deviation measurement variable for each activity and subject
*	combined_data
	*	This file contains data from both the "train" and "test" folders in the UCI HAR Dataset (Folder).  It has combined the activity description with subject and features.
*	run_analysis.R
	*	This is the script which creates "average_data.txt" and "combined_data.txt".
##Notes on how run_analysis.R works
1.	Reads in "activity_labels.txt" and "features.txt" for later use
2.	Removes "(" and ")" from the features that were imported previously
3.	Replaces "-" with "." from the features that were imported previously
4.	Searches for independent ".mean." and ".std." text within the features and creates a logical vector to subset the variables that will be used later for the output tidy data set.
5.	Read in "X_train.txt", "y_train.txt", "subject_train.txt", "X_test.txt", "y_test.txt", "subject_test.txt".
6.	Using the logical vector in step 4 subset the "X_train.txt" and "X_test.txt" to only include data on the required variables
7.	Merge the respective "train" and "test" data.
8.	Merge the features, subject and activity data to form one data frame
9.	Looping through 1 to 30 and the activity_labels factors, apply the mean function to each subset and enter it into a new data frame
10.	Output the data frame.

##Codebook
*	Most variables are unchanged from the original dataset.  The main difference is the removal of "(" and ")" and replacement of "-" with "."
*	Variables in "averaged_data.txt" are the average of each mean or std variable in the original dataset grouped by subject and activity
*	Variables in "averaged_data.txt" follow the same name as the original dataset but are prepended with "average.of."
*	The activity_label factors have the variable name "activity.description"
*	The subject numbers have the variable name "id.of.person.performing.activity"
