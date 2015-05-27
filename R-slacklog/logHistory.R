# logHistory.0.3
# This script must be exectuded in a R session. See the linux script for 
# execution from shell environment
# Goal : log history messages from Slack channels in a R data
# Process : get the data and tidy it
# HINT: faster to work with date as numeric() and data.table

## required lybraries
# https://github.com/hrbrmstr/slackr
# check if packages installed
if (c('slackr', 'data.table') %in% rownames(installed.packages()) == FALSE) {
    install.packages(c('slackr', 'data.table'))
}
library(slackr)
library(data.table)

# seconds and epoch time with 6 digits
opSave <- options()
options(digits.sec = 6)
options(digits = 16)

# slackr setup
# edit the slackr.dcf file and put in your current directory
slackrSetup(config_file = 'slackr.dcf')


## GET DATA
# get channels, groups and users Slack id as data.frame and data.table and remove
# last column (uneeded)
myGroup <- slackrGroups()[,1:2, with = FALSE]
myChan <- slackrChannels()[,1:2, with = FALSE]
myUser <- slackrUsers()[,1:2, with = FALSE]

# get data into a R object
# take #random, now and Thu, 05 Feb 2015 00:00:00 GMT as time frame
myJson <- fromJSON('https://slack.com/api/channels.history?token=xoxp-2316142248-3083607128-3429647163-f2f7c4&channel=C029A467L&oldest=1423094400&pretty=1')
                   

## DATA TIDYING
myMessage <- as.data.table(myJson$messages[,2:5])

# remove channel_join/channel_leave ad file_share messages and unedded columns
# 3 variables : user, text, ts
mySel <- subset(subset(myMessage, is.na(myMessage$subtype) == TRUE | 
                       myMessage$subtype == 'file_share'), select = c(1:3))

# change column name user to id
setnames(mySel,'user','id')

# merge two df by id and remove id column
# 3 variables: name, text, ts. All are of type CHAR
myMerge <- subset(merge(myUser, mySel, 'id'), select = c(2,3,4))

                         
## Replace id by names
## ! This is the tricky part !
# pattern : <@U03AEKWTL> Regex: (?<=<@)[^|]{9}(?=>|)
# get the id U03AEKWTL we want to replace by name : 
myId <- regmatches(myMerge$text,regexpr('(?<=<@)[^|]{9}(?=>|)',myMerge$text, perl = T))

# find matching name for id in myUser table and allow duplication
myIdName <- subset(myUser[pmatch(myId, myUser$id, duplicates.ok = TRUE)], select = c(1,2))

# replace id by name
for (i in 1:length(myId)){
    myMerge$text <- gsub(myId[i],myIdName[[2]][i], myMerge$text, perl = TRUE)
}

# order epoch character, change to numeric and return POSIX GMT
myMerge$ts <- as.POSIXct(as.numeric(myMerge$ts), tz = 'UTC', origin = "1970-01-01" )

# remove 8 digits seconds
myMerge$ts <- format(myMerge$ts, "%Y-%m-%d %H:%M:%S")

# reset to initial options
options(opSave)
