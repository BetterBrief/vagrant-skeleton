# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  #---Puppet Lab's CentOS Boxes---
  #https://github.com/puppetlabs/puppet-vagrant-boxes

  #Vanilla
  #config.vm.box = "centos-64-x64-vbox4210-nocm"
  #config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210-nocm.box"

  #Puppet (I already have this on my machine, using to save time)
  config.vm.box = "centos-64-x64-vbox4210"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"

  #---Networking---

  # Port forward 80 to 8080
  config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true
  config.vm.network :forwarded_port, guest: 3306, host: 3306, auto_correct: true

  #Uncomment this if you want bridged network functionality
  #config.vm.network :public_network

  #Install lamp and so on
  #In future will probably swap this out with something like Puppet
  config.vm.provision :shell, :path => "environment/scripts/apache.sh"
  config.vm.provision :shell, :path => "environment/scripts/php.sh"
  config.vm.provision :shell, :path => "environment/scripts/mysql.sh"
  #config.vm.provision :shell, :path => "environment/scripts/php-geoip.sh"
  #config.vm.provision :shell, :path => "environment/scripts/php-phpunit.sh"
  #config.vm.provision :shell, :path => "environment/scripts/php-apc.sh"
  #config.vm.provision :shell, :path => "environment/scripts/mongo.sh"
  #config.vm.provision :shell, :path => "environment/scripts/php-mongo.sh"
  #config.vm.provision :shell, :path => "environment/scripts/ntp.sh"
  #config.vm.provision :shell, :path => "environment/scripts/node.sh"
  #config.vm.provision :shell, :path => "environment/scripts/grunt.sh"
  #config.vm.provision :shell, :path => "environment/scripts/grunt-watch.sh"
  #config.vm.provision :shell, :path => "environment/scripts/composer.sh"
  #config.vm.provision :shell, :path => "environment/scripts/libjpeg-jpegoptim.sh"
  #config.vm.provision :shell, :path => "environment/scripts/optipng.sh"
  config.vm.provision :shell, :path => "environment/scripts/iptables.sh"
  config.vm.provision :shell, :path => "environment/scripts/bootstrap.sh"

end
