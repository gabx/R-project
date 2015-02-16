#' This function is part of my helper and is attached to .helperEnv

find.replace <- function(data, Var, replaceData, from = 'from', to = 'to', 
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
