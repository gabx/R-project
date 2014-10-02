complete <- function(directory, id = 1:332){
    
library(plyr)    
    
# create a list of files in the specdata folder  
myFiles <- list.files(directory,pattern="\\d\\d\\d.csv")[id]

# create a data.frame with values excepting the Date
myDf <- ldply(paste(directory,"/",myFiles,sep=""),read.csv2,header=TRUE,dec=".",as.is=T,sep=",")[,-1]

# create a function to count how many NA in a df
myFun <- function(df) {
    length(which(!is.na(df[,1] + df[,2])))
}

# split our df by ID in a list of data.frames
spl <- split(myDf,myDf$ID)

# apply our function to each data.frame of the list
myNum <- ldply(spl,myFun)

# sort result in id sequence
attach(myNum)
mySortNum <- myNum[order(id),]

# give col names to our df
colnames(mySortNum) <- c("id","nobs")
detach(myNum)

return(mySortNum)

}


