Vagrant.configure("2") do |config|

  config.vm.box = "flask-angularjs-monitor-memcached"
  
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 5000, host: 5000

  #network
  #config.vm.network :private_network, ip: "192.168.33.10"
  config.vm.network "public_network"
  
  #shared
  #config.vm.synced_folder "~/Development/Projects", "/projects", type: 'nfs'

  #virtualbox
  #if defined? VagrantVbguest
  #  config.vbguest.auto_update = true
  #end
  #config.vm.provider :virtualbox do |vb|
  #  vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  #  vb.customize ["modifyvm", :id, "--memory", "1024"]
  #end

  #config.vm.provision :puppet do |puppet|
  #  puppet.manifests_path = "manifests"
  #  puppet.manifest_file  = "init.pp"
  #  puppet.module_path = "modules"
  #  puppet.options = "--verbose --debug"
    #puppet.options = "--verbose --noop"
  #end
end
