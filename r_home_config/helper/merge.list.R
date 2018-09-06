#' This function is part of my helper and is attached to .helperEnv


merge.list <- function(x,y,only.new.y=FALSE,append=FALSE,...)
{
    # http://tolstoy.newcastle.edu.au/R/devel/04/11/1469.html
    out=x
    ystructure = names(c(y,recursive=TRUE))
    xstructure = names(c(x,recursive=TRUE))
    yunique = ystructure[! ystructure %in% xstructure]
    ystructure = sapply(ystructure,FUN=function(element) strsplit(element,"\\."))
    xstructure = sapply(xstructure,FUN=function(element) strsplit(element,"\\."))
    yunique = sapply(yunique,FUN=function(element) strsplit(element,"\\."))
    if (only.new.y)
        lapply(yunique, FUN=function(index) out[[index]]<<-y[[index]])
    else {
        if (!append) {
            lapply(ystructure, FUN=function(index) out[[index]]<<-y[[index]])
        }
        else lapply(ystructure, FUN=function(index) out[[index]]<<-c(out[[index]],y[[index]]))
    }
    return(out)
}
