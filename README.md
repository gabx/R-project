r-project
=========

My R-project stuff


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

_icclibpath=/opt/intel/compilers_and_lbraries_2016.0.109/linux/compiler/lib/intel64
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
```

###benchmark.R 

This script is aimed at gauging how fast R is running on your computer. 

```
require(Matrix)
require(SuppDists)
source(benchmark.R)
```

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

