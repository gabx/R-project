# $R_PROFILE_USER
# $XDG_HOME_CONFIG/r/Rprofile.r @ hortensia                                          
# Last modified: 2014-08-03

             
# customize prompt
options(prompt=paste(paste (Sys.info () [c ("user", "nodename")], collapse="@"),"[R] "))

# load packages
library(utils)

.First <- function() 
    {	
#print a Welcome message
cat("Welcome back", Sys.getenv("USER"),"\nworking directory is:", getwd(),'\n')
# source helpers
source(Sys.getenv('R_HELPERS'))
}

# User options 
## > options() : list options||style: name=value## 
options(
	digits = 12,
	show.signif.stars=FALSE, 
	stringsAsFactors=FALSE, 
	# error = quote(dump.frames("${R_HOME_USER}/testdump", TRUE)),
	repos=c("http://cran.cnr.Berkeley.edu","http://cran.stat.ucla.edu",
            "http://cran.rstudio.com/"),
	browserNLdisabled = TRUE,
	deparse.max.lines = 2
)

# session info
## retrive user info
ThisUser <- paste(c(Sys.info()["user"], '@', Sys.info()["nodename"]), collapse="")
ThisMachine <- paste(Sys.info()[c ("sysname", "machine", 'release')], 
                      collapse=".")
ThisR <- sessionInfo()[[1]]$version.string


  
# automatically load devtools in interactive sessions
if (interactive()) {
  suppressMessages(require(devtools))
}




.Last <- function(){

	if(interactive()) try(savehistory("/developement/language/r/R.Rhistory"))
	file.append("/developement/language/r/R.Rhistory_old","/developement/language/r/R.Rhistory")
	file.rename("/developement/language/r/R.Rhistory_old","/developement/language/r/R.Rhistory")
	cat('Goodbye', Sys.info()["user"], date())
}









           
	
		 

