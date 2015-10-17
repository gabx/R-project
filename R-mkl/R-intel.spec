%define java_arch amd64
%global _sysconfdir /etc/R  

Name: R-intel
Version: 3.2.2
Release: 2%{?dist}
Summary: A language for data analysis and graphics
URL: http://www.r-project.org
Source0: ftp://cran.r-project.org/pub/R/src/base/R-3/R-%{version}.tar.gz
License: GPLv2+
Group: Applications/Engineering
BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
BuildRequires: gcc-gfortran
BuildRequires: gcc-c++, tex(latex), texinfo, texinfo-tex  
BuildRequires: libpng-devel, libjpeg-turbo-devel, readline-devel
BuildRequires: tcl-devel, tk-devel, ncurses-devel
BuildRequires: pcre-devel, zlib-devel
BuildRequires: libcurl-devel
BuildRequires: valgrind-devel
BuildRequires: java-headless
BuildRequires: tre-devel
BuildRequires: autoconf, automake, libtool
BuildRequires: libSM-devel, libICE-devel, libXt-devel
BuildRequires: bzip2-devel, libtiff-devel
BuildRequires: gcc-objc, xz-devel
BuildRequires: libicu-devel
BuildRequires: less
BuildRequires: tex(inconsolata.sty)
BuildRequires: tex(upquote.sty)
BuildRequires: lapack
Conflicts: R
# R-devel will pull in R-core
Requires: R-intel-devel = %{version}-%{release}
# libRmath-devel will pull in libRmath
Requires: libRmath-intel-devel = %{version}-%{release}
# Pull in Java bits (if you don't want this, use R-core)
Requires: R-intel-java = %{version}-%{release}

%description
This is a metapackage that provides both core R userspace and 
all R development components build with Intel compiler and Intel MKL.
R is a language and environment for statistical computing and graphics. 
R is similar to the award-winning S system, which was developed at 
Bell Laboratories by John Chambers et al. It provides a wide 
variety of statistical and graphical techniques (linear and
nonlinear modelling, statistical tests, time series analysis,
classification, clustering, ...).
R is designed as a true computer language with control-flow
constructions for iteration and alternation, and it allows users to
add additional functionality by defining new functions. For
computationally intensive tasks, C, C++ and Fortran code can be linked
and called at run time.

%package core
Summary: The minimal R components necessary for a functional runtime
Group: Applications/Engineering
Requires: xdg-utils, cups
Requires: tex(dvips), vi
Requires: perl, sed, gawk, tex(latex), less, make, unzip
# needed to remove dependencie failures as Intel Parallel studio does not provide the installed libraries
AutoReqProv: no
BuildRequires: intel-ifort-l-ps-109
BuildRequires: intel-mkl-109
# These are the submodules that R-core provides. Sometimes R modules say they
# depend on one of these submodules rather than just R. These are provided for 
# packager convenience.
Provides: R-base = %{version}
Provides: R-boot = 1.3.17
Provides: R-class = 7.3.13
Provides: R-cluster = 2.0.3
Provides: R-codetools = 0.2.14
Provides: R-datasets = %{version}
Provides: R-foreign = 0.8.65
Provides: R-graphics = %{version}
Provides: R-grDevices = %{version}
Provides: R-grid = %{version}
Provides: R-KernSmooth = 2.23.15
Provides: R-lattice = 0.20.33
Provides: R-MASS = 7.3.43
Provides: R-Matrix = 1.2.2
#Obsoletes: R-Matrix < 0.999375-7
Provides: R-methods = %{version}
Provides: R-mgcv = 1.8.7
Provides: R-nlme = 3.1.121
Provides: R-nnet = 7.3.10
Provides: R-parallel = %{version}
Provides: R-rpart = 4.1.10
Provides: R-spatial = 7.3.10
Provides: R-splines = %{version}
Provides: R-stats = %{version}
Provides: R-stats4 = %{version}
Provides: R-survival = 2.38.3
Provides: R-tcltk = %{version}
Provides: R-tools = %{version}
Provides: R-utils = %{version}
Conflicts: R-core

%description core
A language and environment for statistical computing and graphics.
R is similar to the award-winning S system, which was developed at
Bell Laboratories by John Chambers et al. It provides a wide
variety of statistical and graphical techniques (linear and
nonlinear modelling, statistical tests, time series analysis,
classification, clustering, ...).
R is designed as a true computer language with control-flow
constructions for iteration and alternation, and it allows users to
add additional functionality by defining new functions. For
computationally intensive tasks, C, C++ and Fortran code can be linked
and called at run time.

