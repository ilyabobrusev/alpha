nano ipSetupCentos.sh
#!/bin/bash
hostnamectl set-hostname co$1
sed -i "s/IPADDR=\"192.168.1.*\"/IPADDR=\"192.168.1.$1\"/" /etc/sysconfig/network-scripts/ifcfg-ens3
reboot

