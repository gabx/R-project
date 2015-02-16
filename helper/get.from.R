#' This function is part of my helper and is attached to .helperEnv
#' @description get.from.R load data set form a file in a new environment 
#' \code{get.from.R} load data set form a file in a new environment 
getFrom <- function(file, name)
    {
    # file can be a compressed file (?save()) or a connection
    e <- new.env()
    load(file,env=e)
    e[[name]]
    }
    
