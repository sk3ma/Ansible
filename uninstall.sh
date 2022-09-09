#!/usr/bin/env bash

# Removing old agent.
uninstall() {
    echo -e "\e[96;1;3mDistribution: $(lsb_release -ds)\e[m"
    echo -e "\e[32;1;3mRemoving agent\e[m"
    systemctl stop zabbix-agent
    apt purge zabbix-agent -y
    echo -e "\e[32;1;3mRemoving configuration\e[m"
    rm -rf /etc/zabbix/*
    rm -rf /var/run/zabbix/
    echo -e "\e[33;1;3;5mFinished, agent removed.\e[m"
    exit
}

# Sanity checking.
if ! [[which /usr/sbin/zabbix_agentd &> /dev/null]]; then
    uninstall
fi
