# -*- mode: ruby -*-
# vi: set ft=ruby :

#If this is set, Vagrant will not perform any parallel operations (such as parallel box provisioning). All operations will be performed in serial.
ENV['VAGRANT_NO_PARALLEL'] = 'yes' 


Vagrant.configure("2") do |config|

  # script to provision the server
  config.vm.provision "shell", path: "bootstrap.sh"
  

  config.vbguest.auto_update = false

  config.vm.provision "shell" do |s|
    ssh_pub_key = File.readlines("#{Dir.home}/.ssh/id_rsa.pub").first.strip
    s.inline = <<-SHELL
      echo #{ssh_pub_key} >> /home/vagrant/.ssh/authorized_keys
    SHELL
  end

  # k8s-master provisioning
  (1..3).each do |i|
    config.vm.define "k8s-master0#{i}" do |node|
      node.vm.box = "centos/7"
      node.vm.hostname = "k8s-master0#{i}.local"
      
      node.vm.network "private_network", ip: "192.168.56.10#{i}"
      
      # vm_specs
      node.vm.provider "virtualbox" do |vconf|

        vconf.name = "k8s-master0#{i}"
        vconf.memory = 2048
        vconf.cpus = 2
      end

    end
  end

  # k8s-worker provisioning
  (1..1).each do |i|
    config.vm.define "k8s-worker0#{i}" do |node|
      node.vm.box = "centos/7"
      node.vm.hostname = "k8s-worker0#{i}.local"
      
      node.vm.network "private_network", ip: "192.168.56.11#{i}"
      
      # vm_specs
      node.vm.provider "virtualbox" do |vconf|

        vconf.name = "k8s-worker0#{i}"
        vconf.memory = 1024
        vconf.cpus = 1
      end

    end
  end

  # lb provisioning
  (1..2).each do |i|
    config.vm.define "lb0#{i}" do |node|
      node.vm.box = "centos/7"
      node.vm.hostname = "lb0#{i}.local"
      
      node.vm.network "private_network", ip: "192.168.56.12#{i}"
      
      # vm_specs
      node.vm.provider "virtualbox" do |vconf|

        vconf.name = "lb0#{i}"
        vconf.memory = 1024
        vconf.cpus = 1
      end

    end
  end

  # ansible provisioning
  (1..1).each do |i|
    config.vm.define "ansible#{i}" do |node|
      node.vm.box = "centos/7"
      node.vm.hostname = "ansible#{i}.local"
      
      node.vm.network "private_network", ip: "192.168.56.14#{i}"
      
      # vm_specs
      node.vm.provider "virtualbox" do |vconf|

        vconf.name = "ansible#{i}"
        vconf.memory = 1024
        vconf.cpus = 1
      end

    end
  end

end