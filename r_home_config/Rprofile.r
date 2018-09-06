# $R_PROFILE_USER
# $XDG_CONFIG_HOME/r/Rprofile.r @ daffodil                                          
# Last modified: 2014-09-29

require(utils, quietly = TRUE) 

#------------ Customize prompt --------------
if(interactive()){
	options(prompt=paste(paste (Sys.info () [c ("user", "nodename")], collapse="@"),"[R] "))
}

#------------ Helpers ----------
#' TODO : best approach is to build a package
#' helper directory is defined in Renviron
#' http://stackoverflow.com/questions/26118622/r-user-defined-functions-in-new-environment
#' http://stackoverflow.com/questions/1266279/how-to-organize-large-r-programs
#' Each helper function is an element of .helperEnv
# .helperEnv <- new.env(parent = baseenv())


.helperEnv <- attach(NULL, name = 'helperEnv')


#------------ First function--------------
.First <- function() {
	if(interactive()){
  		cat("Welcome back", Sys.getenv("USER"),"\nworking directory is:", getwd(),'\n')
  	}
	sapply(list.files(file.path(path.expand(Sys.getenv('R_HOME_USER')),
	                            'helper'),full.names = T), source, .helperEnv)

}

#------------ Last function--------------
.Last <- function(){

	if(interactive()) try(savehistory("/developement/language/r/R.Rhistory"))
	file.append("/developement/language/r/R.Rhistory_old","/developement/language/r/R.Rhistory")
	file.rename("/developement/language/r/R.Rhistory_old","/developement/language/r/R.Rhistory")
	cat('Goodbye', Sys.info()["user"], date(),'\n')
	# write current environment to a file
	
}

#------------ Options ----------------------
## > utils::str(options()) : list options||style: name=value## 
# Setting 'scipen=10' effectively forces R to never use scientific notation to express very small or large numbers
options(
	digits = 12,
	scipen = 10,
	continue = '... ',
	width = 80,
	show.signif.stars = FALSE, 
	stringsAsFactors = FALSE, 
	# error = quote(dump.frames("${R_HOME_USER}/testdump", TRUE)),
	repos=list(CRAN="https://cran.rstudio.com/"),
	defaultPackages = c('datasets','utils','grDevices','graphics','stats','methods','data.table','readr'),
	browserNLdisabled = TRUE,
	#deparse.max.lines = 2,
	editor = 'vim',
	pager = 'vimrpager'
)


    	

# ----------- Session info ---------
# retrive user info
.thisUser <- paste(c(Sys.info()["user"], '@', Sys.info()["nodename"]), collapse="")
.thisMachine <- paste(Sys.info()[c ("sysname", "machine", 'release')], 
                      collapse=".")
.thisR <- sessionInfo()[[1]]$version.string


  

# ----------- Load silently packages in interactive sessions -------
suppressWarnings(suppressPackageStartupMessages({
   # library(dplyr)
    library(ggplot2)
    library(devtools)
    library(setwidth)
    library(data.table)
    library(tidyr)
})
)
# ----------- Last --------------------- 
message("\n*** Successfully loaded .Rprofile ***\n")
sessionInfo()





           
	
		 

