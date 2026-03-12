# 🐧 SQL Server on Linux with Docker — Easy Setup Guide

I have created two easy-to-use scripts to install Docker and get SQL Server running.
It only works on Ubuntu (Not Linux Mint) 🚀

---

## 📦 InstallSqlServerPart1.sh

```bash
#!/bin/bash

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
    restart: "no"
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
```

---

## ▶️ InstallSqlServerPart2.sh

```bash
#!/bin/bash

cd ~/docker/sqlserver

# 🚀 Start SQL Server container
docker compose up -d

# 📜 View logs
docker compose logs -f
```

---

## 🔐 Make Scripts Executable

```bash
chmod +x InstallSqlServerPart1.sh
chmod +x InstallSqlServerPart2.sh
```

---

## ▶️ Run the Setup

### 1️⃣ Run Part 1

```bash
./InstallSqlServerPart1.sh
```

👉 Then:

* 🚪 Logout
* 🔑 Log back in (required for Docker group membership)

---

### 2️⃣ Run Part 2

```bash
./InstallSqlServerPart2.sh
```

---

## 🔌 Connection String

```text
Server=localhost,1433;
Database=bedbrigade;
User Id=sa;
Password=Str0ng!Passw0rd123;
Encrypt=True;
TrustServerCertificate=True;
```

---

## 🐳 Docker Compose Cheat Sheet

```bash
docker compose logs -f    # 📜 Watch logs live
docker compose ps         # 📊 Check container status
docker compose stop       # ⛔ Stop container
docker compose start      # ▶️ Start again
docker compose up -d      # 🚀 Create + start container
docker compose down       # 🧹 Remove container (keep data)
docker compose down -v    # 💥 Remove container + delete data
```

---

✅ That’s it — SQL Server should now be running in Docker on Linux.
