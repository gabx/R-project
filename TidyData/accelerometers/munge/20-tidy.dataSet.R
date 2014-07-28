# read data file and merge

require('data.table')
require('reshape2')

cat('\nTyding raw data. Please wait')

# gather all files in one place and do some clean up
setwd('data/UCI HAR Dataset')
file.rename(from= c('train/subject_train.txt','train/X_train.txt','train/y_train.txt'),
            to = c('subject_train.txt','X_train.txt','y_train.txt'))

file.rename(from= c('test/subject_test.txt','test/X_test.txt','test/y_test.txt'),
            to = c('subject_test.txt','X_test.txt','y_test1.txt'))

## clean
unlink(c('train','test'), recursive = TRUE) 


# read files
## training
x.training.dt <- read.table('X_train.txt', header = F, sep = "", 
                                     dec = '.')
y.training.dt <- read.table('y_train.txt', header = F, sep = "", 
                            dec = '.', col.names = "Activity ID")
                            

##test
x.test.dt <- read.table('X_test.txt', header = F, sep = "", 
                        dec = '.')                             
y.test.dt <- read.table('y_test1.txt', header = F, sep = "",
                                 dec = '.',col.names = "Activity ID")

##subject
training.subject.dt <- read.table('subject_train.txt', header = F, sep = "", 
                                  dec = '.', col.names = "Subject ID")
test.subject.dt <- read.table('subject_test.txt', header = F, sep = "", dec = '.', 
                              col.names = "Subject ID")

                         
# 1- merge train and test data files
x <- rbind(x.training.dt,x.test.measures.dt)
y <- rbind(y.training.dt,y.test.dt)
subject <- rbind(training.subject.dt,test.subject.dt)


# read features
features.dt <- read.table("features.txt", header=F, sep = "", dec = '.')
                         
# set column names 
colnames(x) <- features.dt[[2]]

# 2- Extracts only the measurements on the mean and standard deviation 
# for each measurement. 
my.mean <- grep('mean\\(\\)', features.dt[[2]], value=TRUE)
my.std <- grep('std\\(\\)', features.dt[[2]], value=TRUE)

my.select.features <- x[,c(my.mean, my.std)]

# 3-Use descriptive activity names to name the activities in the data set
activity.dt <- read.table("activity_labels.txt", colClasses= 'character',
                          header = F, sep = "", dec = '.',
                          col.names = c('Activity ID','Activity'))

# 4-Appropriately labels the data set with descriptive variable names
my.activity <- merge(y,activity.dt)
my.result1 <- cbind(my.activity['Activity'],my.select.features)



# 5-Creates a second, independent tidy data set with the average of each variable
# for each activity and each subject. 

my.data.set <- cbind(subject, my.result1)

# molt our df then cast 
my.df <- melt(my.data.set, id = c('Activity', 'Subject.ID'))
my.result2 <- dcast(my.df, Activity + Subject.ID ~ variable, mean)


# caching results
cache('x.training.dt')
cache('y.training.dt')
cache('x.test.dt')
cache('y.test.dt')
cache('training.subject.dt')
cache('test.subject.dt')
cache('features.dt')
cache('activity.dt')

setwd('../..')

cat('\nTidy Data are now set')
