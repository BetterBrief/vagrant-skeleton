#!/usr/bin/env bash

# Deps
/vagrant/scripts/node.sh

# Install bower
echo "Installing bower"
npm install -g --bin-links bower

echo '{ "allow_root": true }' > /root/.bowerrc

echo "Bower installed"

for themedir in /var/www/html/themes/*
do
	if [ -r "$themedir/bower.json" ]
	then
		bower install --allow-root --config.cwd=$themedir
	fi
done
