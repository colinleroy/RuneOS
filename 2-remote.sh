#!/bin/bash

if [ "$1" = "" ]; then
	echo "Usage: $0 [target-ip]"
	exit 1
fi

ssh -vv root@$1 "which python || (pacman-key --init && pacman-key --populate archlinuxarm && pacman -S python --noconfirm)"

ansible-playbook -i hosts --ask-pass --user root runeaudio-configure.yml --extra-vars "raspberry_ip=$1"
