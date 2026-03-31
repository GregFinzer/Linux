#!/usr/bin/env bash 

# Set Variables 
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)" 

# Make supporting scripts executable
cd "$SCRIPT_DIR"
chmod +x InstallFromRemote.sh
chmod +x create-pwa.sh
chmod +x flatpak-full-permissions.sh
chmod +x InstallSqlServerOnKUbuntu.sh

# 📁 Go to Downloads as we will be downloading stuff 
cd ~/Downloads 

# Update apt repository
sudo apt update 

# 📋 Prerequisites 
# curl: https://curl.se/
# wget: https://www.gnu.org/software/wget/
# gpg: https://www.gnupg.org/
# apt-transport-https: https://manpages.debian.org/unstable/apt/apt-transport-https.1.en.html
sudo apt install curl wget gpg apt-transport-https -y 

# 🔥🧱 Turn on Firewall
sudo ufw --force enable

# Firewall GUI (like Windows Defender Firewall)
# This is already on KUbuntu
# sudo apt install gufw -y

# 🛒 ******************** Package, Store Related
# Ye ole store for only apt packages
sudo apt install synaptic -y 

# Flatpak with Flathub
# See:  https://docs.flathub.org/docs/for-users/installation
sudo apt install flatpak -y 

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Update the flatpak repository 
flatpak update --appstream

# Add flatpak to KDE Discover
sudo apt install plasma-discover-backend-flatpak -y

# Flatseal (allows you to change Flatpak permissions)
sudo flatpak install flathub com.github.tchx84.Flatseal -y

# Reboot here


# 🎬 ******************* Media 
# GIMP (like Photoshop)
sudo flatpak install flathub org.gimp.GIMP -y

# Pinta (like Micrsoft Paint)
sudo flatpak install flathub pinta -y

# Flameshot (like PicPick)
sudo flatpak install flathub org.flameshot.Flameshot -y

# Draw.io (like Visio)
sudo flatpak install flathub drawio -y

# Spotify
sudo flatpak install flathub spotify -y

# DeaDBeef (like Media Play with Shuffle for mp3s)
sudo snap install deadbeef-vs 

# VLC (like Media Player or Any Video Converter)
sudo flatpak install flathub org.videolan.VLC -y

# Kdenlive (like Adobe Premiere Pro or Filmora)
sudo flatpak install flathub kdenlive -y

# Audacity (audio editor)
sudo flatpak install flathub org.audacityteam.Audacity -y

# Buzz (like Windows Speech to Text)
sudo flatpak install flathub io.github.chidiwilliams.Buzz -y

# OBS Studio (screen recorder like ShareX)
sudo flatpak install flathub com.obsproject.Studio -y

# Webcam testing 
sudo flatpak install flathub cheese -y

# Plex Media Server
#curl https://downloads.plex.tv/plex-keys/PlexSign.key | \
#sudo gpg --dearmor -o /usr/share/keyrings/plex.gpg
#echo "deb [signed-by=/usr/share/keyrings/plex.gpg] \
#https://downloads.plex.tv/repo/deb public main" | \
#sudo tee /etc/apt/sources.list.d/plexmediaserver.list 
#sudo apt update
#sudo apt install plexmediaserver -y

# ▶️ 💬 ******************* Video Conferencing and Messaging 
sudo flatpak install flathub com.github.IsmaelMartinez.teams_for_linux -y
sudo flatpak install flathub com.slack.Slack -y
sudo flatpak install flathub us.zoom.Zoom -y
 

# 🌐 ******************* Web 

# Brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
sudo curl -fsSLo /etc/apt/sources.list.d/brave-browser-release.sources https://brave-browser-apt-release.s3.brave.com/brave-browser.sources
sudo apt update
sudo apt install brave-browser -y

# Uninstall Firefox as a Snap
sudo snap remove firefox

# Firefox Flatpak
sudo flatpak install flathub org.mozilla.firefox -y

# Install Chrome 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
sudo apt install ./google-chrome-stable_current_amd64.deb 

# Set Brave as default browser 
xdg-settings set default-web-browser brave-browser.desktop
xdg-mime default brave-browser.desktop x-scheme-handler/http
xdg-mime default brave-browser.desktop x-scheme-handler/https
xdg-mime default brave-browser.desktop text/html 


# 🖇️ ******************* Office 
sudo flatpak install flathub com.todoist.Todoist -y
#Already installed on Linux Mint
# sudo flatpak install flathub org.libreoffice.LibreOffice -y
sudo flatpak install flathub org.onlyoffice.desktopeditors -y
sudo flatpak install flathub com.collaboraoffice.Office -y
 
# 🧰 ******************* Install Utilities 

# Like Directory Opus Get Sizes
sudo apt install qdirstat -y

# Plugins for dolphin
# sudo apt install dolphin-plugins kio-extras ark kfind -y

# LocalSend (like airdrop, snapdrop or filedrop)
sudo flatpak install flathub org.localsend.localsend_app -y

# Timeshift (like system restore) (Linux mint already has this installed by default)
sudo apt install timeshift -y

# Like SysMain (SuperFetch)
# This does not make a noticible impact unless you have a physical hard drive 
# sudo apt install preload -y

# Latest Release of Balena Etcher
"$SCRIPT_DIR/InstallFromRemote.sh" https://github.com/balena-io/etcher/releases .deb

