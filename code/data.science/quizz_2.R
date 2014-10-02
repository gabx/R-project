# quizz 2 semaine 2

# question 1
# Use R cmd line
require(httr)

oauth_endpoints("github")

# auth with my api.github ID key
myapp <- oauth_app("github","c866ce2602b402b423bf")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)

# get details about app datasharing
req <- GET("https://api.github.com/repos/jtleek/datasharing", gtoken)
stop_for_status(req)
content(req)$created_at
# 2013-11-07T13:25:07Z
#######################################
# question 2
require(sqldf)
acs <- read.csv2("acs.csv", header=T, dec=".", sep=",", as.is=T, 
                 strip.white=T, quote="",na.strings="NA")

rep <- sqldf("select pwgtp1 from acs where AGEP < 50")
#######################################
# question 3
# sqldf("select distinct AGEP from acs")
############################################
# question 4
# open connection 
con <- url("http://biostat.jhsph.edu/~jleek/contact.html")

# read
htmlCode <- readLines(con)

# close connection
close(con)

# find How many characters are in the 10th, 20th, 30th and 100th lines of HTML
# we will use nchar().
# our htmlCode object is a chain of characters with 180 lines

rep <- nchar(c(htmlCode[10],htmlCode[20],htmlCode[30],htmlCode[100]))
# [1] 45 31  7 25
################################
# question 5
# the file is fixed width file format ==> use of read.fwf()

my.file <- read.fwf(
    file="wksst.for",
    skip=4,widths=c(12, 7,4, 9,4, 9,4, 9,4))

rep <- sum(my.file$V4)
# [1] 32426.7


