#!/usr/bin/env bash

# For running PHPStorm or IntelliJ, follow these steps:
# 1. Go to Settings => Language & Frameworks => PHP => Servers
# 2. Add you Vagrant server with the correct port.
# 3. Check the pathmapping checkbox and set your root of the project to /vagrant and the www directory to /www/directory
# 4. Apply and close settings
# 5. Go to Run => Edit configurations
# 6. Add a new PHP Web Application with the server you just added. The rest is trivial and free to fill.
# 7. Apply and done!

echo "Install Xdebug"
yum install -y gcc gcc-c++ autoconf automake

pecl install Xdebug
if [ ! -f /etc/php.d/xdebug.ini ]
then
    echo "[xdebug]
    zend_extension=\"/usr/lib64/php/modules/xdebug.so\"
    xdebug.profiler_enable = 1
    xdebug.profiler_enable_trigger = 1
    xdebug.profiler_output_dir = \"/vagrant/profiling\"
    xdebug.remote_connect_back = 1
    xdebug.remote_enable = 1" > /etc/php.d/xdebug.ini
fi

if [ ! -d /vagrant/profiling ]; then
	mkdir /vagrant/profiling
fi

#we need a bit longer to execute with profiling
echo "NOTICE: max_execution_time has been explicitly set; ensure this does not clash with your own PHP config"
sed -i 's/max_execution_time.*/max_execution_time = 120/g' /etc/php.ini

systemctl restart httpd
