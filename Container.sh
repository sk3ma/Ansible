#!/usr/bin/env bash

# Declaring variables.
DISTRO=$(lsb_release -ds)
VERSION=$(lsb_release -cs)

# Welcome message.
cat << STOP
--------------------------
# Welcome to the script. #
--------------------------
                    ##        .            
              ## ## ##       ==            
           ## ## ## ##      ===            
       /""""""""""""""""\___/ ===        
  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
       \______ o          __/            
         \    \        __/             
          \____\______/                    
STOP

# Docker installation.
install() {
    echo -e "\e[96;1;3mDistribution: ${DISTRO}\e[m"
    echo -e "\e[32;1;3mUpdating system\e[m"
    apt update
    echo -e "\e[32;1;3mAdding repository\e[m"
    apt install apt-transport-https ca-certificates software-properties-common curl -qy
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu ${VERSION} stable" -y
    echo -e "\e[32;1;3mInstalling Docker\e[m"
    apt install docker-ce docker-ce-cli docker-compose containerd.io -qy
    usermod -aG docker ${USER}
    chmod a=rw /var/run/docker.sock
    echo -e "\e[32;1;3mCreating volume\e[m"
    mkdir -pv /container
    docker volume create bindmount
}

# Enabling service.
service() {
    echo -e "\e[32;1;3mStarting service\e[m"
    systemctl start docker
    systemctl enable docker
    echo -e "\e[33;1;3;5mFinished, Docker installed.\e[m"
    exit
}

# Calling functions.
if [[ -f /etc/lsb-release ]]; then
    echo -e "\e[35;1;3;5mUbuntu detected, proceeding...\e[m"
    install
    service
fi
