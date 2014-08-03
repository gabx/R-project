# list of custom functions


DropNA <- function(data, Var, message = TRUE)
    {

# Drop rows from a data frame with missing values on a given variable(s)
# credits : https://github.com/christophergandrud/DataCombine
# Find term number
DataNames <- names(data)
TestExist <- Var %in% DataNames
if (!all(TestExist)){
stop("Variable(s) not found in the data frame.", call. = FALSE)
}

# Drop if NA
if (length(Var) == 1){
DataNoNA <- data[!is.na(data[, Var]), ]

DataVar <- data[, Var]
DataNA <- DataVar[is.na(DataVar)]
TotalDropped <- length(DataNA)
}
else{
RowNA <- apply(data[, Var], 1, function(x){any(is.na(x))})
DataNoNA <- data[!RowNA, ]

TotalDropped <- sum(RowNA)
}	

  if (isTRUE(message)){
message(paste(TotalDropped, "rows dropped from the data frame." ))
  }
return(DataNoNA)
}

 
rmExcept <- function(keepers, envir = globalenv(), message = TRUE)
    {
    # Remove all objects from a workspace except those specified by the user
    # credits : https://github.com/christophergandrud/DataCombine
    if (class(keepers) != 'character'){
        stop('The keepers argument must be a character vector.', call. = FALSE)
    }
    DeleteObj <- setdiff(ls(envir = envir), keepers)
    rm(list = DeleteObj, envir = envir)
    if (isTRUE(message)){
        message("Removed the following objects:\n")
        message(paste(DeleteObj, collapse = ", "))
    }
}

FindReplace <- function(data, Var, replaceData, from = 'from', to = 'to', 
                        exact = TRUE, vector = FALSE)
    {
    # Replace multiple patterns found in a character string column of a data frame
    # credits : https://github.com/christophergandrud/DataCombine
    if(!(class(data[, Var]) %in% c('character', 'factor'))){
        stop(paste(Var, 'is not a character string or factor. Please convert to 
                   a character string or factor and then rerun.'),
             call. = FALSE)
    }
    if (isTRUE(exact)){
        message('Only exact matches will be replaced.')
    }
    
    ReplaceNRows <- nrow(replaceData)
    
    for (i in 1:ReplaceNRows){
        if(isTRUE(exact)){
            data[, Var] <- gsub(pattern = paste0("^", replaceData[i, from], "$"), replacement = replaceData[i, to], data[, Var])
        }
        if(!isTRUE(exact)){
            data[, Var] <- gsub(pattern = replaceData[i, from], replacement = replaceData[i, to], data[, Var])
        }
    }
    if(isTRUE(vector)){
        data <- data[, Var]
    }
    return(data)
}


clean <- function()
    {
    rm(list = ls())}