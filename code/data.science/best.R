best <- function(state, outcome){
    
# library(plyr)
library(stringi)
    
# function to read the outcome-of-care-measures.csv file and returns a 
# character vector with the name of the hospital that has the best 
# (i.e. lowest) 30-day mortality for the specified outcome in that state.
    

# modify the outcome argument to match colnames, i.e with a space in place of
# dot and upper cases
my.outcome <- gsub(" ",".",stri_trans_totitle(outcome),fixed=T)
    
# read csv    
my.file <- read.csv2("outcome-of-care-measures_short.csv", header=T, dec=".",
                        sep=",", as.is=T, strip.white=T, 
                        na.strings="Not Available") 

# get col names
my.colnames <- colnames(my.file)


# find columns with "outcome" variable in it 
my.colnames.select <- paste("Hospital.30.Day.Death..Mortality..Rates.from.",
                            my.outcome,sep="")
my.outcome.select <- which(my.colnames.select == my.colnames)


# get list of states 
my.state <- unique(my.file$State)

# test if outcome and list given arguments are valid. If not, stop the function
# with a error message
if (state %in% my.state == FALSE) stop("invalid state")
if (length(my.outcome.select) == 0) stop("invalid outcome")

# keep only data for a selected state
my.state.select <- my.file[my.file$State == state,]
  

## Return hospital name in that state with lowest 30-day death rate
# in case of more than one, keep the 1st one in alphabetci order  


# find the df column with our outcome
my.outcome <- my.state.select[my.outcome.select]

# class first by outcome, then by alphabetical hospital name
my.best <- my.state.select[order(my.outcome,my.state.select$Hospital.Name),]

# return the best hospital
my.hospital <- my.best$Hospital.Name[[1]]
return(my.hospital)
    
    
}
