#' Path : Sys.getenv('R_HELPERS')/log.R
#' This function is part of my helper and is attached to .helperEnv
#' @description char returns the unevaluated expression as a charcater
#' \code{char} return the expression exp as chacater (\code{char})
#' @param expr any syntactically valid R expression
#' @example 
#' char(ggplot2)
#' [1] "ggplot2"
#' @export 
char <- function(expr){
    as.character(substitute(expr))  
}
