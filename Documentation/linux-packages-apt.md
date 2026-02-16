# 🐧 APT Quick Reference (Linux)

## ⚡ Quick Reference Commands

| Command                     | Description                                     |
| --------------------------- | ----------------------------------------------- |
| 🔄 `sudo apt update`        | Refresh package list from repositories          |
| ⬆️ `sudo apt upgrade`       | Upgrade installed packages                      |
| 🚀 `sudo apt full-upgrade`  | Upgrade packages + handle dependencies/removals |
| 📦 `sudo apt install <pkg>` | Install a package                               |
| ❌ `sudo apt remove <pkg>`   | Remove a package (keep config files)            |
| 🧹 `sudo apt purge <pkg>`   | Remove package + config files                   |
| 🔍 `apt search <term>`      | Search for packages                             |
| ℹ️ `apt show <pkg>`         | Show package details                            |
| 📋 `apt list --installed`   | List installed packages                         |
| 🧼 `sudo apt autoremove`    | Remove unused dependencies                      |
| 🧽 `sudo apt clean`         | Remove downloaded package cache                 |
| 📥 `apt download <pkg>`     | Download package without installing             |
| 🔎 `apt policy <pkg>`       | Show installed & available versions             |
| 🧪 `apt depends <pkg>`      | Show dependencies                               |
| 🔗 `apt rdepends <pkg>`     | Show reverse dependencies                       |

---

## 💡 Command Examples

### 🔄 Update package lists

```bash
sudo apt update
```

---

### ⬆️ Upgrade installed packages

```bash
sudo apt upgrade
```

---

### 🚀 Full upgrade (handles dependency changes)

```bash
sudo apt full-upgrade
```

---

### 📦 Install a package

```bash
sudo apt install git
```

Install multiple packages:

```bash
sudo apt install git curl vim
```

---

### ❌ Remove a package (keep configs)

```bash
sudo apt remove git
```

---

### 🧹 Remove package including configs

```bash
sudo apt purge git
```

---

### 🔍 Search for a package

```bash
apt search docker
```

---

### ℹ️ Show package details

```bash
apt show docker.io
```

---

### 📋 List installed packages

```bash
apt list --installed
```

Filter results:

```bash
apt list --installed | grep docker
```

---

### 🧼 Remove unused dependencies

```bash
sudo apt autoremove
```

---

### 🧽 Clean package cache

```bash
sudo apt clean
```

---

### 📥 Download a package only

```bash
apt download nginx
```

---

### 🔎 Check installed vs available versions

```bash
apt policy nginx
```

---

### 🧪 Show dependencies

```bash
apt depends nginx
```

---

### 🔗 Show reverse dependencies

```bash
apt rdepends nginx
```

---


