README.md
The run analysis function ultimately returns a set of data that means the geometrical data on a samsung device for a person(subject) and type of activity (activity) that was occurred during the measuring.  This data was scrubbed to only include the geometric means and standard deviations within the data set.

Here are the steps I took to accomplish this.

1.  Combine the two data sets of test and train together to create one data set.
2.  Add the labels to the data.frame for the data set.
3.  Add two columns indicating the subject and the activity
4.  Filter the data frame so we only received the data results that only contained columns “mean()” and “std()”
5.  Then the data frame was looped through in order to apply the actual name of the activity instead of the code

6.  Once that was completed I split the data by subject
7.  Once the data was split, I then split it again by activity this allowed me to ge the mean of all the mean() and std() columns
8.  I then added the subject number in a new column
9.  I then added the activity name in a new column
10.  this process was looped through the for each subject and for each type that was defined within the project
11  At the end I returned the tidy_data_set that would allow for it to be viewed as output.