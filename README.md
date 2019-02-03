# Description
Repository of packages and configuration files to build RuneOS using Ansible

# Installation
Install Ansible and sshpass locally

Adapt runeaudio-vars.yml (especially blockdevice, distribution)

Insert micro-SD in your computer and start

./1-local.sh

Install micto-SD in the Raspberry, let it boot and get its IP, then start
./2-remote.sh 192.168.X.Y #use the Raspberry's IP