%package core-devel
Summary: Core files for development of R packages (no Java)
Group: Applications/Engineering
Requires: R-core = %{version}-%{release}
# You need all the BuildRequires for the development version
Requires: gcc-c++, gcc-gfortran, tex(latex), texinfo, texinfo-tex
Requires: bzip2-devel, pcre-devel, zlib-devel
Requires: tcl-devel, tk-devel, pkgconfig, xz-devel
Requires: libicu-devel
Requires: tre-devel
# TeX files needed
Requires: tex(ecrm1000.tfm)
Requires: tex(inconsolata.sty)
Requires: tex(ptmr8t.tfm)
Requires: tex(ptmb8t.tfm)
Requires: tex(pcrr8t.tfm)
Requires: tex(phvr8t.tfm)
Requires: tex(ptmri8t.tfm)
Requires: tex(ptmro8t.tfm)
Requires: tex(cm-super-ts1.enc)
Provides: R-Matrix-devel = 1.2.2
Obsoletes: R-Matrix-devel < 0.999375-7
Conflicts: R-core-devel

%description core-devel
Install R-core-devel if you are going to develop or compile R packages.
This package does not configure the R environment for Java, install
R-java-devel if you want this.

%package devel
Summary: Full R development environment metapackage
Requires: R-core-devel = %{version}-%{release}
Requires: R-java-devel = %{version}-%{release}
Conflicts: R-devel

%description devel
This is a metapackage to install a complete (with Java) R development
environment.

%package java
Summary: R with Fedora provided Java Runtime Environment
Group: Applications/Engineering
Requires(post): R-core = %{version}-%{release}
Requires(post): java-headless
Conflicts: R-java

%description java
A language and environment for statistical computing and graphics.
R is similar to the award-winning S system, which was developed at
Bell Laboratories by John Chambers et al. It provides a wide
variety of statistical and graphical techniques (linear and
nonlinear modelling, statistical tests, time series analysis,
classification, clustering, ...).
R is designed as a true computer language with control-flow
constructions for iteration and alternation, and it allows users to
add additional functionality by defining new functions. For
computationally intensive tasks, C, C++ and Fortran code can be linked
and called at run time.
This package also has an additional dependency on java, as provided by
Fedora's openJDK.

%package java-devel
Summary: Development package for use with Java enabled R components
Group: Applications/Engineering
Requires(post): R-core-devel = %{version}-%{release}
Requires(post): java-devel
Conflicts: R-java-devel

%description java-devel
Install R-java-devel if you are going to develop or compile R packages
that assume java is present and configured on the system.

%package -n libRmath-intel
Summary: Standalone math library from the R project
Group: Development/Libraries
AutoReqProv: no
BuildRequires: intel-ifort-l-ps-109
BuildRequires: intel-mkl-109
Conflicts: libRmath

%description -n libRmath-intel
A standalone library of mathematical and statistical functions derived
from the R project.  This package provides the shared libRmath library.

%package -n libRmath-intel-devel
Summary: Headers from the R Standalone math library
Group: Development/Libraries
Requires: libRmath-intel = %{version}-%{release}, pkgconfig
BuildRequires: intel-openmp-l-all-109
Conflicts: libRmath-devel
%description -n libRmath-intel-devel
A standalone library of mathematical and statistical functions derived
from the R project.  This package provides the libRmath header files.

%package -n libRmath-intel-static
Summary: Static R Standalone math library
Group: Development/Libraries
Requires: libRmath-devel-intel = %{version}-%{release}
Conflicts: libRmath-static
%description -n libRmath-intel-static
A standalone library of mathematical and statistical functions derived
from the R project.  This package provides the static libRmath library.

%prep
%setup -qn R-%{version}
%global _builddir_full %{_builddir}/R-%{version}

cat <<EOF > %{name}-prov
#!/bin/sh
%{__perl_provides} \
| grep -v 'File::Copy::Recursive' | grep -v 'Text::DelimMatch'
EOF
%define __perl_provides %{_builddir}/R-%{version}/%{name}-prov
chmod +x %{__perl_provides}

# Filter unwanted Requires:
cat << \EOF > %{name}-req
#!/bin/sh
%{__perl_requires} \
| grep -v 'perl(Text::DelimMatch)'
EOF
%define __perl_requires %{_builddir}/R-%{version}/%{name}-req
chmod +x %{__perl_requires}

# needed by sysconfdir
mkdir -p %{_builddir_full}/etc/R 

