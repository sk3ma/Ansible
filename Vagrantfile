# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Configuring hardware resources.
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus = 2
    v.gui = false
  end
  # Customizing Ubuntu server.
    config.vm.define "controller" do |c|
    c.vm.box = "bento/ubuntu-20.04"
    c.vm.box_check_update = false
    c.ssh.forward_agent = true
    c.vm.hostname = "controller"
    # Defining the network.
    c.vm.network "private_network", ip: "192.168.56.70"
    c.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
    # Preparing Ubuntu installation.
    c.vm.provision "shell", inline: <<-SHELL
    echo -e "\e[36;1;3;5mSystem online...\e[m"
    SHELL
    end
  # Customizing Ubuntu server.
    config.vm.define "node1" do |x|
    x.vm.box = "bento/ubuntu-20.04"
    x.vm.box_check_update = false
    x.ssh.forward_agent = true
    x.vm.hostname = "node1"
    # Defining the network.
    x.vm.network "private_network", ip: "192.168.56.72"
    x.vm.network "forwarded_port", guest: 80, host: 8081, auto_correct: true
    # Preparing Ubuntu installation.
    x.vm.provision "shell", inline: <<-SHELL
    echo -e "\e[36;1;3;5mSystem online...\e[m"
    SHELL
    end
  # Customizing Ubuntu server.
    config.vm.define "node2" do |y|
    y.vm.box = "bento/ubuntu-20.04"
    y.vm.box_check_update = false
    y.ssh.forward_agent = true
    y.vm.hostname = "node2"
    # Defining the network.
    y.vm.network "private_network", ip: "192.168.56.73"
    y.vm.network "forwarded_port", guest: 80, host: 8082, auto_correct: true
    # Preparing Ubuntu installation.
    y.vm.provision "shell", inline: <<-SHELL
    echo -e "\e[36;1;3;5mSystem online...\e[m"
    SHELL
    end
end
