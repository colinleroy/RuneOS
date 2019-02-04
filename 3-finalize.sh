#!/bin/bash
ansible-playbook -i hosts --ask-become-pass runeaudio-finalize.yml
