#!/bin/bash
hostnamectl set-hostname co$1
sed -i "s/IPADDR=192.168.122.*/IPADDR=192.168.122.$1/" /etc/sysconfig/network-scripts/ifcfg-enp1s0
sed -i "s/192.168.122.*/192.168.122.$1 co$1 co$1.loc/" /etc/hosts
reboot