#!/usr/bin/env bash

if [ "$EUID" -ne 0 ]
  then echo 'Требуются права суперпользователя'
  exit 1
fi

source "$(dirname "$0")/executor.sh"

salt-key -L
salt-key -l accepted
salt-key -A
salt-key -a '*-red'
salt-key -D
salt-key -d '*-blue'
