#!/bin/bash

echo "Performing SilverStripe helper tasks"

# Attempt to automatically chmod the assets folder.
# We use /var/www/html because apache.sh already auto mounts www or public_html folders

if [ -d "/var/www/html/assets/" ]
then
	chmod -R 0777 /var/www/html/assets
	echo "Assets folder chmodded to 777"
	rm -f /var/www/html/assets/error-*.html
	echo "Pregenerated error pages removed"
else
	echo "NOTICE: No assets folder found in /var/www/html - don't forget to ensure it is writable"
fi

if [ -f "/var/www/html/framework/sake" ]
then
	chmod +x /var/www/html/framework/sake
	echo "sake is now executable"
	/var/www/html/framework/sake installsake
	echo "sake in installed and global"
fi

echo "SilverStripe helper tasks complete"
