Vagrant Skeleton
======================

This is the Vagrant skeleton that we use at [Better Brief](http://betterbrief.co.uk). It's meant to form a "as close as possible" base to our live servers to keep fragmentation of environments to a minimum. There is obviously the advantage of easily portable development environments!

## Guest OS

We're using a CentOS 7 OS, image from [chef](https://vagrantcloud.com/chef/boxes/centos-7.0) (thanks)

However, there shouldn't be much issue using these scrips on the following OS's:
- RHEL
- Fedora
- Amazon Linux

## Automation and provisioning

We use as much automation as possible during provisioning so that our scripts can be used on other environments and not just on Vagrant boxes. Though it's important to note that some scripts rely on others, order of execution can be important and there are many setting changes that are designed for dev environments only.

## Purpose

The main purpose for this skeleton is for developing [SilverStripe](http://silverstripe.org) sites (as that's our primary framework) so we include a basic environment file for that. However, the skeleton can easily be adapted for any other framework that you want to host on CentOS.

## Requirements

You can use this system on any computer that can run the following software, it's completely platform independent.

- [VirtualBox](http://www.virtualbox.org/wiki/Downloads)
- [Vagrant](http://www.vagrantup.com/downloads)

## Usage

To get up and running is very simple.

0. Copy this repo to a new folder where you develop
1. Add SQL dump(s) to the `database` folder with the name of the database the same as the filename
2. Checkout your PHP code to a webroot folder:
  * `www`, `public` and `public_html` directories, where the full application lives inside the webroot (like SilverStripe), will be auto mounted
  * `project/public` directories will be auto mounted, where `project` contains your application, and the `public` folder contains any public facing code, like Laravel apps.
  * If no webroot is found, the latest SilverStripe will be installed in `www`
3. Go to the command line and `# vagrant up`

This will run the default webserver with the default php modules we need installed. It will also pull in the database(s) automatically.

### Customisations

Edit the `Vagrantfile` to enable or disable install scripts as they are required.

## Included scripts and software

|Script               |Name|Version|Repo|Description|
|---------------------|--------|-------|----|-----------|
|apache.sh            |Apache             |2.x|CentOS|Mounts the www, public _or_ public_html dir to webroot, installs Apache
|php-54.sh            |PHP                |5.3.x|CentOS|Installs PHP 5.4, restarts Apache
|php-55.sh            |PHP                |5.5.x|Webtatic EL6|Installs PHP 5.5, restarts Apache
|php-56.sh            |PHP                |5.6.x|Webtatic EL6|Installs PHP 5.6, restarts Apache
|mariadb.sh           |MariaDB            |5.5|MariaDB.org|Installs MariaDB, opens port 3306, imports dumps in /vagrant/database
|php-mcrypt.sh        |PHP Mcrypt extension|-|EPEL|Installs Mcrypt. Only needed for PHP 5.3.x as 5.5 has it built-in.
|xdebug.sh 		      |Xdebug extension   |-|EPEL|Install Xdebug extension for debugging purposes.
|ntp.sh               |ntp|-|CentOS|Installs NTP which handles time management
|node.sh              |NodeJS|-|Fedora EPEL|Installs the NodeJS language and its package manager, NPM
|bower.sh             |Bower|-|NPM|Installs the Bower dependency manager
|grunt.sh             |Grunt|-|NPM|Installs the NodeJS based task runner, grunt.
|grunt-watch.sh       |Grunt watch daemon|-|-|Sets up an automatic `grunt watch` task that will run on `vagrant up`
|composer.sh          |Composer|-|getcomposer.org|Installs PHP's composer package manager
|sspak.sh         	  |SSPak|-|Installs SSPak|Asset and database snapshot tool for SilverStripe ([link](//github.com/silverstripe/sspak))
|sass.sh              |Ruby, RubyGems, SASS|3.2.10|CentOS|Installs SASS 3.4.10, a handy CSS pre processor, and Compass 1.0.3
|bootstrap.sh         |-|-|-|Various bootstrap tasks and snag fixes

## Environments

Ideally we'd have scripts and configs that can be used on many environments (including live) however these are just local development environments and none of these are used on a live server.
