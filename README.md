# Description
Repository of packages and configuration files to build RuneOS using Ansible.

# Installation
Installation is done in two phases. Image generation is optionally done in a
third phase.

## Prerequisites
Install Ansible on your computer. Adapt runeaudio-vars.yml to your liking 
(especially the first sections describing mount points and distribution
URL). You need sudo access on your computer.

## 1-prepare.sh 
First the runeaudio-prepare.yml Ansible playbook is run with the microSD card in
the host computer. This phase downloads ArchlinuxARM, partitions the SD card and
copies the stock distribution on the card.

**Warning: make sure the `local_sd` section in `runeaudio-vars.yml` is correct,
or Ansible will wreck the wrong blockdevice with zero confirmation at all.**

Insert your SD card in your computer and run:

```
./1-prepare.sh
```



## 2-configure.sh
At the end of the first phase, you can remove the microSD card from your computer,
insert it in your Raspberry and boot it with wired ethernet plugged in.

Once booted, you should see a login tty with the DHCP IP assigned to the Raspberry.

Note this IP address and, replacing 192.168.X.Y with the Raspberry's IP, run:

```
./2-configure.sh 192.168.X.Y
```

This second phase configures Archlinux to initialize Pacman, install required
packages, build Runeaudio-specific packages, install RuneUI etc.

Once it is done, you can reboot your Raspberry and Runeaudio should be ready to
use.

## 3-finalize.sh
This optional phase is done on your computer. It generates a .img.gz file that
is suitable for Etcher to write on other SD cards.

Insert the SD card and start:

```
./3-finalize.sh
```

This phase writes a zero-filled file across all the filesystem's free space,
removes it, then dumps the SD card bit-by-bit to a .img.gz file. Before generating
the image, the directories `/usr/local/src/` (for space reasons) and `/root/.ssh/`
(for safety reasons) are removed.

## Caveats
This installer is loosely based on the cookbook found at:
https://github.com/gearhead/RuneOS/tree/master/scripts

There are some differences with the standard RuneAudio distribution:

- nginx is from Archlinux instead of being rebuilt
- Spotify doesn't work (they pulled libspotify from the Internet and I didn't
  want this installer to depend on binaries)
- The kernel is the standard one

My end goal is to remove the maximum possible number of non-standard packages to
improve maintainability.