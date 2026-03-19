#!/usr/bin/env bash
set -euo pipefail

DOCKER_DIR="$HOME/docker/sqlserver"
COMPOSE_FILE="$DOCKER_DIR/docker-compose.yml"
CURRENT_USER="${SUDO_USER:-$USER}"

echo "Creating directory structure..."
mkdir -p "$DOCKER_DIR"

echo "Creating docker-compose.yml..."
cat > "$COMPOSE_FILE" <<'EOF'
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

echo "Removing any conflicting Docker packages..."
sudo apt-get remove -y docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc || true

echo "Installing prerequisites..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg

echo "Setting up Docker official apt repository..."
sudo install -m 0755 -d /etc/apt/keyrings
if [ ! -f /etc/apt/keyrings/docker.asc ]; then
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  sudo chmod a+r /etc/apt/keyrings/docker.gpg
fi

ARCH="$(dpkg --print-architecture)"
CODENAME="$(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")"

echo \
  "deb [arch=${ARCH} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu ${CODENAME} stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Installing Docker Engine and Docker Compose plugin..."
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Enabling Docker to start on boot..."
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo systemctl start docker

echo "Adding user '$CURRENT_USER' to docker group..."
sudo usermod -aG docker "$CURRENT_USER"

echo "Starting SQL Server container..."
cd "$DOCKER_DIR"
sudo docker compose up -d

echo
echo "Done."
echo "docker-compose.yml created at: $COMPOSE_FILE"
echo
echo "Important:"
echo "1. You should log out and back in before running docker without sudo."
echo "2. SQL Server is mapped to port 1433."
echo "3. Data is persisted in the Docker volume: sqlserver_data"
