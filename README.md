Script explanation
==================

The `run_analysis.R` script performs the following steps.

1. Unzips the smartphone data, which it assumes you have placed in your working 
directory in a file called `data.zip`. 
2. Reads the feature vectors from the training and testing sets and recombines 
them into one table. 
3. Reads the activity labels from the training and testing sets and recombines
them into one vector.
4. Reads the subject labels from the training and testing sets and recombines
them into one vector.
5. Extracts columns from the feature vector table which correspond to mean or
std values for their respective variables, or variables which represent a mean
reported value. In other words, this means all variables which have the suffix
-mean() or -std() in the original dataset, plus all variables with 'mean' in the
title. Constructs a new table with these columns.
6. Replace the numeric activity labels with character labels. For example, the
activity "1" becomes "LAYING".
7. Combine the activity labels and subject labels as new columns in the feature
vector table.
8. Add titles for each column in the new table.
9. Split the rows into groups by activity and subject, and then get the mean of
each of these sets. Return these means per activity and subject as a new table.
10. Correct the activity names in the new means table.
11. Save the new means table.
