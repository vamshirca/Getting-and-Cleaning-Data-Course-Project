#Code Book  
##This book Describes Variables, Data and Transformation  
  
Step1: Load the required libraries to run the R script.  
Step2: Read the list of all features from features.txt.Store the result in features  
Step3: Create a data frame with the list of feature names and store it in fts.  
Step4: Unlist fts to convert into a character vector. This vector will later be used to assign the column names for the final data set  
Step5: Read the activity labels from activity_labels.txt. Assign the result to labels.  
This will later be used to assign label names to name the activities in the final data set.  
  
  
###Read Test Data Sets  
  
Step8: Read the Test data set from X_test.txt. Assign the result to set_test.    
Step9: Read subject_test file where each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. Assign the result to subject_test.   
Step10: Read y_test file where each row identifies activity number. Assign the result to label_test.   
Step11: Get activity names associated to its Test labels using label_test fetched from Step10  and store it in test_activity_name data frame.  
  
  
###Read Training Data Sets  
  
Step12: Read the Training data set from X_train.txt. Assign the result to set_train.  
Step13: Read subject_train file where each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. Assign the result to subject_train.   
Step14: Read y_train file where each row identifies activity number. Assign the result to label_train.  
Step15: Get activity names associated to its Training labels using label_train fetched from Step14  and store it in train_activity_name data frame.  

###Transform the data sets  
  
Step16: Column bind to merge Set_name, Subject ,Activity name(as fetched in step 11) and Original Test data set.  
Step17: Column bind to merge Set_name, Subject ,Activity name (as fetched in step 15) and Original Training data set.  
Step18: Merge Test and Training data sets and store the result in test_train.    
Step19: Assign column names to test_train using fts vector created in Step 4.    
Step20: Use grep on fts to retrieve only the columns which calculate mean and standard deviation. Store the result in mean_std_cols.  
Step17: Subset the data.table created in step 18 to retrieve the data only for  mean and standard deviation columns (as fetched in Step20).Name this as final_data_set.    
Step18: Use aggregate() to calculate average of each variable for each activity and each subject grouping by Set name, Subject and Activity name. Assign the result to tidy_set.  
Step19: Arrange tidy_set by Set_name,Subject and Activity_name.  
Step20: View the tidy_set.  