pollutantmean <- function(directory,polluant,id = 1:332){
    

# create a list of files in the specdata folder
myFiles <- list.files(directory,pattern="\\d\\d\\d.csv")[id]
    
    
# create a matrix of char & num with named row (Date,sulfate,nitrate,ID)
# as verified by rownames(myMatrix).
# NOTE possible to use ldply from plyr package. Result would be a df class
myMatrix <- sapply(paste(directory,"/",myFiles,sep=""),read.csv2,header=TRUE,dec=".",as.is=T,sep=",")

# select the polluant in an unlist manner
mySel <- unlist(myMatrix[polluant,])

# compute mean ignoring NA and round result with 3 digits
myMean <- round(mean(mySel,na.rm=TRUE),digit = 3)

return(myMean)
    
  
}