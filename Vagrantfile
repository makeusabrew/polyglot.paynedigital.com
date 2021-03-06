# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.hostname = "polyglot.paynedigital.com"

  # nginx
  config.vm.network :forwarded_port, guest: 80, host: 9998

  # golang testing
  config.vm.network :forwarded_port, guest: 8081, host: 8081
  # nodejs testing
  config.vm.network :forwarded_port, guest: 8082, host: 8082
  # php testing
  config.vm.network :forwarded_port, guest: 8083, host: 8083

  # rails testing
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  # make sure everything's up to date first; makes our puppet
  # manifests a bit cleaner
  config.vm.provision :shell, :inline => "apt-get update -q"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "conf/puppet/manifests"
    puppet.module_path   = "conf/puppet/modules"
    #puppet.options = "--verbose --debug"
  end


  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network :private_network, ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.
end
