#!/bin/bash
hostnamectl set-hostname rhel$1
sed -i "s/IPADDR=192.168.1.*/IPADDR=192.168.1.$1/" /etc/sysconfig/network-scripts/ifcfg-ens160
sed -i "s/192.168.1.*/192.168.122.$1 rhel$1 rhel$1.loc/" /etc/hosts
reboot