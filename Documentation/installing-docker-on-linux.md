# 🐳 Installing Docker on Linux

## 📦 Installing Docker with APT

### Step 1: Update Package Index
First, update your existing package list:

```bash
sudo apt update
```

### Step 2: Install Prerequisites
Install packages to allow apt to use a repository over HTTPS:

```bash
sudo apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

### Step 3: Add Docker's Official GPG Key

```bash
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
```

### Step 4: Set Up the Repository

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

### Step 5: Install Docker Engine

```bash
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

### Step 6: Verify Installation

```bash
sudo docker run hello-world
```

### Step 7: Add Your User to Docker Group (Optional)
To run Docker without sudo:

```bash
sudo usermod -aG docker $USER
```

**Note:** Log out and back in for this to take effect.

---

## 🚀 Quick Reference - Docker Commands

| Command | Definition |
|---------|------------|
| `docker version` | Display Docker version information |
| `docker info` | Display system-wide information |
| `docker pull` | Download an image from a registry |
| `docker images` | List all locally stored images |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers (including stopped) |
| `docker run` | Create and start a container |
| `docker start` | Start one or more stopped containers |
| `docker stop` | Stop one or more running containers |
| `docker restart` | Restart one or more containers |
| `docker rm` | Remove one or more containers |
| `docker rmi` | Remove one or more images |
| `docker exec` | Execute a command in a running container |
| `docker logs` | Fetch the logs of a container |
| `docker build` | Build an image from a Dockerfile |
| `docker push` | Upload an image to a registry |
| `docker network` | Manage Docker networks |
| `docker volume` | Manage Docker volumes |
| `docker compose` | Define and run multi-container applications |
| `docker inspect` | Display detailed information about a container/image |
| `docker stats` | Display live resource usage statistics |
| `docker system prune` | Remove unused data (containers, networks, images) |

---

## 📚 Detailed Command Examples

### 🔍 `docker version`
Display the Docker version information for both client and server.

```bash
docker version
```

**Output includes:**
- Client version
- Server version
- API version
- Go version

---

### 📊 `docker info`
Get comprehensive system-wide information about Docker.

```bash
docker info
```

**Shows:**
- Number of containers and images
- Storage driver
- Docker root directory
- Registry information

---

### ⬇️ `docker pull`
Download a Docker image from Docker Hub or another registry.

```bash
# Pull the latest version of an image
docker pull ubuntu

# Pull a specific version
docker pull ubuntu:22.04

# Pull from a specific registry
docker pull nginx:alpine
```

---

### 🖼️ `docker images`
List all Docker images stored locally on your system.

```bash
# List all images
docker images

# List images with specific filter
docker images ubuntu

# Show all images including intermediate ones
docker images -a

# Show only image IDs
docker images -q
```

---

### 📋 `docker ps`
List containers currently running on your system.

```bash
# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Show only container IDs
docker ps -q

# Show last created container
docker ps -l

# Filter by status
docker ps -f "status=exited"
```

---

### 🚀 `docker run`
Create and start a new container from an image.

```bash
# Run a simple container
docker run ubuntu echo "Hello World"

# Run container in detached mode
docker run -d nginx

# Run with a custom name
docker run --name my-nginx nginx

# Run with port mapping
docker run -d -p 8080:80 nginx

# Run with environment variables
docker run -e MYSQL_ROOT_PASSWORD=secret mysql

# Run with volume mount
docker run -v /host/path:/container/path ubuntu

# Run interactively with terminal
docker run -it ubuntu bash

# Run with automatic removal after exit
docker run --rm ubuntu echo "Temporary container"

# Run with resource limits
docker run -m 512m --cpus 1 nginx
```

---

### ▶️ `docker start`
Start one or more stopped containers.

```bash
# Start a container by name
docker start my-nginx

# Start a container by ID
docker start abc123def456

# Start multiple containers
docker start container1 container2 container3

# Start and attach to container
docker start -a my-nginx

# Start and attach with interactive mode
docker start -ai my-ubuntu
```

---

### ⏹️ `docker stop`
Gracefully stop one or more running containers.

```bash
# Stop a container by name
docker stop my-nginx

# Stop a container by ID
docker stop abc123def456

# Stop multiple containers
docker stop container1 container2

# Stop all running containers
docker stop $(docker ps -q)

# Stop with timeout (default is 10 seconds)
docker stop -t 30 my-nginx
```

---

### 🔄 `docker restart`
Restart one or more containers.

```bash
# Restart a specific container
docker restart my-nginx

# Restart multiple containers
docker restart container1 container2

# Restart with custom timeout
docker restart -t 30 my-nginx
```

---

### 🗑️ `docker rm`
Remove one or more containers (must be stopped first).

```bash
# Remove a stopped container
docker rm my-nginx

# Force remove a running container
docker rm -f my-nginx

# Remove multiple containers
docker rm container1 container2

# Remove all stopped containers
docker rm $(docker ps -aq -f status=exited)

# Remove container and its volumes
docker rm -v my-container
```

---

### 🗑️ `docker rmi`
Remove one or more Docker images.

```bash
# Remove an image by name
docker rmi ubuntu

# Remove an image by ID
docker rmi abc123def456

# Force remove an image
docker rmi -f ubuntu

# Remove multiple images
docker rmi ubuntu nginx mysql

# Remove all unused images
docker rmi $(docker images -q -f dangling=true)

# Remove all images
docker rmi $(docker images -q)
```

---

### 💻 `docker exec`
Execute a command inside a running container.

```bash
# Run a command in a running container
docker exec my-nginx ls /usr/share/nginx/html

# Open an interactive bash shell
docker exec -it my-nginx bash

# Run command as specific user
docker exec -u root my-nginx apt update

# Run command with environment variables
docker exec -e VAR=value my-container env

# Run command in specific working directory
docker exec -w /app my-container pwd
```

