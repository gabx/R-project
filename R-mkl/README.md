#R-intel.spec#

This is the **.spec** file to build R with Intel Parallel studio 2016 on Fedora 23.It
allows you to build and install a **.rpm** package for your OS. Please visit [Fedora
RPM How-To](https://fedoraproject.org/wiki/How_to_create_an_RPM_package#.25files_section)
for instructions.

The file is a variation of the Fedora [R meta package](http://pkgs.fedoraproject.org/cgit/R.git) maintained by Tom Callaway <spot@fedoraproject.org>.
Part of the build and install sections have been modified.

The current release, _R-intel-3.2.2-3.fc23.x86_64_, may contain some minor bugs, even if it builds, installs 
and run fine. A lot of checks are done at build time and they must leave you with a set of working R packages.

##NOTE

* the build is only for Fedora >= 22 on X86_64
* the build needs Intel Parallel Studio 2016. In case of older version, path has to be changed
* `make check-all` is used. It checks lots of package, thus lenghtening seriously build time. 
To shorten it, please use `make check`
* for convenience, R config files are gathered in `/etc/R`
* NO **X** server is configured. Please remove `--without-x` in the `%configure` section
* R, blas and lapack librairies are all built as shared objects
* optimization flags are set. Please visit [Intel Optimization guide](https://software.intel.com/en-us/node/583493)
for details

##TO DO
* adapt to Fedora < 22
* adapt to Intel advisor 2015
* adapt to use gcc and not ICC if desired


#Benchmark results#

They are obtained by running the `benchmark.R` file. The original work can be found
[here](http://r.research.att.com/benchmarks/).

##Operating System##

R 3.1.1 built with iic/MKL on [Archlinux](https://www.archlinux.org/) 

The folowing compiler options have been applied at build time :

```
   mkllibs=" -fopenmp -Wl,--no-as-needed -L${_mkllibpath} -l${_intel_lib} 
   -lmkl_core -lmkl_gnu_thread -ldl -lpthread -lm"
      ./configure  --prefix=/usr \
    	--libdir=/usr/lib \
		--sysconfdir=/etc/R \
		--datarootdir=/usr/share \
		  rsharedir=/usr/share/R/ \
		  rincludedir=/usr/include/R/ \
		  rdocdir=/usr/share/doc/R/ \
		--with-x \
		--enable-R-shlib \
		--with-blas="${mkllibs}" \
		--with-lapack \
		F77=gfortran \
		LIBnn=lib
        
        
export CC="icc"
export CXX="icpc"
export AR="xiar"
export LD="xild"

export CFLAGS="-Wall -Ofast -funsafe-loop-optimizations -ipo -openmp -xHost 
-Wno-fstrict-aliasing"
export CXXFLAGS="-Wall -Ofast -ipo -funsafe-loop-optimizations -openmp -xHost 
-Wno-fstrict-aliasing -march=native -flto"
```

##Hardware##

CPU op-mode(s): 32-bit, 64-bit Byte Order: Little Endian CPU(s): 8 Thread(s) per 
core: 2 Vendor ID: GenuineIntel Model name: Intel(R) Core(TM) i7-2600K CPU @ 3.40GHz

```
Number of times each test is run__________________________:  3

   I. Matrix Calculation
   ----------------------

Creation, transp., deformation of a 2500x2500 matrix (sec):  0.741666666666636 
2400x2400 normal distributed random matrix ^1000____ (sec):  0.542333333333355 
Sorting of 7,000,000 random values__________________ (sec):  0.60766666666666 
2800x2800 cross-product matrix (b = a' * a)_________ (sec):  0.272999999999987 
Linear regr. over a 3000x3000 matrix (c = a \ b')___ (sec):  0.139666666666699 
                      --------------------------------------------
                 Trimmed geom. mean (2 extremes eliminated):  0.448089519716311 

   II. Matrix functions
   --------------------
FFT over 2,400,000 random values____________________ (sec):  0.386333333333331 
Eigenvalues of a 640x640 random matrix______________ (sec):  0.279999999999973 
Determinant of a 2500x2500 random matrix____________ (sec):  0.242333333333325 
Cholesky decomposition of a 3000x3000 matrix________ (sec):  0.162999999999973 
Inverse of a 1600x1600 random matrix________________ (sec):  0.155333333333336 
                      --------------------------------------------
                Trimmed geom. mean (2 extremes eliminated):  0.222802262818921 

   III. Programmation
   ------------------
3,500,000 Fibonacci numbers calculation (vector calc)(sec):  0.544666666666672 
Creation of a 3000x3000 Hilbert matrix (matrix calc) (sec):  0.217666666666673 
Grand common divisors of 400,000 pairs (recursion)__ (sec):  0.839333333333343 
Creation of a 500x500 Toeplitz matrix (loops)_______ (sec):  0.290333333333365 
Escoufier's method on a 45x45 matrix (mixed)________ (sec):  0.319999999999936 
                      --------------------------------------------
                Trimmed geom. mean (2 extremes eliminated):  0.369878617218732 


Total time for all 15 tests_________________________ (sec):  5.74333333333326 
Overall mean (sum of I, II and III trimmed means/3)_ (sec):  0.33300278809093 

                      --- End of test ---
```
