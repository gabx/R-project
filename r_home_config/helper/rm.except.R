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
    message("The following objects have been removed:\n")
    message(paste(DeleteObj, collapse = ", "))
  }
}
