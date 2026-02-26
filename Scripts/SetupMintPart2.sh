#!/usr/bin/env bash 

# 🛒 Install Bazaar store 
flatpak install flathub io.github.kolunmi.Bazaar -y 

# Manage Flatpak permissions
flatpak install Flatseal -y

# 📦 Install SQL Server Part 2 of 2 
# 📂 Move into directory 
cd ~/docker/sqlserver 

# 🚀 Start SQL Server container 
docker compose up -d 
