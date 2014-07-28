# write tidy data set


cat('\nWriting Tidy Data to .csv file')

write.csv(my.result1,'data/Mean_Std_per_activity.csv')

write.csv(my.result2,'data/Mean_Std_per_activity_and_subject.csv')

cat('\nPlease find Mean_Std_per_activity.csv & Mean_Std_per_activity.csv
in the Data directory')
        
    
# write codebook
cat('\nWriting the codebook pdf')

knit2pdf('munge/codebook.Rnw','doc/codebook.tex')

cat('\nPlease find codebook.pdf in the doc directory.\
Everything is done. Exiting the project !')



