#!/bin/bash

# This only works with Ubuntu (Not Linux Mint, See SetupMintPart1.sh and SetupMintPart2.sh)

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