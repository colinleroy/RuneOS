#!/bin/bash

if [ "$1" = "" ]; then
	echo "Usage: $0 [target-ip]"
	exit 1
fi
ssh-keygen -f "~/.ssh/known_hosts" -R $1
[ -f ~/.ssh/id_rsa.pub ] && ssh-copy-id -i ~/.ssh/id_rsa.pub root@$1

ssh root@$1 "which python || (pacman-key --init && pacman-key --populate archlinuxarm && pacman -S python --noconfirm)"

ansible-playbook -i hosts --ask-pass --user root runeaudio-configure.yml --extra-vars "raspberry_ip=$1"
