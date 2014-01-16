##!/bin/bash

echo "Setting up grunt watch startup script (depends on grunt.sh)"

if [ -r "/vagrant/www/package.json" ]
then
	echo "Adding startup script 'grunt-watch.sh' to /etc/init.d";
	sudo echo "cd /vagrant/www && sudo nohup grunt watch > /dev/null 2> /dev/null < /dev/null &" > /etc/init.d/grunt-watch.sh
	echo "Running grunt-watch.sh";
	cd /etc/init.d
	chmod +x /etc/init.d/grunt-watch.sh
	./grunt-watch.sh
	echo "grunt-watch.sh installed"
	echo "NOTICE: If watch tasks are changed, these will take effect from the next time this machine is reloaded. You can test changed watch tasks with grunt watch in the terminal, however."
else
	echo "WARNING: There was no (readable) package.json so a startup script could not be installed. Refer to /vagrant/environment/scripts/grunt-watch.sh for further instructions";
fi;
