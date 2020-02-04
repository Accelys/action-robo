#!/bin/bash

set -e

if [[ ! -z "${SSH_PRIVATE_KEY}" ]]; then
  eval $(ssh-agent -s)
  echo -e "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
  echo "$SSH_PRIVATE_KEY" | tr -d '\r' > /tmp/id_rsa
  chmod 600 /tmp/id_rsa
  ssh-add /tmp/id_rsa
fi

if [ -z "$1" ]; then
    CMD_ARGS=""
else
    CMD_ARGS="$@"
fi

robo --version
echo ${PWD}
ls -la
robo $CMD_ARGS
