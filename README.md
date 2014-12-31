Vagrant Skeleton
======================

This is the Vagrant skeleton that we use at [Better Brief](//betterbrief.co.uk). It's meant to form a "as close as possible" base to our live servers to keep fragmentation of environments to a minimum. There is obviously the advantage of easily portable development environments!

## Guest OS

We're using a CentOS 6.5 OS, image from [puppet labs](http://puppet-vagrant-boxes.puppetlabs.com/) (thanks)

However, there shouldn't be much issue using these scrips on the following OS's:
- RHEL
- Fedora
- Amazon Linux

## Automation and provisioning

We use as much automation as possible during provisioning so that our scripts can be used on other environments and not just on Vagrant boxes.

## Purpose

The main purpose for this skeleton is for developing [SilverStripe](http://silverstripe.org) sites (as that's our primary framework) so we include a basic environment file for that. However, the skeleton can easily be adapted for any other framework that you want to host on CentOS

## Requirements

You can use this system on any computer that can run the following software, it's completely platform independant.

- [VirtualBox](//www.virtualbox.org/wiki/Downloads)
- [Vagrant](//www.vagrantup.com/downloads)

## Usage

To get up and running is very simple.

0. Copy this repo to a new folder where you develop
1. Add SQL dump(s) to the `database` folder with the name of the database the same as the filename
2. Checkout your PHP code to folder `www` (this is the webroot)
3. Go to the command line and `# vagrant up`

This will run the default webserver with the default php modules we need installed. It will also pull in the database(s) automatically.

### Customisations

Edit the `Vagrantfile` to enable or disable install scripts as they are required.

## Included scripts and software

|Script               |Purpose  |Software|Version|Repo|Description|
|---------------------|---------|--------|-------|----|-----------|
|iptables.sh          |Config   |-                  |-|-|Opens port 22 so you can access your vagrant box
|apache.sh            |Software |Apache             |2.x|CentOS|Mounts the www _or_ public_html dir to webroot, installs Apache, opens ports 80 and 443
|php.sh               |Software |PHP                |5.3.x|CentOS|Installs PHP 5.3, restarts Apache
|php-55.sh            |Software |PHP                |5.5.x|Webtatic EL6|Installs PHP 5.5, restarts Apache
|mysql.sh             |Software |MySQL              |5.x|CentOS|Installs MySQL, opens port 3306, imports dumps in /vagrant/database
|mariadb-5.5.sh       |Software |MariaDB            |5.5|MariaDB.org|Installs MariaDB, opens port 3306, imports dumps in /vagrant/database
|php-geoip.sh         |Software |PHP GeoIP extension|-|EPEL|Installs PHP's GeoIP functions
|php-phpunit.sh       |Software |PHP PHPUnit library|3.7.x|PEAR|Installs PEAR, then uses PEAR to install PHPUnit
|php-xdebug.sh        |Software |PHP XDebug         |-|CentOS, PECL|Installs XDebug along with its automake, gcc, and php-devel
|php-apc.sh           |Software |PHP APC            |-|CentOS, PECL|Installs APC. Only needed for PHP 5.3.x as 5.5 has it built-in.
|php-mcrypt.sh        |Software |PHP Mcrypt extension|-|EPEL|Installs Mcrypt. Only needed for PHP 5.3.x as 5.5 has it built-in.
|mongo.sh             |Software |MongoDB            |10gen|MongoDB.org|Installs the MongoDB NoSQL database
|php-mongo.sh         |Software |PHP MongoDB|-|PEAR, PECL|Installs the PHP MongoDB extension
|ntp.sh               |Config   |ntp|-|CentOS|Installs NTP which handles time management
|node.sh              |Software |NodeJS|-|Fedora EPEL|Installs the NodeJS language and its package manager, NPM
|grunt.sh             |Software |Grunt|-|NPM|Installs the NodeJS based task runner, grunt.
|grunt-watch.sh       |Software |Grunt watch daemon|-|-|Sets up an automatic `grunt watch` task that will run on `vagrant up`
|composer.sh          |Software |Composer|-|getcomposer.org|Installs PHP's composer package manager
|sspak.sh         	  |Software |SSPak|-|https://github.com/silverstripe/sspak|Asset and database snapshot tool for SilverStripe
|libjpeg-jpegoptim.sh |Software |libjpeg; jpegoptim|-|CentOS; CentALT|Installs libjpeg and jpegoptim for use with compressing JPEG images
|optipng.sh           |Software |optipng|-|CentOS|Installs optipng for use with compressing PNG images
|sass.sh              |Software |Ruby, RubyGems, SASS|3.2.10|CentOS|Installs SASS 3.2.10, a handy CSS pre processor
|bootstrap.sh         |Config   |-|-|-|Various bootstrap tasks and snag fixes

## Environments

Ideally we'd have scripts and configs that can be used on many environments (including live) however these are just local development environments and none of these are used on a live server.
