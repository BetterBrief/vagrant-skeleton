#!/bin/bash

echo 'Installing ruby and sqlite'
yum install -y ruby rubygems ruby-devel sqlite-devel gcc-c++

echo 'Creating pathmunge file'
echo "#!/bin/bash" > /etc/profile.d/local-bin.sh
echo "pathmunge /usr/local/bin after" >> /etc/profile.d/local-bin.sh

echo 'installing mailcatcher'
gem install mailcatcher

echo 'enabling mailcatcher in php'
sed -ri '/sendmail_path\s+=.*/a sendmail_path = /usr/bin/env catchmail' /etc/php.ini

echo 'restarting httpd'
systemctl restart httpd.service

echo 'mailcatcher installed'
