#!/usr/bin/env bash 

# Set Variables 
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)" 

# Make supporting scripts executable
cd "$SCRIPT_DIR"
chmod +x InstallFromRemote.sh
chmod +x create-pwa.sh

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

# Flatpak with Flathub (Linux Mint Prefers this)
# See:  https://docs.flathub.org/docs/for-users/installation
sudo apt install flatpak -y 
sudo flatpak remote-add --if-not-exists flathub \ 
https://flathub.org/repo/flathub.flatpakrepo

# Update the flatpak repository 
flatpak update --appstream

# Flatseal (allows you to change Flatpak permissions)
sudo flatpak install flathub com.github.tchx84.Flatseal -y --noninteractive

# 🎬 ******************* Media 
# Pinta (like Micrsoft Paint)
sudo flatpak install flathub pinta -y --noninteractive

# Flameshot (like PicPick)
sudo flatpak install flathub org.flameshot.Flameshot -y --noninteractive

# Draw.io (like Visio)
sudo flatpak install flathub drawio -y --noninteractive

# Spotify
sudo flatpak install flathub spotify -y --noninteractive

# VLC (like Media Player or Any Video Converter)
sudo flatpak install flathub org.videolan.VLC -y --noninteractive

# Kdenlive (like Adobe Premiere Pro or Filmora)
sudo flatpak install flathub kdenlive -y --noninteractive

# Audacity (audio editor)
sudo flatpak install flathub org.audacityteam.Audacity -y --noninteractive

# Buzz (like Windows Speech to Text)
sudo flatpak install flathub io.github.chidiwilliams.Buzz -y --noninteractive

# OBS Studio (screen recorder like ShareX)
sudo flatpak install flathub com.obsproject.Studio -y --noninteractive

# Webcam testing 
sudo flatpak install flathub cheese -y --noninteractive

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
sudo flatpak install flathub org.mozilla.firefox -y
sudo flatpak install flathub com.brave.Browser -y

# Install Chrome 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
sudo apt install ./google-chrome-stable_current_amd64.deb 

# Set Chrome as default browser 
xdg-settings set default-web-browser google-chrome.desktop 

# 🖇️ ******************* Office 
sudo flatpak install flathub com.todoist.Todoist -y
# sudo flatpak install flathub org.libreoffice.LibreOffice -y --noninteractive
sudo flatpak install flathub org.onlyoffice.desktopeditors -y --noninteractive
sudo flatpak install flathub com.collaboraoffice.Office -y --noninteractive
 
# 🧰 ******************* Install Utilities 


# Firewall GUI (like Windows Defender Firewall)
# This is already on Linux Minut
# sudo apt install gufw -y

# LocalSend (like airdrop, snapdrop or filedrop)
sudo flatpak install flathub org.localsend.localsend_app -y --noninteractive

# Timeshift (like system restore)
# apt install timeshift -y

# Like SysMain (SuperFetch)
# This does not make a noticible impact unless you have a physical hard drive 
# sudo apt install preload -y

# Latest Release of Balena Etcher
"$SCRIPT_DIR/InstallFromRemote.sh" https://github.com/balena-io/etcher/releases .deb

# ISO Image Writer (like Rufus or Balena Etcher)
# sudo flatpak install flathub org.kde.isoimagewriter -y --noninteractive

# BleachBit (like CCleaner)
sudo flatpak install flathub bleachbit -y --noninteractive

# KDE Connect (like Phone Link on Windows)
sudo flatpak install flathub kdeconnect -y --noninteractive

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

# Thunar (like directory opus or total commander using split view) 
# Linux mint already has a split view with Nemo File Manager
#sudo apt install thunar -y 
#sudo apt install thunar-archive-plugin -y
#sudo apt install thunar-data -y
#sudo apt install thunar-volman -y

# View chm files 
sudo apt install xchm -y

# Transfer over FTP and SFTP
sudo flatpak install flathub filezilla -y --noninteractive

