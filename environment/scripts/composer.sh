#!/bin/bash

# Grab the installer and pipe it into PHP
echo "Downloading composer"
curl -sS https://getcomposer.org/installer | php

echo "Moving composer to make it globally accessable"
mv composer.phar /usr/bin/composer

echo "Adding composer's vendor directory to system PATH"
cat >/etc/profile.d/composer-bin-root.sh <<EOF
#!/bin/bash

pathmunge /home/vagrant/.composer/vendor/bin after
pathmunge /root/.composer/vendor/bin after
EOF

echo "Composer installed"

echo "Installing git due to composer dependency"
yum install -y git

cd /var/www/html
if [ -r "composer.json" ]
then
	echo "Installing declared packages from composer.json"
	composer install
else
	echo "WARNING: There was no (readable) composer.json. Create one and run 'composer install' to install dependencies."
fi;
