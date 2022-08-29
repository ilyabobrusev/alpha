#!/bin/bash
hostnamectl set-hostname d11-$1
sed -i "s/address 192.168.111.*\/24/address 192.168.111.$1\/24/" /etc/network/interfaces
sed -i "s/192.168.111.*/192.168.111.$1 d11-$1 d11-$1.loc/" /etc/hosts
reboot