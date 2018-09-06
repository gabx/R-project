#' Path : Sys.getenv('R_HELPERS')/log.R
#' This function is part of my helper and is attached to .helperEnv
#' @description log warnings and errors to file with sink()
#' @export 

log <- function(){
    # use the current directory for the file
    myLog <- file("R-logs", open="wt")
    sink(myLog)
    sink(myLog, append = T, type="message")
    try(log("a"))
    # back to console
    sink(type = message)
    sink()
}







