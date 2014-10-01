# list of random custom functions 
# /home/.config/r/heleprs.R @ hortensia
# Last modified 2014-09-26
# source with the .First()
# path defined in Renviron config file
##################################


dropNA <- function(data, Var, message = TRUE)
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

################################3
rm.except <- function(keepers, envir = globalenv(), message = TRUE)
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

##########################################
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


##################################
get.from <- function(file, name)
{e=new.env();load(file,env=e);e[[name]]}

###############################
ls.from <- function(file, all.names = FALSE, pattern)
{  e <- new.env()
  	load(file, envir = e)
  	ls(e, all.names = all.names, pattern = pattern)
}


################################
char <- function(expr)
{
    as.character(substitute(expr))  
}

################################
trim.levels <- function(df)
{
    # https://github.com/brendano/dlanalysis/blob/master/util.R
    for (n in names(x))
        if (is.factor(x[,n]))
            x[,n] = trim_levels(x[,n])
    x  
}

###################################
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

#####################################
# https://github.com/brendano/dlanalysis/blob/master/util.R
msg <- function(...) cat(..., "\n", file=stderr())

######################################
showMemoryUse <- function(sort="size", decreasing=FALSE, limit) 
{
    #http://stackoverflow.com/questions/1358003/tricks-to-manage-the-available-memory-in-an-r-session
    objectList <- ls(parent.frame())
    
    oneKB <- 1024
    oneMB <- 1048576
    oneGB <- 1073741824
    
    memoryUse <- sapply(objectList, function(x) as.numeric(object.size(eval(parse(text=x)))))
    
    memListing <- sapply(memoryUse, function(size) {
        if (size >= oneGB) return(paste(round(size/oneGB,2), "GB"))
        else if (size >= oneMB) return(paste(round(size/oneMB,2), "MB"))
        else if (size >= oneKB) return(paste(round(size/oneKB,2), "kB"))
        else return(paste(size, "bytes"))
    })
    
    memListing <- data.frame(objectName=names(memListing),memorySize=memListing,row.names=NULL)
    
    if (sort=="alphabetical") memListing <- memListing[order(memListing$objectName,decreasing=decreasing),] 
    else memListing <- memListing[order(memoryUse,decreasing=decreasing),] #will run if sort not specified or "size"
    
    if(!missing(limit)) memListing <- memListing[1:limit,]
    
    print(memListing, row.names=FALSE)
    return(invisible(memListing))
}

###################################
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

####################################
printenv <- function (env = parent.frame()) 
{
    # https://github.com/klmr/modules/blob/master/printenv.r
    while (! identical(env, baseenv())) {
        name <-  environmentName(env)
        name_display <- sprintf('<environment: %s>', name)
        default_display <- capture.output(env)[1]
        cat(default_display)
        if (name_display != default_display)
            cat(sprintf(' (%s)', name))
        cat('\n')
        env = parent.env(env)
    }
    cat('<environment: base>\n')
}

help.list <- ls('helperEnv')
