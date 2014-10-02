corr <- function(directory, threshold = 0) {
    myReadCsv <- function(i) {
        fileName <- sprintf("%03d.csv", i)
        read.csv(fileName)        
    }
    
    myCorr <- function(i) {
        temp <- myReadCsv(i)
        good <- complete.cases(temp$sulfate, temp$nitrate)
        if (sum(good) > threshold) {
            temp <- temp[good,]
            cor(temp$sulfate, temp$nitrate)
        } else {
            NA
        }
    }
    
    numFiles <- 332
    result <- sapply(1:numFiles, myCorr)
    result[!is.na(result)]

}