---

### 📜 `docker logs`
Fetch and display the logs of a container.

```bash
# View logs of a container
docker logs my-nginx

# Follow log output (like tail -f)
docker logs -f my-nginx

# Show timestamps
docker logs -t my-nginx

# Show last N lines
docker logs --tail 100 my-nginx

# Show logs since specific time
docker logs --since 2024-01-01 my-nginx

# Show logs from last 10 minutes
docker logs --since 10m my-nginx
```

---

### 🏗️ `docker build`
Build a Docker image from a Dockerfile.

```bash
# Build from Dockerfile in current directory
docker build -t my-app:1.0 .

# Build with specific Dockerfile
docker build -f Dockerfile.prod -t my-app:prod .

# Build without using cache
docker build --no-cache -t my-app .

# Build with build arguments
docker build --build-arg VERSION=1.0 -t my-app .

# Build and tag multiple times
docker build -t my-app:latest -t my-app:1.0 .

# Build with specific target stage
docker build --target production -t my-app:prod .
```

---

### ⬆️ `docker push`
Upload a Docker image to a registry.

```bash
# Push to Docker Hub
docker push username/my-app:latest

# Push with specific tag
docker push username/my-app:1.0

# Push to private registry
docker push registry.company.com/my-app:latest
```

---

### 🌐 `docker network`
Manage Docker networks for container communication.

```bash
# List all networks
docker network ls

# Create a new network
docker network create my-network

# Create network with specific driver
docker network create --driver bridge my-bridge

# Inspect network details
docker network inspect my-network

# Connect container to network
docker network connect my-network my-container

# Disconnect container from network
docker network disconnect my-network my-container

# Remove a network
docker network rm my-network

# Remove all unused networks
docker network prune
```

---

### 💾 `docker volume`
Manage Docker volumes for persistent data storage.

```bash
# List all volumes
docker volume ls

# Create a new volume
docker volume create my-volume

# Inspect volume details
docker volume inspect my-volume

# Remove a volume
docker volume rm my-volume

# Remove all unused volumes
docker volume prune

# Use volume with container
docker run -v my-volume:/data ubuntu
```

---

### 🎼 `docker compose`
Define and manage multi-container applications.

```bash
# Start services defined in docker-compose.yml
docker compose up

# Start in detached mode
docker compose up -d

# Stop services
docker compose down

# Stop and remove volumes
docker compose down -v

# View logs
docker compose logs

# Follow logs
docker compose logs -f

# List running services
docker compose ps

# Execute command in service
docker compose exec web bash

# Build or rebuild services
docker compose build

# Pull latest images
docker compose pull

# Restart services
docker compose restart
```

---

### 🔍 `docker inspect`
Display detailed low-level information about Docker objects.

```bash
# Inspect a container
docker inspect my-container

# Inspect an image
docker inspect ubuntu:latest

# Get specific information using format
docker inspect --format='{{.NetworkSettings.IPAddress}}' my-container

# Inspect multiple objects
docker inspect container1 container2

# Get container state
docker inspect --format='{{.State.Status}}' my-container

# Get mounted volumes
docker inspect --format='{{.Mounts}}' my-container
```

---

### 📈 `docker stats`
Display live resource usage statistics for containers.

```bash
# Show stats for all running containers
docker stats

# Show stats for specific containers
docker stats my-container1 my-container2

# Show stats without streaming (one snapshot)
docker stats --no-stream

# Format output
docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"
```

---

### 🧹 `docker system prune`
Clean up unused Docker resources to free disk space.

```bash
# Remove all stopped containers, unused networks, dangling images
docker system prune

# Include unused images (not just dangling)
docker system prune -a

# Force without confirmation prompt
docker system prune -f

# Include volumes in cleanup
docker system prune --volumes

# Check disk usage
docker system df

# Detailed disk usage
docker system df -v
```

---

## 🎯 Additional Useful Commands

### Check Docker Service Status

```bash
# Check if Docker daemon is running
sudo systemctl status docker

# Start Docker service
sudo systemctl start docker

# Enable Docker to start on boot
sudo systemctl enable docker

# Restart Docker service
sudo systemctl restart docker
```

### Docker Container Resource Management

```bash
# Limit memory and CPU
docker run -m 512m --cpus="1.5" nginx

# Set memory reservation
docker run --memory-reservation="256m" nginx

# Pause a container
docker pause my-container

# Unpause a container
docker unpause my-container

# Update container resources
docker update --memory 512m my-container
```

### Docker Image Management

```bash
# Tag an image
docker tag my-app:latest my-app:v1.0

# Save image to tar archive
docker save -o my-app.tar my-app:latest

# Load image from tar archive
docker load -i my-app.tar

# Export container filesystem
docker export my-container > container.tar

# Import container filesystem as image
docker import container.tar my-new-image:latest

# Show image history
docker history ubuntu
```

---

## 🎓 Best Practices

1. **Always use specific image tags** instead of `latest` in production
2. **Clean up regularly** using `docker system prune` to save disk space
3. **Use .dockerignore** to exclude unnecessary files from builds
4. **Minimize layers** in Dockerfile by combining commands
5. **Don't run containers as root** when possible
6. **Use volumes** for persistent data
7. **Name your containers** for easier management
8. **Monitor resource usage** with `docker stats`
9. **Review logs regularly** to catch issues early
10. **Keep Docker updated** for security and features

---

## 🔗 Useful Resources

- [Official Docker Documentation](https://docs.docker.com/)
- [Docker Hub](https://hub.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Dockerfile Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

---

**Happy Dockering! 🐳✨**

