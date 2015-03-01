#!/bin/bash

# For running PHPStorm or IntelliJ, follow these steps:
# 1. Go to Settings => Language & Frameworks => PHP => Servers
# 2. Add you Vagrant server with the correct port.
# 3. Check the pathmapping checkbox and set your root of the project to /vagrant and the www directory to /www/directory
# 4. Apply and close settings
# 5. Go to Run => Edit configurations
# 6. Add a new PHP Web Application with the server you just added. The rest is trivial and free to fill.
# 7. Aply and done!

echo "Install Xdebug"
yum install -y gcc gcc-c++ autoconf automake --enablerepo=epel --enablerepo=webtatic

pecl install Xdebug
if [ ! -f /etc/php.d/xdebug.ini ]
then
    echo "[xdebug]
    zend_extension=\"/usr/lib64/php/modules/xdebug.so\"
    xdebug.remote_connect_back = 1
    xdebug.remote_enable = 1" >> /etc/php.d/xdebug.ini
fi
