#!/usr/bin/env bash 

# This only needs to be run for the desktop setup, not the laptop setup, so I split it into two parts.

#This is for controlling my Corsair Keyboard's RGB lighting.
sudo add-apt-repository ppa:tatokis/ckb-next
sudo apt update
sudo apt install ckb-next -y