%build
# Add PATHS to Renviron for R_LIBS_SITE
echo 'R_LIBS_SITE=${R_LIBS_SITE-'"'/usr/local/lib/R/site-library:/usr/local/lib/R/library:%{_libdir}/R/library:%{_datadir}/R/library'"'}' >> etc/Renviron.in
## Intel MKL and ICC
# Setup the environment for MKL and Intel compiler
source /opt/intel/bin/compilervars.sh intel64
%global _mkllibpath ${MKLROOT}/lib/intel64/
%global _icclibpath /opt/intel/compilers_and_libraries_linux/lib/intel64

%define R_PDFVIEWER %{_bindir}/xdg-open
%define R_PRINTCMD lpr
%define R_BROWSER %{_bindir}/xdg-open

# Use Intel compiler
export CC="icc"
export F77="ifort"
export FC="ifort"
export CXX="icpc"
export AR="xiar"
export LD="xild"

MKL=" -L%{_mkllibpath} -lmkl_rt -lpthread"

# Export build flags
export LDFLAGS="${LDFLAGS} -L%{_icclibpath}"
export MAIN_LDFLAGS="-qopenmp"
export CFLAGS="-O3 -ipo -wd188 -qopenmp -qopt-mem-layout-trans=3 -xHost -I${MKLROOT}/include"
export CXXFLAGS="-O3 -ipo -wd188 -qopenmp -qopt-mem-layout-trans=3 -xHost -I${MKLROOT}/include"
export FFLAGS="-O3 -ipo -qopenmp -qopt-mem-layout-trans=3 -xHost -I${MKLROOT}/include"
export FCFLAGS="-O3 -ipo -wd188 -qopenmp -qopt-mem-layout-trans=3 -xHost -I${MKLROOT}/include"


%configure \
    --with-system-tre \
    --with-system-zlib --with-system-bzlib --with-system-pcre \
    --with-system-valgrind-headers \
    --with-blas="$MKL" \
    --without-x \
    --disable-byte-compiled-packages \
    --with-tcl-config=%{_libdir}/tclConfig.sh \
    --with-tk-config=%{_libdir}/tkConfig.sh \
    --enable-R-shlib \
    --enable-memory-profiling \
    --enable-BLAS-shlib \
    --enable-prebuilt-html \
    rdocdir=/usr/share/doc/R\
    rincludedir=%{_includedir}/R \
    rsharedir=%{_datadir}/R \
> CONFIGURE.log

make %{?_smp_mflags}
make %{?_smp_mflags} MAKEINFO=texi2any pdf
make %{?_smp_mflags} MAKEINFO=texi2any info
# Make standalone Rmath library
(cd src/nmath/standalone; make %{?_smp_mflags})
# Convert to UTF-8
for i in doc/manual/R-intro.info doc/manual/R-FAQ.info doc/FAQ doc/manual/R-admin.info doc/manual/R-exts.info-1; do
  iconv -f iso-8859-1 -t utf-8 -o $i{.utf8,}
  mv $i{.utf8,}
done

%install
make DESTDIR=%{buildroot} install install-info
make DESTDIR=%{buildroot} install-pdf
make DESTDIR=%{buildroot} install-tests 

rm -f %{buildroot}%{_infodir}/dir

# install libRmath.so
(cd src/nmath/standalone; make install DESTDIR=%{buildroot})
# Install R.conf
mkdir -p %{buildroot}/etc/ld.so.conf.d
echo "%{_libdir}/R/lib" > %{buildroot}/etc/ld.so.conf.d/R-x86_64.conf
  
mkdir -p %{buildroot}%{_datadir}/R/library
  
# Fixup R wrapper scripts.
sed -i "s|%{buildroot} ||" "%{buildroot}/usr/bin/R"
rm "%{buildroot}/usr/lib64/R/bin/R"
cd "%{buildroot}/usr/lib64/R/bin"
ln -s ../../../bin/R


