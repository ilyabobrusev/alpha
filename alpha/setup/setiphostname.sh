#!/bin/bash
hostnamectl set-hostname co$1
sed -i "s/IPADDR=\"192.168.1.*\"/IPADDR=\"192.168.1.$1\"/" /etc/sysconfig/network-scripts/ifcfg-eth0
reboot

