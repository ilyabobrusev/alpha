#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo 'Требуются права суперпользователя'
  exit 1
fi

source "$(dirname "$0")/executor.sh"

salt '*-blue' test.ping
salt -G 'os:CentOS Stream' test.ping
salt -N blue test.ping

# Кладём в переменную адрес Debian-машины
deb_ip=$(salt 'salt-owls-green' network.ipaddrs --out=newline_values_only)
salt -C "( G@os:CentOS* and *blue ) or S@${deb_ip}" test.ping
