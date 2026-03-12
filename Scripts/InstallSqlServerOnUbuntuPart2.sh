#!/bin/bash

# This only works with Ubuntu (Not Linux Mint, See SetupMintPart1.sh and SetupMintPart2.sh)

# 📂 Move into directory
cd ~/docker/sqlserver

# 🚀 Start SQL Server container
docker compose up -d

# 📜 View logs
docker compose logs -f