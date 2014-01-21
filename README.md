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

### Software

Coming soon

### Configs

Coming soon

## Environments

Ideally we'd have scripts and configs that can be used on many environments (including live) however these are just local development environments and none of these are used on a live server.
