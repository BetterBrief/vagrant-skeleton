# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  #---Box config---

  config.vm.box = "bento/centos-7"

  config.vm.provider 'virtualbox' do |v|
    v.linked_clone = true if Gem::Version.new(Vagrant::VERSION) >= Gem::Version.new('1.8.0') 
  end

  #---Cachier plugin---

  if Vagrant.has_plugin?("vagrant-cachier")
	  # Configure cached packages to be shared between instances of the same base box.
	  # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
	  config.cache.scope = :box

	  # OPTIONAL: If you are using VirtualBox, you might want to use that to enable
	  # NFS for shared folders. This is also very useful for vagrant-libvirt if you
	  # want bi-directional sync
	  #config.cache.synced_folder_opts = {
		#type: :nfs,
		# The nolock option can be useful for an NFSv3 client that wants to avoid the
		# NLM sideband protocol. Without this option, apt-get might hang if it tries
		# to lock files needed for /var/cache/* operations. All of this can be avoided
		# by using NFSv4 everywhere. Please note that the tcp option is not the default.
		#mount_options: ['rw', 'vers=3', 'tcp', 'nolock']
	  #}
	  # For more information please check http://docs.vagrantup.com/v2/synced-folders/basic_usage.html
  end

  #---Networking---

  # Port forward 80 to 8080
  config.vm.network :forwarded_port, guest: 80, host: 8080, auto_correct: true
  #config.vm.network :forwarded_port, guest: 443, host: 443, auto_correct: true
  config.vm.network :forwarded_port, guest: 3306, host: 3306, auto_correct: true
  config.vm.network :forwarded_port, guest: 1080, host: 1080, auto_correct: true
  #config.vm.network :forwarded_port, guest: 1090, host: 1090, auto_correct: true

  #Uncomment this if you want bridged network functionality
  #config.vm.network :public_network

  #Install lamp and so on
  #In future will probably swap this out with something like Puppet
  config.vm.provision :shell, :path => "scripts/mount-webroot.sh"
  config.vm.provision :shell, :path => "scripts/php.sh", :args => "-v 5.6 -m 256 -t UTC"
  config.vm.provision :shell, :path => "scripts/php-mcrypt.sh"
  config.vm.provision :shell, :path => "scripts/composer.sh"
  #config.vm.provision :shell, :path => "scripts/install-silverstripe.sh", :args => "-v 3.x-dev"
  config.vm.provision :shell, :path => "scripts/apache.sh"
  config.vm.provision :shell, :path => "scripts/mariadb.sh"
  #config.vm.provision :shell, :path => "scripts/mysql-57.sh"
  #config.vm.provision :shell, :path => "scripts/xdebug.sh"
  #config.vm.provision :shell, :path => "scripts/ntp.sh"
  #config.vm.provision :shell, :path => "scripts/node.sh"
  #config.vm.provision :shell, :path => "scripts/bower.sh"
  #config.vm.provision :shell, :path => "scripts/gulp.sh"
  #config.vm.provision :shell, :path => "scripts/grunt.sh"
  #config.vm.provision :shell, :path => "scripts/grunt-watch.sh"
  #config.vm.provision :shell, :path => "scripts/sass.sh"
  #config.vm.provision :shell, :path => "scripts/less.sh"
  config.vm.provision :shell, :path => "scripts/silverstripe-tasks.sh"
  #config.vm.provision :shell, :path => "scripts/sspak.sh"
  config.vm.provision :shell, :path => "scripts/mailcatcher.sh"
  config.vm.provision :shell, :path => "scripts/bootstrap.sh"
  config.vm.provision :shell, :path => "scripts/always.sh", run: "always"

end
