#!/usr/bin/env bash

# Declaring variable.
DISTRO=$(lsb_release -ds)

# Welcome message.
cat << STOP
#--------------------#
# Welcome to Ubuntu. #
#--------------------#

                    ##        .            
              ## ## ##       ==            
           ## ## ## ##      ===            
       /""""""""""""""""\___/ ===        
  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
       \______ o          __/            
         \    \        __/             
          \____\______/                    

STOP

# Package installation.
system() {
    echo -e "\e[96;1;3mDistribution: ${DISTRO}\e[m"
    sudo apt update
    echo -e "\e[32;1;3mInstalling packages\e[m"
    sudo apt install nodejs npm -y
    sudo npm install npm --global
    sudo apt install python3-pip git -y
}

# Docker installation.
container() {
    echo -e "\e[32;1;3mInstalling packages\e[m"
    sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
    echo -e "\e[32;1;3mInstalling Docker\e[m"
    sudo apt install docker-ce docker-compose -y
    pip3 install docker-compose==1.25.0
}

# Ansible installation.
awx() {
    echo -e "\e[32;1;3mInstalling Ansible\e[m"
    cd /tmp
    sudo apt install pwgen unzip ansible -y
    local secret=$(pwgen -N 1 -s 40)
    wget https://github.com/ansible/awx/archive/17.1.0.zip
    unzip 17.1.0.zip
    cd awx-17.1.0/installer
    sudo rm -f inventory
    sudo tee inventory << STOP
[localhost]
admin_user=admin
admin_password=password
secret_key=${secret}
STOP
    echo -e "\e[32;1;3mExecuting playbook\e[m"
    ansible-playbook -i inventory install.yml
    echo -e "\e[33;1;3;5mFinished, installation complete.\e[m"
    exit
}

# Calling functions.
if [[ -f /etc/lsb-release ]]; then
    echo -e "\e[35;1;3;5mUbuntu detected, proceeding...\e[m"
    system
    container
    awx
fi
