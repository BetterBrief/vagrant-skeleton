#!/usr/bin/env bash

# Grab the installer and pipe it into PHP
echo "Installing composer"

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$(curl -q https://composer.github.io/installer.sig)') { echo 'Installer verified' . PHP_EOL; } else { echo 'Installer corrupt' . PHP_EOL; unlink('composer-setup.php'); exit(1); }"
if [ $? != 0 ]; then
	echo "Bad composer installer";
	exit
fi
php composer-setup.php -- --install-dir=/usr/bin --filename=composer
php -r "unlink('composer-setup.php');"

composer config -g optimize-autoloader true

echo "Adding composer's vendor directory to system PATH"
cat >/etc/profile.d/composer-bin-root.sh <<EOF
#!/usr/bin/env bash

pathmunge /home/vagrant/.composer/vendor/bin after
pathmunge /root/.composer/vendor/bin after

export COMPOSER_ALLOW_SUPERUSER=1

EOF

echo "Composer installed"

echo "Installing git due to composer dependency"
yum install -y git

if [ -r "/var/www/html/composer.json" ]
then
	echo "Installing declared packages from composer.json"
	composer install --no-ansi -n --no-progress --no-suggest -d /var/www/html
else
	echo "WARNING: There was no (readable) composer.json. Create one and run 'composer install' to install dependencies." >& 2
fi
