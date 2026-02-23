# Installing VSCode on Linux
This is the official repository that will allow updates

```bash
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
```