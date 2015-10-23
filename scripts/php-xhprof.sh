#!/usr/bin/env bash

# Require repo deps
/vagrant/scripts/epel.sh

# install php-xhprof and graphviz
yum install -y php-xhprof graphviz --enablerepo=epel --enablerepo=webtatic

# clone the SS xhprof repo as we need that
if [ ! -d /vagrant/xhprof ]; then
	git clone https://github.com/sminnee/xhprof /vagrant/xhprof
fi

# set up the config
cp -f /vagrant/xhprof/xhprof_lib/config.sample.php /vagrant/xhprof/xhprof_lib/config.php

# replace the settings that don't make sense
sed -i 's/^\$controlIPs = array();/$controlIPs = false;/i' /vagrant/xhprof/xhprof_lib/config.php
sed -i '/^\$controlIPs\[\]/d' /vagrant/xhprof/xhprof_lib/config.php
sed -i 's/http:\/\/localhost\/xhprof\/xhprof_html/http:\/\/localhost:1090\/xhprof_html/i' /vagrant/xhprof/xhprof_lib/config.php

# create the tmpxh_dot error file
touch /tmpxh_dot.err
chmod 0777 /tmpxh_dot.err

# sym link xhprof repo - needed to access _ss_env file
rm -rf /var/www/xhprof
ln -s /vagrant/xhprof/ /var/www/xhprof

# add a port listener to apache for xhprof access
echo "Listen 1090

<VirtualHost *:1090>
DocumentRoot /var/www/xhprof/
ServerName localhost
</VirtualHost>" > /etc/httpd/conf.d/xhprof.conf

# set up the xhprof DB
mysql <<< "CREATE DATABASE IF NOT EXISTS \`xhprof\`; CREATE TABLE IF NOT EXISTS \`xhprof\`.\`details\` ( \
\`id\` char(17) NOT NULL, \
\`url\` varchar(255) default NULL, \
\`c_url\` varchar(255) default NULL, \
\`timestamp\` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP, \
\`server name\` varchar(64) default NULL, \
\`perfdata\` MEDIUMBLOB, \
\`type\` tinyint(4) default NULL, \
\`cookie\` BLOB, \
 \`post\` BLOB, \
 \`get\` BLOB, \
 \`pmu\` int(11) unsigned default NULL, \
 \`wt\` int(11) unsigned default NULL, \
 \`cpu\` int(11) unsigned default NULL, \
 \`server_id\` char(3) NOT NULL default 't11', \
 \`aggregateCalls_include\` varchar(255) DEFAULT NULL, \
 PRIMARY KEY  (\`id\`), \
 KEY \`url\` (\`url\`), \
 KEY \`c_url\` (\`c_url\`), \
 KEY \`cpu\` (\`cpu\`), \
 KEY \`wt\` (\`wt\`), \
 KEY \`pmu\` (\`pmu\`), \
 KEY \`timestamp\` (\`timestamp\`) \
 ) ENGINE=MyISAM DEFAULT CHARSET=utf8;"

# finally force the xhprof header into the PHP files when they are executed
echo 'php_value auto_prepend_file "/var/www/xhprof/external/header.php"' >> /var/www/html/.htaccess

# Restat apache
systemctl restart httpd.service

