#!/bin/bash
hostnamectl set-hostname d11-$1
sed -i "s/address 192.168.111.*\/24/address 192.168.111.$1\/24/" /etc/network/interfaces
sed -i "s/192.168.111.*/192.168.111.$1 d11-$1 d11-$1.loc/" /etc/hosts
reboot

#!/bin/bash
hostnamectl set-hostname d11-$1
sed -i "s/address 192.168.122.*/address 192.168.122.$1/" /etc/network/interfaces
sed -i "s/192.168.122.*/192.168.122.$1  d11-$1/" /etc/hosts
ip addr flush dev enp1s0; systemctl restart networking
