
# question 1
# read the csv
df <- read.csv2('data.csv', sep = ',')

# select columns ACR & AGS
my.df.sel1 <- df[,c('ACR','AGS')]

# now select ACR = 3 & AGS = 6 as logical vector
agricultureLogical <- my.df.sel1[(my.df.sel1$ACR == 3 & my.df.sel1$AGS == 6),]

# result : 125, 238,262
# remove NA
agricultureLogical <- my.df.sel1[complete.cases(my.df.sel1),]

# question 2
library(jpeg)

my.jpg <- readJPEG('getdata_jeff.jpg', native = T)

# 30th & 80th quantile
res <- quantile(my.jpg, probs = c(30, 80)/100)
# res -15259150 -10575416 

# question 3-4

require(plyr)

my.country <- read.csv2('getdata_data_GDP.csv', sep = ',', skip = 4)
my.country.group <- read.csv2('getdata_data_EDSTATS_Country.csv', sep = ',')

# remove the thausand separator
my.country$X.4 <- as.numeric(gsub(',','',my.country$X.4))


# rearange
# my.country <- my.country[,c(1,4,5)]
my.country.group <- my.country.group[,c(1,3)]
my.country <- my.country[1:190,c(1,4,5)]


# rename first column of my.country
colnames(my.country)[1] <- 'CountryCode'

# merge rows by column CountryCode (the only one in both df)
my.final.df <- merge(my.country, my.country.group)
my.combined <- merge(my.country, my.country.group, by.x='V1', by.y='CountryCode', sort=TRUE)
# rank by gdp
my.rank.df <- my.final.df[order(my.final.df$X.4,decreasing = F),]

# add a column with rank
my.rank.df$rank <- seq(1:nrow(my.rank.df))

my.df <- my.rank.df[order(my.rank.df$Income.Group),]

res <- ddply(my.df, .(Income.Group), summarize,  mean_value = mean(rank))

# average GDP ranking for High income OECD

# Res : question 3 : 189, St. Kitts and Nevis
# Res question 4 : 32.9666666667,91.9130434783

# question 5

# cut gdp ranking in 5 separate quantile groups
my.qt <- quantile(my.df$X.4, probs = seq(0,1,0.2), na.rm = T)

df$quantileGDP <- cut(my.df$X.4, breaks = my.qt)

my.res <- my.df[Income.Group == "Lower middle income", .N, by = c("Income.Group", "quantileGDP")]

# res : 5
