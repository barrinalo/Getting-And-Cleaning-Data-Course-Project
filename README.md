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
##Notes
*	Feature names have been modified by removing all '(' and ')' and replacing all '-' with '.'
*	Only features that stated mean/std independently were extracted. e.g meanFreq doesnt count as mean is combined with Freq
*	Variable Naming
	*	The name "activity.description" was used for the column containing the information on what activity was being monitored
	*	The name "id.of.person.performing.activity" was used for what was previously called "subject" in the original dataset as I felt subject was rather ambiguous.
	*	All names in "average_data.txt" followed the original data set but was prepended with an "average.of."