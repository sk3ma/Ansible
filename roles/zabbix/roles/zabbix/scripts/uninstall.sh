#!/usr/bin/env bash

# Removing old agent.
uninstall() {
    echo -e "\e[96;1;3m[OK] Distribution: $(lsb_release -ds)\e[m"
    echo -e "\e[32;1;3m[INFO] Removing agent\e[m"
    systemctl stop zabbix-agent
    apt purge zabbix-agent -y
    echo -e "\e[32;1;3m[INFO] Removing configuration\e[m"
    rm -rf /etc/zabbix/*
    rm -rf /var/run/zabbix/
    echo -e "\e[33;1;3;5m[INFO] Finished, agent removed.\e[m"
    exit
}

# Sanity checking.
if [[! which /usr/sbin/zabbix_agentd &> /dev/null]]; then
    uninstall
fi
