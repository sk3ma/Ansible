# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # Configuring hardware resources.
  config.vm.provider "virtualbox" do |v|
    v.memory = 4096
    v.cpus   = 2
    v.gui    = false
#    v.name   = "Ubuntu-20.04"
  end
  # Customizing Ansible server.
    config.vm.define "controller" do |c|
    c.vm.box              = "bento/ubuntu-20.04"
    c.vm.box_check_update = false
    c.ssh.forward_agent   = true
    c.vm.hostname         = "controller"
    # Defining the network.
#    c.vm.network "private_network", type: "dhcp"
    c.vm.network "private_network", ip: "192.168.56.71"
#    c.vm.network "forwarded_port", guest: 22, host: 2299, auto_correct: true
    c.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
    # Executing inline scripts.
    c.vm.provision "shell", inline: <<-SHELL
      echo -e "\e[32;1;3m[INFO] Installing Ansible\e[m"
      sudo apt update && sudo apt install screenfetch -y
      echo '/usr/bin/screenfetch' >> /home/vagrant/.bashrc
      sudo chmod a-x /etc/update-motd.d/00-header
      sudo chmod a-x /etc/update-motd.d/99-bento
      echo "export PS1='\\[\e]0;\\u@\\h: \\w\\a\\]\${debian_chroot:+(\$debian_chroot)}\\[\\033[01;36m\\]\\u\\[\\033[00m\\]\\[\\033[01;37m\\]@\\[\\033[00m\\]\\[\\033[01;35m\\]\\h\\[\\033[00m\\]\\[\\033[01;37m\\]:\\[\\033[00;34m\\]\\w\\[\\033[00m\\]\\$ '" >> /home/vagrant/.bashrc
      sudo apt-add-repository ppa:ansible/ansible -y
      sudo apt install ansible sshpass yamllint ansible-lint software-properties-common tree -y
      ansible-galaxy collection install community.zabbix
      echo -e "\e[32;1;3m[INFO] Configuring Ansible\e[m"
      echo -e "192.168.56.70    controller" >> /etc/hosts
      echo -e "192.168.56.72    node1" >> /etc/hosts
      echo -e "192.168.56.73    node2" >> /etc/hosts
      mkdir -p /srv/ansible/{tasks,handlers,defaults,vars,scripts,templates}
      touch /srv/ansible/main.yml
      tee /srv/ansible/inventory << STOP > /dev/null
localhost ansible_connection=local
node1 ansible_ssh_host=192.168.56.72 ansible_ssh_pass=ansible ansible_user=ansible
node2 ansible_ssh_host=192.168.56.73 ansible_ssh_pass=ansible ansible_user=ansible
STOP
      tee /srv/ansible/ansible.cfg << STOP > /dev/null
[defaults]
inventory = /srv/ansible/inventory

[privilege_escalation]
become = True
become_method = sudo
become_user = root
become_ask_pass = False
STOP
      echo -e "\e[36;1;3;5m[INFO] System online\e[m"
    SHELL
    # Script to bootstrap.
#    c.vm.provision "shell", path: "AWX.sh", privileged: true
    end
  # Customizing Ubuntu client.
    config.vm.define "node1" do |x|
    x.vm.box              = "bento/ubuntu-20.04"
    x.vm.box_check_update = false
    x.ssh.forward_agent   = true
    x.vm.hostname         = "node1"
    # Defining the network.
#    x.vm.network "private_network", type: "dhcp"
    x.vm.network "private_network", ip: "192.168.56.72"
    x.vm.network "forwarded_port", guest: 80, host: 8081, auto_correct: true
    # Preparing Ubuntu installation.
    x.vm.provision "shell", inline: <<-SHELL
      sudo apt update && sudo apt install screenfetch -y
      echo '/usr/bin/screenfetch' >> /home/vagrant/.bashrc
      sudo chmod a-x /etc/update-motd.d/00-header
      sudo chmod a-x /etc/update-motd.d/99-bento
      echo "export PS1='\\[\e]0;\\u@\\h: \\w\\a\\]\${debian_chroot:+(\$debian_chroot)}\\[\\033[01;32m\\]\\u\\[\\033[00m\\]\\[\\033[01;31m\\]@\\[\\033[00m\\]\\[\\033[01;33m\\]\\h\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\$ '" >> /home/vagrant/.bashrc
      cat << STOP > /etc/hosts
127.0.0.1       localhost
127.0.1.1       node1
192.168.56.70   controller
192.168.56.73   node2
STOP
      echo -e "\e[36;1;3;5m[INFO] System online\e[m"
    SHELL
    end
  # Customizing Ubuntu client.
    config.vm.define "node2" do |y|
    y.vm.box              = "bento/ubuntu-20.04"
    y.vm.box_check_update = false
    y.ssh.forward_agent   = true
    y.vm.hostname         = "node2"
    # Defining the network.
#    y.vm.network "private_network", type: "dhcp"
    y.vm.network "private_network", ip: "192.168.56.73"
    y.vm.network "forwarded_port", guest: 80, host: 8082, auto_correct: true
    # Preparing Ubuntu installation.
    y.vm.provision "shell", inline: <<-SHELL
      sudo apt update && sudo apt install screenfetch -y
      echo '/usr/bin/screenfetch' >> /home/vagrant/.bashrc
      sudo chmod a-x /etc/update-motd.d/00-header
      sudo chmod a-x /etc/update-motd.d/99-bento
      echo "export PS1='\\[\e]0;\\u@\\h: \\w\\a\\]\${debian_chroot:+(\$debian_chroot)}\\[\\033[01;32m\\]\\u\\[\\033[00m\\]\\[\\033[01;31m\\]@\\[\\033[00m\\]\\[\\033[01;33m\\]\\h\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\$ '" >> /home/vagrant/.bashrc
      cat << STOP > /etc/hosts
127.0.0.1       localhost
127.0.1.1       node2
192.168.56.70   controller
192.168.56.72   node1
STOP
      echo -e "\e[36;1;3;5m[INFO] System online\e[m"
    SHELL
    end
end
