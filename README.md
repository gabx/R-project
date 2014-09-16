r-project
=========

My R-project stuff

## R-mkl folder

__R__ built with [Intel MKL library](https://software.intel.com/en-us/intel-mkl) 
and the _iic_ compiler prooved to be much faster than with _gcc_.

Elapsed time in sec from computing 15 tests with default GCC build and icc/MKL build: 

274.93 sec for _GCC build_, 21.01 sec for _icc/MKL build_. More info in this
[post](https://stat.ethz.ch/pipermail/r-help/2014-September/421574.html)



###benchmark.R 

This script is aimed at gauging how fast R is running on your computer. 

```
require(Matrix)
require(SuppDists)
source(benchmark.R)
```


## config folder

Files in my `~/.config/r` directory

* Renviron
* Rprofile.R
* helpers.R


## documentation folder

Collection of useful pdf about R. Beginner and advance, french and english.
