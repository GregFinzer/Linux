#!/bin/bash

# 📂 Move into directory
cd ~/docker/sqlserver

# 🚀 Start SQL Server container
docker compose up -d

# 📜 View logs
docker compose logs -f