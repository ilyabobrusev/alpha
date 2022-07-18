#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo 'Требуются права суперпользователя'
  exit 1
fi

source "$(dirname "$0")/executor.sh"

salt '*' test.ping
salt '*' saltutil.sync_all
salt '*' system.reboot
