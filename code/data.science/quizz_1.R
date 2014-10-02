# quizz semaine 1

library(data.table)
library(xlsx,xlsxjars)
library(XML)

# Question 1
# download the .csv file in the current directory
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl,destfile="./cloudfront.csv",method="curl")

# read file
my.file <- read.csv2("cloudfront.csv", header=T, dec=".", sep=",", as.is=T, 
        strip.white=T, quote="",na.strings="NA")


# my.file as data.table
my.dt.file <- data.table(my.file)

# select properties with value > $1,000,000 . Column VAL
sum(my.dt.file[,VAL == 24], na.rm=T)
################################################
#question 2
# Tidy data has one variable per column. 
#############################################3
#Question 3
# download file
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx" 
download.file(fileUrl,destfile="./cloudfront.xlsx",method="curl")

# read file. We need to explicitely name the sheet (can be its position in 
# Workbook or the real name). Keep 7-15 columns
dat <- read.xlsx("cloudfront.xlsx", sheetIndex = 1, rowIndex = 18:23,
                         colIndex = 7:15, header=T)
                         
sum(dat$Zip*dat$Ext,na.rm=T) 
#[1] 36534720
################################################
#question 4
# read file
fileUrl <- "http://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(fileUrl,useInternalNodes = T)
rootNode <- xmlRoot(doc)
xmlName(rootNode)

# get items by zipcode. result is a chain of chr
my.zip <- xpathSApply(rootNode,"//zipcode",xmlValue)

# find how many zipcode are equal to 21231
# table(my.zip) show the table
table(my.zip)[names(table(my.zip)) == 21231]
# 21231 
#127 
#####################################
#question 5
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv " 
download.file(fileUrl,destfile="./cloudfront_1.csv",method="curl")

# read cloudfront.csv with fread(). usually faster than read.csv.
 DT <- fread("cloudfront_1.csv")

# measure system time
library(microbenchmark)
library(ggplot2)
m <- microbenchmark(  DT[,mean(pwgtp15),by=SEX], 
                     tapply(DT$pwgtp15,DT$SEX,mean), 
                     sapply(split(DT$pwgtp15,DT$SEX),mean),
                     c(mean(DT[DT$SEX==1,]$pwgtp15), mean(DT[DT$SEX==2,]$pwgtp15)),
                     times=300)

# see result
autoplot(m)
# sapply(split(DT$pwgtp15,DT$SEX),mean)
