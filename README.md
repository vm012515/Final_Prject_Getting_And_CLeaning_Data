# Course project (Getting and Cleaning Data)
The data Human Activity Recognition Using Smartphones was taken from
Samsung. The code for the project is provided in `run_analysis.R`, the Variables are in
`CodeBook.md` and the outcome is in `final_new_set.txt`
## Main steps
### 1. Downloading and reading data
* We download data from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* Then we unzip the data using `unzip` command
### 2. Naming columns
* We named subject Id column in both training and testing subject data tables as `sub_Id`
* We named activity Id column in both `y_train` and `y_test` data tables as `activ_Id`
 * For `activityLabels` we named columns as  `activ_Id`,`activ_Type` accordingly.

### 3. Merge data
* We merged all of the testing and training data to a new data frame `all_data`.

### 4. Choosing the data that contains mean and std in the column names
* We used `grepl` function to choose columns that contain `sub_Id`, `mean` and `std` and stored the data in a new data frame `sub_IMSD`
* We merged `sub_IMSD` and `activityLabels` dataframes based on `activ_Id` and stored in a new data frame `mrgActivity`
* We took the mean for activities for each subject in `mrgActivity` and stored it in `new_set`
* We ordered `new_set` data frame based on `sub_Id` and `activ_Id` and stored it in `final_new_set.`

### 5. Writing the second tiny data sets
* Now we just write the data to a new text file called `final_new_set.txt`
