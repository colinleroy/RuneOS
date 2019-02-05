#!/bin/bash

ssh-keygen -f "~/.ssh/known_hosts" -R $1
if [ -f ~/.ssh/id_rsa.pub ]; then
    ssh-copy-id -i ~/.ssh/id_rsa.pub root@$1
else
    sshpass=$(which sshpass 2>&1)
    if [ "$sshpass" = "" ]; then
        echo "Please install sshpass"
        exit 1
    else
        EXTRA_ARGS="--ask-pass"
    fi
fi
