#!/bin/bash

if [ "$1" = "" ]; then
	echo "Usage: $0 [target-ip]"
	exit 1
fi
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

ssh root@$1 "which python || (pacman-key --init && pacman-key --populate archlinuxarm && pacman -S python --noconfirm)"

ansible-playbook -i hosts $EXTRA_ARGS --user root runeaudio-configure.yml --extra-vars "raspberry_ip=$1"
