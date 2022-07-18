nano setconf.sh
#!/bin/bash
hostnamectl set-hostname co$1
sed -i "s/IPADDR=\"192.168.111.*\"/IPADDR=\"192.168.111.$1\"/" /etc/sysconfig/network-scripts/ifcfg-enp1s0
reboot

