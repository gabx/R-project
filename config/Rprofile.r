# $R_PROFILE_USER
# $XDG_HOME_CONFIG/r/Rprofile.r @ hortensia                                          
# Last modified: 2014-08-03

             
# customize prompt
options(prompt=paste(paste (Sys.info () [c ("user", "nodename")], collapse="@"),"[R] "))

# load packages
library(utils)

cat("Welcome back", Sys.getenv("USER"),"\nworking directory is:", getwd(),'\n')

.First <- function() {
  if(interactive()){
    timestamp(,prefix=paste("##------ [",getwd(),"] ",sep=""))
    cat("Welcome back", Sys.getenv("USER"))
    source(Sys.getenv('R_HELPERS'))
  }
}
    	


# User options 
## > options() : list options||style: name=value## 
# Setting 'scipen=10' effectively forces R to never use scientific notation to express very small or large numbers
options(
	digits = 12,
	scipen = 10,
	show.signif.stars = FALSE, 
	stringsAsFactors = FALSE, 
	# error = quote(dump.frames("${R_HOME_USER}/testdump", TRUE)),
	repos=c("http://cran.cnr.Berkeley.edu","http://cran.stat.ucla.edu",
            "http://cran.rstudio.com/"),
	browserNLdisabled = TRUE,
	deparse.max.lines = 2
)

# session info . Make them being hidden
## retrive user info
.ThisUser <- paste(c(Sys.info()["user"], '@', Sys.info()["nodename"]), collapse="")
.ThisMachine <- paste(Sys.info()[c ("sysname", "machine", 'release')], 
                      collapse=".")
.ThisR <- sessionInfo()[[1]]$version.string


  
# automatically load silently some packages in interactive sessions
sshhh <- function(a.package){
  suppressWarnings(suppressPackageStartupMessages(
    library(a.package, character.only=TRUE)))
}
 
auto.loads <-c("dplyr", "ggplot2", "devtools", "reshape",)
 
if(interactive()){
  invisible(sapply(auto.loads, sshhh))
}


.Last <- function(){

	if(interactive()) try(savehistory("/developement/language/r/R.Rhistory"))
	file.append("/developement/language/r/R.Rhistory_old","/developement/language/r/R.Rhistory")
	file.rename("/developement/language/r/R.Rhistory_old","/developement/language/r/R.Rhistory")
	cat('Goodbye', Sys.info()["user"], date(),'\n')
}


message("\n*** Successfully loaded .Rprofile ***\n")






           
	
		 

