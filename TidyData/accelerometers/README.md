
# Welcome to Accelerometer project!

This project is part of coursera "Getting and Cleaning Data". This is a peer
assignment.

This whole project has been built using [ProjectTemplate](http://projecttemplate.net)
 and [Rstudio](http://www.rstudio.com/). 

The *codeBook.pdf* has been writed using [Knitr](http://yihui.name/knitr/).


## The Accelerometer project
The goal is to prepare tidy data that can be used for later analysis. You will 
find:

* two tidy data sets as *.csv* files in the **data** directory
* one code book *codeBook.pdf* in the **doc** directory. It describes the variables, 
the data and any work done to perform the data cleaning process. 
* one `run_analysis.R` in the *src* directory

Please find below more info and how to load & deploy the project.


## HOW-TO
```
$ git clone https://github.com/gabx/r-project
$ R
R> setwd(path/to/TidyData)
R> library('ProjectTemplate')
R> load.project()
```

## A quick note about ProjectTemplate
[ProjectTemplate](http://projecttemplate.net)
is an R package that helps you organize your statistical
analysis projects. The package will automate parts of your data analysis project:

* Organizing the files in your project.
* Loading all the R packages you’ll use.
* Loading all of your data sets into memory.
* Munging and preprocessing your data into a form that’s suitable for analysis.

### How it works
```
$ mkdir MyProject
$ R
R> setwd(path/to/MyProject)
R> library('ProjectTemplate')
R> load.project()
```
This above commands will create the whole directory structure for your project.

Most important folders:

* ***config*** : the **global.dcf** configuration file inside
* ***munge*** : this directory will contains every processing scripts. All the 
code is stored here. The scripts will be exectuded sequentially when running 
`load.project()`. Best is then to name it with digits first.
* ***src*** : here is stored the final analysis script.







