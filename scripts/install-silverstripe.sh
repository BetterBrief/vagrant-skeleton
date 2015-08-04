#!/usr/bin/env bash

INSTALL_DIR=/vagrant/www/ # The directory to install silverstripe into
INSTALL_DESTINATION=/var/www/html # The directory to symlink the install dir to. Pass an empty -w flag to avoid symlink
INSTALL_VERSION='' # The version constraint we want, by default it will be latest stable
INSTALLER_NAME='silverstripe/installer' # The composer installer name, this could be changed to a custom one if needed

function usage() {
	echo -e "Syntax `basename $0` [-h] [-v version] [-d directory] [-i installer] [-w webroot]
	-h Show this help
	-v Set the version constraint for the installer
	-d Set the directory to install into
	-i Set the installer
	-w Set the webroot to symlink\n"
}

function install() {
	if [[ ! -d ${INSTALL_DIR} ]] || [[ ! $(ls -A ${INSTALL_DIR}) ]]; then
		composer create-project ${INSTALLER_NAME} ${INSTALL_DIR} ${INSTALL_VERSION}
	else
		echo "WARNING: Install directory is not empty; not installing"
	fi
	return $?
}

while getopts "hv:d:i:w" OPTION; do
	case ${OPTION} in
		v ) INSTALL_VERSION="$OPTARG"
			;;
		d ) INSTALL_DIR="$OPTARG"
			;;
		i ) INSTALLER_NAME="$OPTARG"
			;;
		w ) INSTALL_DESTINATION="$OPTARG"
			;;
		h ) usage
			exit 0
	esac
done

install
/vagrant/scripts/mount-webroot.sh -w "${INSTALL_DIR}"
