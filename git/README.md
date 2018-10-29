# README 

## DATA
The data for this project was provided in two separate sets of observations - one called train and the second called test. Each row in these data sets has 561 factors/variables. Each observation is for a specific subject performing a specific activity. 
The variable names are provided in a separate file called features.txt.
The subject performing the activity is also provided in two files - train and test.
Similarly, the id of the activity for each observation is also provided in two files - train and test
A separate file is also provided that has the description for each activity id.


## CODE
The run_analysis.R script will do the following:

### DATA PREP
1. read all the data files 
2. combine the train and test data sets for observations, activity and subjects
3. determine the variables that are mean and std measurements
### DATA SUBSETTING
4. build a new data set that only has the readings for the variables of interest
### DATA TIDYING
5. set freindly names for the variables and activities
6. include subject and activity detail in the dataset
### DATA SUMMARY
7. calculate averages of all variables by subject and activity