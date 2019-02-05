#!/bin/bash

if [ "$1" = "" ]; then
	echo "Usage: $0 [target-ip]"
	exit 1
fi

. ./.setup-ssh-key.sh $1

ansible-playbook -i hosts $EXTRA_ARGS --user root runeaudio-personalize.yml --extra-vars "raspberry_ip=$1"
