#!/usr/bin/env bash

INSTALL_DIR=/vagrant/www/

INSTALL_VERSION=''

INSTALLER_NAME='silverstripe/installer'

function usage() {
	echo -e "Syntax `basename $0` [-h] [-v version] [-d directory] [-i installer]
	-h Show this help
	-v Set the version constraint for the isntaller
	-d Set the directory to install into
	-i Set the installer\n"
}

function install() {
	composer create-project ${INSTALLER_NAME} ${INSTALL_DIR} ${INSTALL_VERSION}
	exit $?
}

#set up the username and password
while getopts "hv:d:i:" OPTION; do
	case ${OPTION} in
		v ) INSTALL_VERSION="$OPTARG"
			;;
		d ) INSTALL_DIR="$OPTARG"
			;;
		i ) INSTALLER_NAME="$OPTARG"
			;;
		h ) usage
			exit 0
	esac
done

install
