#!/usr/bin/env bash

#List of valid webroots in priority order
WEBROOTS=('/vagrant/project/public/' '/vagrant/www/' '/vagrant/public_html/' '/vagrant/webroot/' '/vagrant/public/')
DESTINATION='/var/www/html'
WEBROOT=''

function run() {
	echo "Mounting webroot"
	# pick the webroot
	if [ -z $WEBROOT ]; then
		for i in ${WEBROOTS[@]}
		do
			if [ -d $i ]
			then
				echo "Found Webroot"
				WEBROOT=$i
				break
			fi
		done
	fi

	if [ -d $WEBROOT ]; then
		#ensure the destination exists, otherwise the symlink won't work
		if [ ! -d ${DESTINATION} ]; then
			mkdir -p ${DESTINATION}
		fi
		rm -rf $DESTINATION
		ln -s ${WEBROOT} ${DESTINATION}
	else
		echo "WARNING: Couldn't find webroot"
	fi
}

function usage() {
	echo -e "Coming soon"
}

while getopts "hd:w:" OPTION; do
	case ${OPTION} in
		d ) DESTINATION="$OPTARG"
			;;
		w ) WEBROOT="$OPTARG"
			;;
		h ) usage
			exit 0
	esac
done

run
