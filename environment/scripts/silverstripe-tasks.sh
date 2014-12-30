#!/bin/bash

echo "Performing SilverStripe helper tasks"

# Attempt to automatically chmod the assets folder.
# We use /var/www/html because apache.sh already auto mounts www or public_html folders

cd /var/www/html/

if [ -d "assets/" ]
then
	chmod -R 0777 assets
	echo "Assets folder chmodded to 777"
	rm -f assets/error-*.html
	echo "Pregenerated error pages removed"
else
	echo "NOTICE: No assets folder found in /var/www/html - don't forget to ensure it is writable"
fi

if [ -f "framework/sake" ]
then
	chmod +x framework/sake
	echo "sake is now executable"
	framework/sake installsake
	echo "sake in installed and global"
fi

echo "SilverStripe helper tasks complete"
