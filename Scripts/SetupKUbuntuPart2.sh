#!/usr/bin/env bash 

# This only needs to be run for the desktop setup, not the laptop setup, so I split it into two parts.

#This is for controlling my Corsair Keyboard's RGB lighting.
sudo add-apt-repository ppa:tatokis/ckb-next
sudo apt update
sudo apt install ckb-next -y

# OpenDeck (like StreamDeck, but open source)
sudo flatpak install me.amankhanna.opendeck -y

# This is required for the OpenDeck Nuke button
sudo apt install wmctrl xdotool -y