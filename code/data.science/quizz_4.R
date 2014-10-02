
# question 1
my.data <- read.csv2('getdata.csv', sep = ',', header = F)
my.names <- names(my.data)
res <- strsplit(my.names, 'wgtp')
# 123 element is
res[[123]]
# [1] ""   "15"

# question 2-3
my.csv <- read.csv2('GDP.csv', sep = ',', header = T, skip = 4)

# reshape data frame
my.data <- my.csv[1:231,c(1,2,4,5)]
names(my.data) <- c('countryCode','ranking','countryNames','gdp')
## remove coma from thousand sep
my.data$gdp <- as.numeric(gsub(',','',my.data$gdp))
## remove NA
my.data <- na.omit(my.data)

# keep only countries
my.sel <- my.data[1:190,]

# get gdp mean
my.avg <- summary(my.sel)
# res Mean   :  377652.421 



# how many country begins with United
coun.names <- my.sel$countryNames[-99]
coun.names <- coun.names[-185]
grep("^United",coun.names)
# res : 3

# question 4
my.csv1 <- read.csv2('GDP.csv', sep = ',', header = T, skip = 4)

# reshape data frame
my.data <- my.csv1[,c(1,2,4,5)]
# rename columns
names(my.data) <- c('CountryCode','ranking','countryNames','gdp')
## remove coma from thousand sep
my.data$gdp <- as.numeric(gsub(',','',my.data$gdp))
## remove NA 
my.data1 <- na.omit(my.data)


my.csv2 <- read.csv2('EDSTATS.csv', sep = ',', header = T)
my.data2 <- my.csv2

# rename 

# merge rows by column CountryCode (the only one in both df)
my.comp.df <- merge(my.data1, my.data2)

# Select country with Fiscal year end precised in Special.Notes column
my.fisc <- grep("*Fiscal year end",my.comp.df$Special.Notes)
my.fisc <- my.comp.df[my.fisc,]

# now select Fiscal year end: June
my.june <- grep("*Fiscal year end: June",my.fisc$Special.Notes)
my.res <- my.fisc[my.june,]
# res : 13

# question 5
library('quantmod')

amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 


# the xts package put the date in row.names. We need to change this
newdf <- data.frame(sampleTimes,amzn)

# find values for 2012
my.num <- grep('^2012',newdf$sampleTimes)
str(my.num)
# int [1:250] 1261 1262 1263 1264 1265 1266 1267 1268 1269 1270 ...
my.2012 <- newdf[my.num,]

# values on monday
my.2012.weekday <- weekdays(my.2012[,1])
my.res <- grep('Monday', my.2012.weekday)
str(my.2012.weekday)
# int [1:47]
# res : 250,47

