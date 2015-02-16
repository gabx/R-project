#' Sys.getenv('R_HELPERS')/shut.R
#' This function is part of my helper and is attached to .helperEnv
#' Supress startup messages for a specific list of package 
#' \code{shut} supress startup messages for a package (\code{shut})
#' @param a.list as vector (atomic or list)
#' @example
#' a.list <- as.list(c('ggplot2', 'data.table')) 
#' shut(a.list)
#' @export 
shut <- function(a.list)
{
    sapply(a.list, )    
    suppressWarnings(suppressPackageStartupMessages(
        library(a.list, character.only=TRUE)))
}