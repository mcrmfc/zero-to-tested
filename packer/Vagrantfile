# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure(2) do |config|
  config.vm.box = "bento/ubuntu-14.04"
  config.vm.network "private_network", ip: "192.168.33.10"
   config.vm.provider "virtualbox" do |vb|
      vb.memory = "3072"
      vb.cpus = 2
   end
  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'zero-to-tested-chef'
  end
end