# Fix html/packages.html
# We can safely use RHOME here, because all of these are system packages.
sed -i 's|\..\/\..|%{_libdir}/R|g' %{buildroot}%{_defaultdocdir}/R/html/packages.html
for i in %{buildroot}%{_libdir}/R/library/*/html/*.html; do
  sed -i 's|\..\/\..\/..\/doc|%{_defaultdocdir}/R|g' $i
done

# Fix exec bits
chmod +x %{buildroot}%{_datadir}/R/sh/echo.sh

# Symbolic link for convenience
pushd %{buildroot}%{_libdir}/R
ln -s ../../include/R include
popd

# move configuration files to /etc
mkdir -p %{buildroot}/etc/R/
cd %{buildroot}/usr/lib64/R/etc    
install -d %{buildroot}/etc/R/
cd %{buildroot}/usr/lib64/R/etc
for i in *; do
    mv -f ${i} "%{buildroot}/etc/R"
    ln -s /etc/R/${i} ${i}
done


# Symbolic link for LaTeX
mkdir -p %{buildroot}/usr/share/texmf/tex/latex
pushd %{buildroot}/usr/share/texmf/tex/latex
ln -s ../../../R/texmf/tex/latex R
popd


%check
# uncommand/command below lines to make a basic check
# make check
make check-all

%files
# Metapackage
%files core
%defattr(-, root, root, -)
%{_bindir}/R
%{_bindir}/Rscript
%{_datadir}/R/
%{_datadir}/texmf/
# Have to break this out for the translations
%dir %{_libdir}/R/
%{_libdir}/R/tests/
%{_libdir}/R/bin/
%dir %{_libdir}/R/etc
%{_libdir}/R/etc/Makeconf
%{_libdir}/R/etc/Renviron
%{_libdir}/R/etc/javaconf
%{_libdir}/R/etc/ldpaths
%{_libdir}/R/etc/repositories
%{_libdir}/R/lib/
%dir %{_libdir}/R/library/
%dir %{_libdir}/R/library/translations/
%{_libdir}/R/library/translations/DESCRIPTION
%lang(da) %{_libdir}/R/library/translations/da/
%lang(de) %{_libdir}/R/library/translations/de/
%lang(en) %{_libdir}/R/library/translations/en*/
%lang(es) %{_libdir}/R/library/translations/es/
%lang(fa) %{_libdir}/R/library/translations/fa/
%lang(fr) %{_libdir}/R/library/translations/fr/
%lang(it) %{_libdir}/R/library/translations/it/
%lang(ja) %{_libdir}/R/library/translations/ja/
%lang(ko) %{_libdir}/R/library/translations/ko/
%lang(nn) %{_libdir}/R/library/translations/nn/
%lang(pl) %{_libdir}/R/library/translations/pl/
%lang(pt) %{_libdir}/R/library/translations/pt*/
%lang(ru) %{_libdir}/R/library/translations/ru/
%lang(tr) %{_libdir}/R/library/translations/tr/
%lang(zh) %{_libdir}/R/library/translations/zh*/
# base
%{_libdir}/R/library/base/
# boot
%dir %{_libdir}/R/library/boot/
%{_libdir}/R/library/boot/bd.q
%{_libdir}/R/library/boot/CITATION
%{_libdir}/R/library/boot/data/
%{_libdir}/R/library/boot/DESCRIPTION
%{_libdir}/R/library/boot/help/
%{_libdir}/R/library/boot/html/
%{_libdir}/R/library/boot/INDEX
%{_libdir}/R/library/boot/Meta/
%{_libdir}/R/library/boot/NAMESPACE
%{_libdir}/R/library/boot/tests/
%dir %{_libdir}/R/library/boot/po/
%lang(de) %{_libdir}/R/library/boot/po/de/
%lang(en) %{_libdir}/R/library/boot/po/en*/
%lang(fr) %{_libdir}/R/library/boot/po/fr/
%lang(ko) %{_libdir}/R/library/boot/po/ko/
%lang(pl) %{_libdir}/R/library/boot/po/pl/
%lang(ru) %{_libdir}/R/library/boot/po/ru/
%{_libdir}/R/library/boot/R/
# class
%dir %{_libdir}/R/library/class/
%{_libdir}/R/library/class/CITATION
%{_libdir}/R/library/class/DESCRIPTION
%{_libdir}/R/library/class/help/
%{_libdir}/R/library/class/html/
%{_libdir}/R/library/class/INDEX
%{_libdir}/R/library/class/libs/
%{_libdir}/R/library/class/Meta/
%{_libdir}/R/library/class/NAMESPACE
%{_libdir}/R/library/class/NEWS
%dir %{_libdir}/R/library/class/po/
%lang(de) %{_libdir}/R/library/class/po/de/
%lang(en) %{_libdir}/R/library/class/po/en*/
%lang(fr) %{_libdir}/R/library/class/po/fr/
%lang(ko) %{_libdir}/R/library/class/po/ko/
%lang(pl) %{_libdir}/R/library/class/po/pl/
%{_libdir}/R/library/class/R/
# cluster
%dir %{_libdir}/R/library/cluster/
%{_libdir}/R/library/cluster/CITATION
%{_libdir}/R/library/cluster/data/
%{_libdir}/R/library/cluster/DESCRIPTION
%{_libdir}/R/library/cluster/help/
%{_libdir}/R/library/cluster/html/
%{_libdir}/R/library/cluster/INDEX
%{_libdir}/R/library/cluster/libs/
%{_libdir}/R/library/cluster/Meta/
%{_libdir}/R/library/cluster/NAMESPACE
%{_libdir}/R/library/cluster/NEWS.Rd
%{_libdir}/R/library/cluster/R/
%{_libdir}/R/library/cluster/tests/
%dir %{_libdir}/R/library/cluster/po/
%lang(de) %{_libdir}/R/library/cluster/po/de/
%lang(en) %{_libdir}/R/library/cluster/po/en*/
%lang(fr) %{_libdir}/R/library/cluster/po/fr/
%lang(ko) %{_libdir}/R/library/cluster/po/ko/
%lang(pl) %{_libdir}/R/library/cluster/po/pl/
# codetools
%dir %{_libdir}/R/library/codetools/
%{_libdir}/R/library/codetools/DESCRIPTION
%{_libdir}/R/library/codetools/help/
%{_libdir}/R/library/codetools/html/
%{_libdir}/R/library/codetools/INDEX
%{_libdir}/R/library/codetools/Meta/
%{_libdir}/R/library/codetools/NAMESPACE
%{_libdir}/R/library/codetools/R/
%{_libdir}/R/library/codetools/tests/
# compiler
%{_libdir}/R/library/compiler/
# datasets
%{_libdir}/R/library/datasets/
# foreign
%dir %{_libdir}/R/library/foreign/
%{_libdir}/R/library/foreign/COPYRIGHTS
%{_libdir}/R/library/foreign/DESCRIPTION
%{_libdir}/R/library/foreign/files/
%{_libdir}/R/library/foreign/help/
%{_libdir}/R/library/foreign/html/
%{_libdir}/R/library/foreign/INDEX
%{_libdir}/R/library/foreign/libs/
%{_libdir}/R/library/foreign/Meta/
%{_libdir}/R/library/foreign/NAMESPACE
%{_libdir}/R/library/foreign/tests/
%dir %{_libdir}/R/library/foreign/po/
%lang(de) %{_libdir}/R/library/foreign/po/de/
%lang(en) %{_libdir}/R/library/foreign/po/en*/
%lang(fr) %{_libdir}/R/library/foreign/po/fr/
%lang(pl) %{_libdir}/R/library/foreign/po/pl/
%{_libdir}/R/library/foreign/R/
# graphics
%{_libdir}/R/library/graphics/
# grDevices
%{_libdir}/R/library/grDevices
# grid
%{_libdir}/R/library/grid/
# KernSmooth
%dir %{_libdir}/R/library/KernSmooth/
%{_libdir}/R/library/KernSmooth/DESCRIPTION
%{_libdir}/R/library/KernSmooth/help/
%{_libdir}/R/library/KernSmooth/html/
%{_libdir}/R/library/KernSmooth/INDEX
%{_libdir}/R/library/KernSmooth/libs/
%{_libdir}/R/library/KernSmooth/Meta/
%{_libdir}/R/library/KernSmooth/NAMESPACE
%{_libdir}/R/library/KernSmooth/tests
%dir %{_libdir}/R/library/KernSmooth/po/
%lang(de) %{_libdir}/R/library/KernSmooth/po/de/
%lang(en) %{_libdir}/R/library/KernSmooth/po/en*/
%lang(fr) %{_libdir}/R/library/KernSmooth/po/fr/
%lang(ko) %{_libdir}/R/library/KernSmooth/po/ko/
%lang(pl) %{_libdir}/R/library/KernSmooth/po/pl/
%{_libdir}/R/library/KernSmooth/R/
# lattice
%dir %{_libdir}/R/library/lattice/
%{_libdir}/R/library/lattice/CITATION
%{_libdir}/R/library/lattice/data/
%{_libdir}/R/library/lattice/demo/
%{_libdir}/R/library/lattice/DESCRIPTION
%{_libdir}/R/library/lattice/help/
%{_libdir}/R/library/lattice/html/
%{_libdir}/R/library/lattice/INDEX
%{_libdir}/R/library/lattice/libs/
%{_libdir}/R/library/lattice/Meta/
%{_libdir}/R/library/lattice/NAMESPACE
%{_libdir}/R/library/lattice/NEWS
%{_libdir}/R/library/lattice/tests/
%dir %{_libdir}/R/library/lattice/po/
%lang(de) %{_libdir}/R/library/lattice/po/de/
%lang(en) %{_libdir}/R/library/lattice/po/en*/
%lang(fr) %{_libdir}/R/library/lattice/po/fr/
%lang(ko) %{_libdir}/R/library/lattice/po/ko/
%lang(pl) %{_libdir}/R/library/lattice/po/pl*/
%{_libdir}/R/library/lattice/R/
# MASS
%dir %{_libdir}/R/library/MASS/
%{_libdir}/R/library/MASS/CITATION
%{_libdir}/R/library/MASS/data/
%{_libdir}/R/library/MASS/DESCRIPTION
%{_libdir}/R/library/MASS/help/
%{_libdir}/R/library/MASS/html/
%{_libdir}/R/library/MASS/INDEX
%{_libdir}/R/library/MASS/libs/
%{_libdir}/R/library/MASS/Meta/
%{_libdir}/R/library/MASS/NAMESPACE
%{_libdir}/R/library/MASS/NEWS
%{_libdir}/R/library/MASS/tests/
%dir %{_libdir}/R/library/MASS/po
%lang(de) %{_libdir}/R/library/MASS/po/de/
%lang(en) %{_libdir}/R/library/MASS/po/en*/
%lang(fr) %{_libdir}/R/library/MASS/po/fr/
%lang(ko) %{_libdir}/R/library/MASS/po/ko/
%lang(pl) %{_libdir}/R/library/MASS/po/pl/
%{_libdir}/R/library/MASS/R/
%{_libdir}/R/library/MASS/scripts/
# Matrix
%dir %{_libdir}/R/library/Matrix/
%{_libdir}/R/library/Matrix/Copyrights
%{_libdir}/R/library/Matrix/data/
%{_libdir}/R/library/Matrix/doc/
%{_libdir}/R/library/Matrix/DESCRIPTION
%{_libdir}/R/library/Matrix/Doxyfile
%{_libdir}/R/library/Matrix/external/
%{_libdir}/R/library/Matrix/help/
%{_libdir}/R/library/Matrix/html/
%{_libdir}/R/library/Matrix/include/
%{_libdir}/R/library/Matrix/INDEX
%{_libdir}/R/library/Matrix/libs/
%{_libdir}/R/library/Matrix/Meta/
%{_libdir}/R/library/Matrix/NAMESPACE
%{_libdir}/R/library/Matrix/NEWS.Rd
%{_libdir}/R/library/Matrix/tests
%dir %{_libdir}/R/library/Matrix/po/
%lang(de) %{_libdir}/R/library/Matrix/po/de/
%lang(en) %{_libdir}/R/library/Matrix/po/en*/
%lang(fr) %{_libdir}/R/library/Matrix/po/fr/
%lang(ko) %{_libdir}/R/library/Matrix/po/ko/
%lang(pl) %{_libdir}/R/library/Matrix/po/pl/
%{_libdir}/R/library/Matrix/R/
%{_libdir}/R/library/Matrix/test-tools.R
%{_libdir}/R/library/Matrix/test-tools-1.R
%{_libdir}/R/library/Matrix/test-tools-Matrix.R
# methods
%{_libdir}/R/library/methods/
# mgcv
%{_libdir}/R/library/mgcv/
# nlme
%dir %{_libdir}/R/library/nlme/
%{_libdir}/R/library/nlme/CITATION
%{_libdir}/R/library/nlme/data/
%{_libdir}/R/library/nlme/DESCRIPTION
%{_libdir}/R/library/nlme/help/
%{_libdir}/R/library/nlme/html/
%{_libdir}/R/library/nlme/INDEX
%{_libdir}/R/library/nlme/libs/
%{_libdir}/R/library/nlme/Meta/
%{_libdir}/R/library/nlme/mlbook/
%{_libdir}/R/library/nlme/NAMESPACE
%{_libdir}/R/library/nlme/tests/
%dir %{_libdir}/R/library/nlme/po/
%lang(de) %{_libdir}/R/library/nlme/po/de/
%lang(en) %{_libdir}/R/library/nlme/po/en*/
%lang(fr) %{_libdir}/R/library/nlme/po/fr/
%lang(ko) %{_libdir}/R/library/nlme/po/ko/
%lang(pl) %{_libdir}/R/library/nlme/po/pl/
%{_libdir}/R/library/nlme/R/
%{_libdir}/R/library/nlme/scripts/
# nnet
%dir %{_libdir}/R/library/nnet/
%{_libdir}/R/library/nnet/CITATION
%{_libdir}/R/library/nnet/DESCRIPTION
%{_libdir}/R/library/nnet/help/
%{_libdir}/R/library/nnet/html/
%{_libdir}/R/library/nnet/INDEX
%{_libdir}/R/library/nnet/libs/
%{_libdir}/R/library/nnet/Meta/
%{_libdir}/R/library/nnet/NAMESPACE
%{_libdir}/R/library/nnet/NEWS
%dir %{_libdir}/R/library/nnet/po
%lang(de) %{_libdir}/R/library/nnet/po/de/
%lang(en) %{_libdir}/R/library/nnet/po/en*/
%lang(fr) %{_libdir}/R/library/nnet/po/fr/
%lang(ko) %{_libdir}/R/library/nnet/po/ko/
%lang(pl) %{_libdir}/R/library/nnet/po/pl/
%{_libdir}/R/library/nnet/R/
# parallel
%{_libdir}/R/library/parallel/
# rpart
%dir %{_libdir}/R/library/rpart/
%{_libdir}/R/library/rpart/data/
%{_libdir}/R/library/rpart/DESCRIPTION
%{_libdir}/R/library/rpart/doc/
%{_libdir}/R/library/rpart/help/
%{_libdir}/R/library/rpart/html/
%{_libdir}/R/library/rpart/INDEX
%{_libdir}/R/library/rpart/libs/
%{_libdir}/R/library/rpart/Meta/
%{_libdir}/R/library/rpart/NAMESPACE
%{_libdir}/R/library/rpart/NEWS.Rd
%{_libdir}/R/library/rpart/tests/
%dir %{_libdir}/R/library/rpart/po
%lang(de) %{_libdir}/R/library/rpart/po/de/
%lang(en) %{_libdir}/R/library/rpart/po/en*/
%lang(fr) %{_libdir}/R/library/rpart/po/fr/
%lang(ko) %{_libdir}/R/library/rpart/po/ko/
%lang(pl) %{_libdir}/R/library/rpart/po/pl/
%lang(ru) %{_libdir}/R/library/rpart/po/ru/
%{_libdir}/R/library/rpart/R/
# spatial
%dir %{_libdir}/R/library/spatial/
%{_libdir}/R/library/spatial/CITATION
%{_libdir}/R/library/spatial/DESCRIPTION
%{_libdir}/R/library/spatial/help/
%{_libdir}/R/library/spatial/html/
%{_libdir}/R/library/spatial/INDEX
%{_libdir}/R/library/spatial/libs/
%{_libdir}/R/library/spatial/Meta/
%{_libdir}/R/library/spatial/NAMESPACE
%{_libdir}/R/library/spatial/NEWS
%{_libdir}/R/library/spatial/tests/Examples/
%dir %{_libdir}/R/library/spatial/po
%lang(de) %{_libdir}/R/library/spatial/po/de/
%lang(en) %{_libdir}/R/library/spatial/po/en*/
%lang(fr) %{_libdir}/R/library/spatial/po/fr/
%lang(ko) %{_libdir}/R/library/spatial/po/ko/
%lang(pl) %{_libdir}/R/library/spatial/po/pl/
%{_libdir}/R/library/spatial/ppdata/
%{_libdir}/R/library/spatial/PP.files
%{_libdir}/R/library/spatial/R/
# splines
%{_libdir}/R/library/splines/
# stats
%{_libdir}/R/library/stats/
# stats4
%{_libdir}/R/library/stats4/
# survival
%{_libdir}/R/library/survival/
# tcltk
%{_libdir}/R/library/tcltk/
# tools
%{_libdir}/R/library/tools/
# utils
%{_libdir}/R/library/utils/
%{_libdir}/R/modules
%{_libdir}/R/COPYING
%{_libdir}/R/SVN-REVISION
%{_infodir}/R-*.info*
%{_mandir}/man1/*
%{_defaultdocdir}/R/*
/etc/ld.so.conf.d/*
%config %{_sysconfdir}/*

%files core-devel
%defattr(-, root, root, -)
%{_libdir}/pkgconfig/libR.pc
%{_includedir}/R
# Symlink to %{_includedir}/R/
%{_libdir}/R/include
%files devel
# Nothing, all files provided by R-core-devel
%files java
# Nothing, all files provided by R-core
%files java-devel
# Nothing, all files provided by R-core-devel
%files -n libRmath-intel
%defattr(-, root, root, -)
%doc doc/COPYING
%{_libdir}/libRmath.so
%files -n libRmath-intel-devel
%defattr(-, root, root, -)
%{_includedir}/Rmath.h
%{_libdir}/pkgconfig/libRmath.pc
%files -n libRmath-intel-static
%defattr(-, root, root, -)
%{_libdir}/libRmath.a


%post core
/sbin/ldconfig
/usr/bin/R --vanilla
# Create directory entries for info files
# (optional doc files, so we must check that they are installed)
for doc in admin exts FAQ intro lang; do
   file=%{_infodir}/R-${doc}.info.gz
   if [ -e $file ]; then
      /sbin/install-info ${file} %{_infodir}/dir 2>/dev/null || :
   fi
done

R CMD javareconf \
    JAVA_HOME=%{_jvmdir}/jre \
    JAVA_CPPFLAGS='-I%{_jvmdir}/java/include\ -I%{_jvmdir}/java/include/linux' \
    JAVA_LIBS='-L%{_jvmdir}/jre/lib/%{java_arch}/server \
    -L%{_jvmdir}/jre/lib/%{java_arch}\ -L%{_jvmdir}/java/lib/%{java_arch} \
    -L/usr/java/packages/lib/%{java_arch}\ -L/lib\ -L/usr/lib\ -ljvm' \
    JAVA_LD_LIBRARY_PATH=%{_jvmdir}/jre/lib/%{java_arch}/server:%{_jvmdir}/jre/lib/%{java_arch}:%{_jvmdir}/java/lib/%{java_arch}:/usr/java/packages/lib/%{java_arch}:/lib:/usr/lib \
    > /dev/null 2>&1 || exit 0

%preun core
if [ $1 = 0 ]; then
   # Delete directory entries for info files (if they were installed)
   for doc in admin exts FAQ intro lang; do
      file=%{_infodir}/R-${doc}.info.gz
      if [ -e ${file} ]; then
         /sbin/install-info --delete R-${doc} %{_infodir}/dir 2>/dev/null || :
      fi
   done
fi

%postun core
/sbin/ldconfig
if [ $1 -eq 0 ] ; then
    /usr/bin/mktexlsr %{_datadir}/texmf &>/dev/null || :
fi

%posttrans core
/usr/bin/mktexlsr %{_datadir}/texmf &>/dev/null || :

%post java
R CMD javareconf \
    JAVA_HOME=%{_jvmdir}/jre \
    JAVA_CPPFLAGS='-I%{_jvmdir}/java/include\ -I%{_jvmdir}/java/include/linux' \
    JAVA_LIBS='-L%{_jvmdir}/jre/lib/%{java_arch}/server \
    -L%{_jvmdir}/jre/lib/%{java_arch}\ -L%{_jvmdir}/java/lib/%{java_arch} \
    -L/usr/java/packages/lib/%{java_arch}\ -L/lib\ -L/usr/lib\ -ljvm' \
    JAVA_LD_LIBRARY_PATH=%{_jvmdir}/jre/lib/%{java_arch}/server:%{_jvmdir}/jre/lib/%{java_arch}:%{_jvmdir}/java/lib/%{java_arch}:/usr/java/packages/lib/%{java_arch}:/lib:/usr/lib \
    > /dev/null 2>&1 || exit 0

%post java-devel
R CMD javareconf \
    JAVA_HOME=%{_jvmdir}/jre \
    JAVA_CPPFLAGS='-I%{_jvmdir}/java/include\ -I%{_jvmdir}/java/include/linux' \
    JAVA_LIBS='-L%{_jvmdir}/jre/lib/%{java_arch}/server \
    -L%{_jvmdir}/jre/lib/%{java_arch}\ -L%{_jvmdir}/java/lib/%{java_arch} \
    -L/usr/java/packages/lib/%{java_arch}\ -L/lib\ -L/usr/lib\ -ljvm' \
    JAVA_LD_LIBRARY_PATH=%{_jvmdir}/jre/lib/%{java_arch}/server:%{_jvmdir}/jre/lib/%{java_arch}:%{_jvmdir}/java/lib/%{java_arch}:/usr/java/packages/lib/%{java_arch}:/lib:/usr/lib \
    > /dev/null 2>&1 || exit 0


%post -n libRmath-intel -p /sbin/ldconfig

%postun -n libRmath-intel -p /sbin/ldconfig

%changelog
* Fri Oct 16 2015 gabx <arnaud.gaboury@gmail.com> - 3.2.2-2
- change package name to R-intel to prevent dnf to upgrade

* Fri Oct 09 2015 gabx <arnaud.gaboury@gmail.com> - 3.2.2-intel.2
- lot of cleaning
- first clean version with no errors

* Thu Sep 17 2015 gabx <arnaud.gaboury@gmail.com> - 3.2.2-mkl.1
- Initial draft for R-Intel