# ISO Image Writer (like Rufus or Balena Etcher)
# sudo flatpak install flathub org.kde.isoimagewriter -y

# BleachBit (like CCleaner)
sudo flatpak install flathub bleachbit -y

# KDE Connect (like Phone Link on Windows) (already on KDE)
# sudo flatpak install flathub kdeconnect -y

# Scheduled backups
# ssudo flatpak install flathub org.gnome.World.PikaBackup -y

# View chm files 
sudo apt install xchm -y

# Transfer over FTP and SFTP
sudo flatpak install flathub filezilla -y

# Install Fish Shell and make it the default (you have to logout and log back in to see the changes)
# After run this and change them to Darkula:  fish_config
sudo apt install fish -y 
sudo chsh -s $(which fish)

# Stacer (Like Task Manager and manage startup programs) 
sudo apt install stacer -y 

# Mission Center (like Task Manager)
sudo flatpak install flathub io.missioncenter.MissionCenter -y

# Beyond Compare 
"$SCRIPT_DIR/InstallFromRemote.sh" https://www.scootersoftware.com/download .deb

# Configure Diff
git config --global diff.tool bc
git config --global difftool.bc.trustExitCode true

# Configure Merge
git config --global merge.tool bc
git config --global mergetool.bc.trustExitCode true

# Searchmonkey (like grep but with a GUI)
sudo apt install searchmonkey -y
 
# Like Crystal Disk Mark
# sudo flatpak install flathub KDiskMark -y

# Weather App
# sudo flatpak install flathub io.github.amit9838.mousam -y

# PWA 
# Regular Expression Tester
"$SCRIPT_DIR/create-pwa.sh" https://regex101.com/ 

# Make Outlook.com look like an app
"$SCRIPT_DIR/create-pwa.sh" https://outlook.live.com/mail/

# Another Nice Online Photo Editor
# "$SCRIPT_DIR/create-pwa.sh" https://www.photopea.com/

# Bottles
# sudo flatpak install flathub com.usebottles.bottles -y

# Give the flatpak all permissions
# "$SCRIPT_DIR/flatpak-full-permissions.sh" com.usebottles.bottles

# 👨‍💻 ******************* Install Developer Tools 
# Data Beaver (Like Database.NET or SQL Server Management Studio)
sudo flatpak install flathub io.dbeaver.DBeaverCommunity -y

# TextPieces (Developer Text formatting)
sudo flatpak install io.gitlab.liferooter.TextPieces -y

# Developer Toolbox (Converters, Decoders, Formatters, Generators, Text, Regex, Markdown)
sudo flatpak install flathub me.iepure.devtoolbox -y

# Install Git 
sudo apt install git -y 

# GitHub Desktop
sudo flatpak install flathub io.github.shiftey.Desktop -y

# API Testing
sudo flatpak install flathub postman -y

# Install VS Code from Microsoft Official 
# From here:  https://code.visualstudio.com/docs/setup/linux
sudo apt-get install wget gpg &&
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg &&
sudo install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg &&
rm -f microsoft.gpg

sudo tee /etc/apt/sources.list.d/vscode.sources > /dev/null <<EOF
Types: deb
URIs: https://packages.microsoft.com/repos/code
Suites: stable
Components: main
Architectures: amd64,arm64,armhf
Signed-By: /usr/share/keyrings/microsoft.gpg
EOF

sudo apt install apt-transport-https &&
sudo apt update &&
sudo apt install code # or code-insiders


# Install Rider (the only SNAP package in this script because the Flatpak is not official)
sudo snap install rider --classic 

# Install .NET Version 8 SDK 
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh 
chmod +x ./dotnet-install.sh 
./dotnet-install.sh --channel 8.0 

# Install NVM and Node for Bash Shell 
# curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# source ~/.bashrc
# nvm install --lts 
# nvm alias default lts/*
# node -v 
# npm -v 

# Install NVM and Node for Fish Shell 
# curl -sL https://git.io/fisher | source 
# fisher install jorgebucaran/fisher 
# fisher install jorgebucaran/nvm.fish 
# nvm install lts 
# node -v 
# npm -v 
 
# Git Username and email
git config --global user.name "Greg Finzer" 
git config --global user.email "gfinzer@hotmail.com" 

# Clone Repos
cd ~/_git
git clone https://github.com/GregFinzer/BedBrigadeNational.git

# Setup Docker and SQL Server
cd "$SCRIPT_DIR"
./InstallSqlServerOnKUbuntu.sh

# Oracle VirtualBox
"$SCRIPT_DIR/InstallFromRemote.sh" https://www.virtualbox.org/wiki/Linux_Downloads noble_amd64.deb
wget -P ~/Downloads https://download.virtualbox.org/virtualbox/7.2.6/Oracle_VirtualBox_Extension_Pack-7.2.6.vbox-extpack

# Syncthing (like a free Dropbox or Onedrive)
echo "📦 Installing Syncthing..."
sudo apt install -y syncthing

echo "🚀 Launching Syncthing..."
if command -v gnome-terminal >/dev/null; then
    gnome-terminal -- bash -c "syncthing; exec bash"
elif command -v x-terminal-emulator >/dev/null; then
    x-terminal-emulator -e syncthing
elif command -v konsole >/dev/null; then
    konsole -e syncthing
else
    echo "⚠️ No supported terminal found."
    syncthing &
fi

# Auto-start Syncthing
systemctl --user enable syncthing
systemctl --user start syncthing
