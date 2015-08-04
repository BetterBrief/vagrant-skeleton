#!/usr/bin/env bash


# Building HHVM from sauce
# see https://github.com/facebook/hhvm/wiki/Building-and-installing-hhvm-on-CentOS-7.x
echo "Building HHVM from source"
echo "Installing dependencies"

/vagrant/scripts/epel.sh
/vagrant/scripts/mariadb.sh

yum install -y cpp gcc-c++ cmake git psmisc {binutils,boost,jemalloc}-devel \
{ImageMagick,sqlite,tbb,bzip2,openldap,readline,elfutils-libelf,gmp,lz4,pcre}-devel \
lib{xslt,event,yaml,vpx,png,zip,icu,mcrypt,memcached,cap,dwarf}-devel \
{unixODBC,expat,mariadb}-devel lib{edit,curl,xml2,xslt}-devel \
glog-devel oniguruma-devel ocaml gperf enca libjpeg-turbo-devel openssl-devel \
make mariadb-devel --enablerepo=epel

service mariadb restart

echo "Dependencies installed"

echo "Cloning HHVM"
cd /tmp
git clone https://github.com/facebook/hhvm -b master  hhvm  --recursive
cd hhvm

echo "HHVM cloned"

echo "Compliling HHVM, this will take a while"
# ./configure # That is a cmake wrapper, ignore it.
cmake .
make -j$(($(nproc)+1)) # make with CORE_COUNT+1 threads, that would be fast. You may run out of RAM

echo "HHVM compiled"
# Test..
./hphp/hhvm/hhvm --version
echo "Installing HHVM"
# Install it..
make install

echo "[Unit]
Description=HHVM HipHop Virtual Machine (FCGI)

[Service]
ExecStartPre=-/usr/bin/mkdir -p /var/run/hhvm
ExecStartPre=-/usr/bin/chown nobody /var/run/hhvm
ExecStart=/usr/local/bin/hhvm --config /etc/hhvm/server.ini --user nobody --mode daemon -vServer.Type=fastcgi -vServer.Port=9000

[Install]
WantedBy=multi-user.target" >> /usr/lib/systemd/system/hhvm.service

echo "Running HHVM"

systemctl enable hhvm
systemctl start hhvm
systemctl status hhvm

echo "HHVM installed"