# Install Fish Shell and make it the default (you have to logout and log back in to see the changes)
# After run this and change them to Darkula:  fish_config
sudo apt install fish -y 
chsh -s $(which fish) 

# Stacer (Like Task Manager and manage startup programs) 
sudo apt install stacer -y 

# Mission Center (like Task Manager)
sudo flatpak install flathub mission-center

# Beyond Compare 
"$SCRIPT_DIR/InstallFromRemote.sh" https://www.scootersoftware.com/download .deb

# Searchmonkey (like grep but with a GUI)
sudo apt install searchmonkey -y
 

# 🛒 ******************* App Stores 
sudo apt install synaptic -y 

# PWA 
# Regular Expression Tester
"$SCRIPT_DIR/create-pwa.sh" https://regex101.com/ 

# Make Outlook.com look like an app
"$SCRIPT_DIR/create-pwa.sh" https://outlook.live.com/mail/

# Another Nice Online Photo Editor
"$SCRIPT_DIR/create-pwa.sh" https://www.photopea.com/


# 👨‍💻 ******************* Install Developer Tools 

# Data Beaver (Like Database.NET or SQL Server Management Studio)
sudo flatpak install flathub io.dbeaver.DBeaverCommunity -y --noninteractive

# TextPieces (Developer Text formatting)
sudo flatpak install io.gitlab.liferooter.TextPieces -y --noninteractive

# Developer Toolbox (Converters, Decoders, Formatters, Generators, Text, Regex, Markdown)
sudo flatpak install flathub me.iepure.devtoolbox -y --noninteractive

# Install Git 
sudo apt install git -y 

# API Testing
sudo flatpak install flathub postman -y --noninteractive

# Kate (Notepad++ clone) 
sudo flatpak install flathub kate -y --noninteractive 

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


# Install Rider 
sudo flatpak install flathub rider -y --noninteractive 
sudo flatpak override com.jetbrains.Rider --filesystem=host
sudo flatpak override com.jetbrains.Rider --device=all
sudo flatpak override com.jetbrains.Rider --allow=devel
sudo flatpak override com.jetbrains.Rider --socket=system-bus
sudo flatpak override com.jetbrains.Rider --socket=session-bus
sudo flatpak override com.jetbrains.Rider --socket=fallback-x11
sudo flatpak override com.jetbrains.Rider --socket=wayland
sudo flatpak override com.jetbrains.Rider --socket=ssh-auth
sudo flatpak override com.jetbrains.Rider --socket=cups
sudo flatpak override com.jetbrains.Rider --socket=pcsc

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
 
# Git Config 
git config --global user.name "Greg Finzer" 
git config --global user.email "gfinzer@hotmail.com" 

# 📦 ******************** SQL Server Part 1 of 2 
# This SQL Server section is specific to Linux Mint!
# 📁 Create directory
mkdir -p ~/docker/sqlserver

# 📂 Move into directory
cd ~/docker/sqlserver

# 🐳 Create docker-compose.yml
cat <<EOF > docker-compose.yml
services:
  sqlserver:
    image: mcr.microsoft.com/mssql/server:2022-latest
    container_name: sqlserver
    environment:
      ACCEPT_EULA: "Y"
      MSSQL_SA_PASSWORD: "Str0ng!Passw0rd123"
      MSSQL_PID: "Express"   # If this ever fails, use "Developer"
    ports:
      - "1433:1433"
    volumes:
      - sqlserver_data:/var/opt/mssql
    restart: "always"
volumes:
  sqlserver_data:
EOF

echo "docker-compose.yml created in ~/docker/sqlserver"

# 🐳 Install Docker
sudo apt update
sudo apt install ca-certificates curl gnupg -y

sudo install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo $UBUNTU_CODENAME) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io \
  docker-buildx-plugin docker-compose-plugin -y

sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# ✅ Verify installation
docker --version
