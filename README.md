r-project
=========

My R-project stuff

## littler
[http://dirk.eddelbuettel.com/code/littler.html]{littler} provides a simplified command line to R. This allows direct execution of commands.

### install littler
install littler using the R cran package:
```
R> install.packages('littler')
```

### configure
The binary **r** has been installed in ```$R_LIBS_USER/littler/bin```. Create symbolic link
to ```/usr/local/bin/r``` and alias in zsh cconfig as **r** is a built-in command in zsh.

### run
Example of small script to upgrade R packages outside any R session:

```
#!/usr/bin/env r 
#
# a simple example to update packages 
# parameters are easily adjustable

repos <- "http://cran.us.r-project.org"

lib.loc <- "/developement/language/r/library"

update.packages(repos=repos, ask=FALSE, lib.loc=lib.loc)
```

## R-mkl 

__R__ built with [Intel MKL library](https://software.intel.com/en-us/intel-mkl) 
and the _iic_ compiler prooved to be much faster than with _gcc_.

Elapsed time in sec from computing 15 tests with default GCC build and icc/MKL build: 

274.93 sec for _GCC build_, 21.01 sec for _icc/MKL build_. More info in this
[post](https://stat.ethz.ch/pipermail/r-help/2014-September/421574.html)

### Build R with Intel ICC compiler and MKL
This is a very basic script to build [R cran](https://cran.r-project.org/) with Intel 2016 Parallel studio shared libraries. The script has to be executed in the source directory.

```
#! /bin/sh

source /opt/intel/compilers_and_libraries_2016.0.109/linux/mkl/bin/mklvars.sh intel64
source /opt/intel/bin/compilervars.sh intel64

_mkllibpath=${MKLROOT}/lib/intel64

MKL=" -L${_mkllibpath} -lmkl_rt -lpthread"

export CC="icc"
export CXX="icpc"
export AR="xiar"
export LD="xild"
export F77="ifort"

export CFLAGS="-g -O3 -xHost -I${MKLROOT}/include"
export CXXFLAGS="-g -O3 -xHost -I${MKLROOT}/include"
export FFLAGS="-I${MKLROOT}/include"
export FCFLAGS="-I${MKLROOT}/include"

./configure --with-blas="${MKL}" --with-lapack 

make -j4
```

#### Build for Fedora x86_64
Use the ```R-mkl/R-intel.spec``` file as a template to build a **.rpm** package for **FEDORA x86_64** >= 22.

###benchmark.R 

This script is aimed at gauging how fast R is running on your computer. 

```
require(Matrix)
require(SuppDists)
source(benchmark.R)
```
## R-studio-server
Use the ```R-studio-server/rstudio-server.spec``` file as a template to build a **.rpm** package for **FEDORA x86_64** >= 22.

## code
* Random code from Coursera Data Science
* R-slacklog: code to fetch history from [Slack](http://www.slack.com) channel; clean, sort and tidy data; store the data in a DB

## config 
A collection fo files in my `~/.config/r` directory on a Archlinux machine. On this machine, most
program config files are gathered in the `$XDG_HOME_CONFIG` folder.

* Renviron

A very few basic *var:value* lines. 

* Rprofile.R

This file is sourced at R start-up. It has grown and improved over time.

## documentation 
A collection of useful documentations in *.pdf* format . Beginner and advance, french and english.

## helper
A random collection of short code to help daily work in `R`. To load these functions
and avoid to pollute top-level namespace, best is to build a `R package` . I prefere
a lightweight alternative : source the `helper.R` script in a dedicated environment.
See `?sys.source`, `?new.env` and this [stackoverfolw thread](http://stackoverflow.com/questions/1266279/how-to-organize-large-r-programs)
for more info.

