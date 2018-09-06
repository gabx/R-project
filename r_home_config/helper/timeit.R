#' This function is part of my helper and is attached to .helperEnv

timeit <- function(expr, name=NULL) 
{
    # https://github.com/brendano/dlanalysis/blob/master/util.R
    # print how long the expression takes, and return its value too.
    # So you can interpose timeit({ blabla }) around any chunk of code "blabla".
    start <-  Sys.time()
    ret <-  eval(expr)
    finish <-  Sys.time()
    if (!is.null(name)) cat(name,": ")
    print(finish-start)
    invisible(ret)
}
