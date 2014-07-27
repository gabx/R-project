# write tidy data set

cat('\nWriting Tidy Data to .csv file')

setwd('../')

write.csv(my.result1,'Mean_Std_per_activity.csv')

write.csv(my.result2,'Mean_Std_per_activity_and_subject.csv')

cat('\nPlease find Mean_Std_per_activity.csv & Mean_Std_per_activity.csv
in the Data directory')
        
    
