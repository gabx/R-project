%global java_arch amd64

Name: rstudio-server
Version: 0.99.845
Release: 1%{?dist}
Summary: Rstudio Server lets you access Rstudio from anywhere using a web browser
URL: http://www.rstudio.com
Source0: https://github.com/rstudio/rstudio/archive/v%{version}.tar.gz
Source1: rstudio-server.service
License: AGPLv3
Group: Applications/Editors

BuildRequires: cmake >= 2.8 
BuildRequires: java-1.8.0-openjdk-headless
BuildRequires: java-headless
BuildRequires: ant
BuildRequires: unzip
BuildRequires: openssl
BuildRequires: bzip2-devel
BuildRequires: pango
BuildRequires: pam-devel
BuildRequires: zlib
BuildRequires: uuid-devel
BuildRequires: libuuid-devel
Requires: R-intel-core >= 2.11.1
Requires: util-linux
Requires: boost >= 1.5


%description
Rstudio is a powerful IDE and productive user interface for R. It is free
and open source.
Rstudio server lets you acess the IDE from any web browser. It provides the
IDE to a version of R running on a remote Linux server.


%prep
%autosetup -n rstudio-%{version}

%build
cd dependencies/common
./install-gwt
./install-dictionaries
./install-mathjax
./install-pandoc
./install-libclang
./install-packages

if [ -n $R_PROFILE_USER ];then
    unset R_PROFILE_USER
fi


mkdir %{_builddir}/rstudio-%{version}/build
cd %{_builddir}/rstudio-%{version}/build
cmake .. -DRSTUDIO_TARGET=Server -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/lib64/rstudio-server



%install
cd %{_builddir}/rstudio-%{version}/build
#make DESTDIR=%{buildroot} install
%make_install

mkdir -p %{buildroot}/etc/pam.d
install -Dm 644 %{buildroot}/usr/lib64/rstudio-server/extras/pam/rstudio %{buildroot}/etc/pam.d/rstudio
mkdir -p %{buildroot}/var/www/rstudio-server
cp -R %{buildroot}/usr/lib64/rstudio-server/www/* %{buildroot}/var/www/rstudio-server
rm -rf %{buildroot}/usr/lib64/rstudio-server/extras
mkdir -p %{buildroot}/etc/systemd/system
install -Dm 644 %{_sourcedir}/rstudio-server.service %{buildroot}/etc/systemd/system/rstudio-server.service
mkdir -p %{buildroot}/etc/rstudio


%check
# uncommand/command below lines to make a basic check
# make check
#make check-all

%files
%{_libdir}/%{name}/
%{_localstatedir}/*
%{_sysconfdir}/*

%post
/sbin/ldconfig
getent passwd "rstudio-server" &>/dev/null || useradd -r -U rstudio-server -d "/usr/lib/rstudio-server/www/" -s "/bin/sh" rstudio 1>/dev/null
chown -R rstudio-server:rstudio-server /usr/lib64/rstudio-server/www/
ln -s /usr/lib64/rstudio-server/bin/rserver /usr/bin/rserver
ln -s /usr/lib64/rstudio-server/bin/rstudio-server /usr/bin/rstudio-server
mkdir -p /var/run/rstudio-server
mkdir -p /var/lock/rstudio-server
mkdir -p /var/log/rstudio-server
mkdir -p /var/lib/rstudio-server

%postun
/sbin/ldconfig
if getent passwd "rstudio" >/dev/null; then
    userdel rstudio >/dev/null
fi
if getent group "rstudio" >/dev/null; then
    groupdel rstudio >/dev/null
fi

  rm -f /usr/sbin/rstudio-server
  rm -f /usr/bin/rserver
  
  rm -rf /var/run/rstudio-server
  rm -rf /var/lock/rstudio-server
  rm -rf /var/log/rstudio-server
  rm -rf /var/lib/rstudio-server
%changelog
* Thu Jan 07 2016 gabx <arnaud.gaboury@gmail.com> - rstudio-server-0.99.845
- symlink binaries to /usr/bin
- use rstudio pandoc
- mkdir /var/{run,lock,log,lib}

* Thu Sep 17 2015 gabx <arnaud.gaboury@gmail.com> - rstudio-server-0.99.800
- Initial release for rstudio-server


