# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  #Vanilla
  config.vm.box = "chef/centos-7.0"

  #---Networking---

  # Port forward 80 to 8080
  config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true
  #config.vm.network :forwarded_port, guest: 443, host: 443, auto_correct: true
  config.vm.network :forwarded_port, guest: 3306, host: 3306, auto_correct: true
  config.vm.network :forwarded_port, guest: 1080, host: 1080, auto_correct: true

  #Uncomment this if you want bridged network functionality
  #config.vm.network :public_network

  #Install lamp and so on
  #In future will probably swap this out with something like Puppet
  config.vm.provision :shell, :path => "scripts/php-54.sh"
  #config.vm.provision :shell, :path => "scripts/php-55.sh"
  #config.vm.provision :shell, :path => "scripts/php-56.sh"
  config.vm.provision :shell, :path => "scripts/composer.sh"
  config.vm.provision :shell, :path => "scripts/apache.sh"
  config.vm.provision :shell, :path => "scripts/mariadb.sh"
  #config.vm.provision :shell, :path => "scripts/php-mcrypt.sh"
  config.vm.provision :shell, :path => "scripts/xdebug.sh"
  #config.vm.provision :shell, :path => "scripts/ntp.sh"
  #config.vm.provision :shell, :path => "scripts/node.sh"
  #config.vm.provision :shell, :path => "scripts/bower.sh"
  #config.vm.provision :shell, :path => "scripts/grunt.sh"
  #config.vm.provision :shell, :path => "scripts/grunt-watch.sh"
  #config.vm.provision :shell, :path => "scripts/sass.sh"
  config.vm.provision :shell, :path => "scripts/silverstripe-tasks.sh"
  #config.vm.provision :shell, :path => "scripts/sspak.sh"
  config.vm.provision :shell, :path => "scripts/mailcatcher.sh"
  config.vm.provision :shell, :path => "scripts/bootstrap.sh"
  config.vm.provision :shell, :path => "scripts/always.sh", run: "always"

end
