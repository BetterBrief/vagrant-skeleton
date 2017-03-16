#!/usr/bin/env bash

VERSION="php"
VERSION_STRING="5.4"
USE_EPEL=false
PHP_MODULES=(common mysql gd mbstring xml tidy pear intl devel)
TZ='UTC'
MEMORY_LIMIT=256
QUIET=false
EXEC_TIME=60

while getopts "hqv:t:m:e:" OPTION; do
	case ${OPTION} in
		v ) if [ "${OPTARG}" == "5.4" ]; then
				VERSION="php"
			elif [ "${OPTARG}" == "5.5" ]; then
				VERSION="php55w"
				USE_EPEL=true
			elif [ "${OPTARG}" == "5.6" ]; then
				VERSION="php56w"
				USE_EPEL=true
			else
				${QUIET} || >&2 echo "Unsupported PHP version '${OPTARG}'"
				exit 1
			fi
			VERSION_STRING=${OPTARG}
			;;
		t ) TZ=${OPTARG}
			;;
		m ) MEMORY_LIMIT=${OPTARG}
			;;
		q ) QUIET=false
			;;
		e ) EXEC_TIME=${OPTARG}
		    ;;
		h ) usage
			exit 0
	esac
done

function usage() {
	echo -e "Syntax `basename $0` [-h] [-v version]
	-h Show this help
	-q Quiet mode
	-t Timezone to use for PHP.ini
	-m Memory limit for PHP.ini (in M)
	-e Max execution time for PHP.ini
	-v Set the version of PHP to install\n"
}

function run() {
	${QUIET} || echo "Installing PHP ${VERSION_STRING} (${VERSION})"
	/vagrant/scripts/epel.sh
	if [ ${USE_EPEL} == true ]; then
		yum install -y $VERSION ${PHP_MODULES[@]/#/$VERSION-} --enablerepo=epel --enablerepo=webtatic
	else
		yum install -y $VERSION ${PHP_MODULES[@]/#/$VERSION-}
		yum install -y php-tidy --enablerepo=epel
	fi
	cp -f /usr/share/doc/$VERSION-*/php.ini-development /etc/php.ini
	sed -i "s/;date\.timezone.*/date\.timezone = ${TZ}/g" /etc/php.ini
	sed -i "s/memory_limit.*/memory_limit = ${MEMORY_LIMIT}M/g" /etc/php.ini
	sed -i "s/max_execution_time.*/max_execution_time = ${EXEC_TIME}/g" /etc/php.ini

	${QUIET} || echo "Restarting apache"
	 if [ "`systemctl is-active httpd.service`" != "active" ]; then
		systemctl start httpd.service
	else
		systemctl restart httpd.service
	fi

	${QUIET} || echo "PHP Installed"
}

run
