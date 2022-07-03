#! /bin/bash

if [ "$EUID" -ne 0 ]
  then echo 'Требуются права суперпользователя'
  exit 1
fi

install -v etc/salt/cloud.* /etc/salt/
install -v etc/salt/master /etc/salt/

dirs=(salt pillar)

for d in "${dirs[@]}"; do
  rm -v -r -f "/srv/$d"
  cp -v -r --remove-destination "srv/$d/" /srv/
done
