#!/usr/bin/env bash 

# Set Variables 
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)" 

# Super User 
sudo su 

# 📁 Go to Downloads as we will be downloading stuff 
cd ~/Downloads 

# 📋 Prerequisites 
sudo apt update 
sudo apt install curl wget gpg apt-transport-https -y 

# 🎬 ******************* Media 
# Like paint
snap install pinta 
snap install drawio 
snap install spotify 
snap install vlc 
# Kdenlive (like Adobe Premiere Pro)
sudo snap install kdenlive
sudo snap install audacity

# Speech to Text
sudo snap install buzz

# Required for Buzz
sudo apt install -y libportaudio2 portaudio19-dev 

snap install obs-studio 

# Webcam testing 
snap install cheese 

# snap install plexmediaserver 
 

# ▶️ 💬 ******************* Video Conferencing and Messaging 
snap install teams-for-linux 
snap install slack 
snap install zoom-client 
 

# 🌐 ******************* Web 
snap install firefox 
snap install brave 

# Install Chrome 
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
sudo apt install ./google-chrome-stable_current_amd64.deb 

# Set Chrome as default browser 
xdg-settings set default-web-browser google-chrome.desktop 

# 🖇️ ******************* Office 
snap install todoist 
sudo apt install libreoffice -y 
sudo snap install onlyoffice-desktopeditors 
 
# 🧰 ******************* Install Utilities 

# Firewall GUI (like Windows Defender Firewall)
sudo apt install gufw -y

# LocalSend (like airdrop, snapdrop or filedrop)
snap install localsend

# Timeshift (like system restore)
sudo apt install timeshift -y

# Like SysMain (SuperFetch) 
sudo apt install preload -y

# ISO Image Writer (like Rufus or Balena Etcher)
sudo apt install isoimagewriter -y

# BleachBit (like CCleaner)
sudo apt install bleachbit -y

# Like Phone Link on Windows
sudo apt install kdeconnect -y

# Syncthing (like dropbox or onedrive but open source and self hosted)
sudo apt install syncthing -y 

# Auto-start Syncthing 
systemctl --user enable syncthing 
systemctl --user start syncthing 

# Thunar (like directory opus or total commander using split view) 
sudo apt install thunar -y 
sudo apt install thunar-archive-plugin -y
sudo apt install thunar-data -y
sudo apt install thunar-volman -y

# View chm files 
sudo apt install xchm -y 

sudo apt install filezilla -y 

# Install Fish Shell and make it the default 
sudo apt install fish -y 
chsh -s $(which fish) 

# Stacer (Like Task Manager and manage startup programs) 
sudo apt install stacer -y 

# Mission Center (like Task Manager)
sudo snap install mission-center

# Beyond Compare 
wget https://www.scootersoftware.com/files/bcompare-5.1.7.31736_amd64.deb 
sudo apt update 
sudo apt install ./bcompare-5.1.7.31736_amd64.deb 

# Searchmonkey (like grep but with a GUI)
sudo apt install searchmonkey -y
 

# 🛒 ******************* App Stores 
sudo apt install synaptic -y 

# Flatpak with Flathub 
sudo apt install flatpak -y 
sudo flatpak remote-add --if-not-exists flathub \ 
https://flathub.org/repo/flathub.flatpakrepo 

# 👨‍💻 ******************* Install Developer Tools 

# Install Git 
sudo apt install git -y 

snap install postman 

# Kate (Notepad++ clone) 
snap install kate 

# Install VS Code from Microsoft Official 

# 1️⃣ Install prerequisites 
sudo apt install wget gpg apt-transport-https -y 

# 2️⃣ Add Microsoft signing key 
wget -qO- https://packages.microsoft.com/keys/microsoft.asc \ 
| gpg --dearmor > packages.microsoft.gpg 

sudo install -D -o root -g root -m 644 packages.microsoft.gpg \ 
/etc/apt/keyrings/packages.microsoft.gpg 

# 3️⃣ Add VS Code repository 
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] \ 
https://packages.microsoft.com/repos/code stable main" \ 
| sudo tee /etc/apt/sources.list.d/vscode.list 

# 4️⃣ Install VS Code 
sudo apt update 
sudo apt install code -y 

# Install Rider 
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
 
# Git Config 
git config --global user.name "Greg Finzer" 
git config --global user.email "gfinzer@hotmail.com" 

# PWA 
"$SCRIPT_DIR/create-pwa.sh" https://regex101.com/ 

# 📦 ******************** SQL Server Part 1 of 2 
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
    restart: "yes"
volumes:
  sqlserver_data:
EOF

echo "docker-compose.yml created in ~/docker/sqlserver"

# 🐳 Install Docker
sudo apt update
sudo apt install docker.io docker-compose -y
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

# ✅ Verify installation
docker --version