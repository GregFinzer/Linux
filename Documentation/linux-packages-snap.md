# 📦 Snap Quick Reference (Linux)

## ⚡ Quick Reference Commands

| Command                                      | Description                   |
| -------------------------------------------- | ----------------------------- |
| 🔍 `snap find <term>`                        | Search Snap packages          |
| 📥 `sudo snap install <pkg>`                 | Install a Snap package        |
| 🔄 `sudo snap refresh`                       | Update all Snap packages      |
| ⬆️ `sudo snap refresh <pkg>`                 | Update a specific package     |
| ❌ `sudo snap remove <pkg>`                   | Remove a Snap package         |
| 📋 `snap list`                               | List installed Snap packages  |
| ℹ️ `snap info <pkg>`                         | Show package details          |
| 🔁 `snap revert <pkg>`                       | Roll back to previous version |
| ⏸️ `sudo snap disable <pkg>`                 | Disable a Snap package        |
| ▶️ `sudo snap enable <pkg>`                  | Enable a Snap package         |
| 🔐 `snap connections <pkg>`                  | View interface permissions    |
| 🔧 `snap connect` / `disconnect`             | Manage permissions manually   |
| 🧹 `sudo snap set system refresh.retain=<N>` | Control retained revisions    |
| ⏰ `snap refresh --time`                      | Show update schedule          |

---

## 💡 Command Examples

### 🔍 Search for Snap packages

```bash
snap find spotify
```

---

### 📥 Install a Snap package

```bash
sudo snap install vlc
```

Install classic confinement app:

```bash
sudo snap install code --classic
```

---

### 🔄 Update all Snap packages

```bash
sudo snap refresh
```

---

### ⬆️ Update one package

```bash
sudo snap refresh vlc
```

---

### ❌ Remove a Snap package

```bash
sudo snap remove vlc
```

---

### 📋 List installed Snaps

```bash
snap list
```

---

### ℹ️ Show package details

```bash
snap info firefox
```

---

### 🔁 Revert to previous version

```bash
sudo snap revert firefox
```

---

### ⏸️ Disable a Snap temporarily

```bash
sudo snap disable firefox
```

Re-enable it:

```bash
sudo snap enable firefox
```

---

### 🔐 View permissions/interfaces

```bash
snap connections firefox
```

---

### 🔧 Manually connect permissions

Example (camera access):

```bash
sudo snap connect chromium:camera
```

Disconnect:

```bash
sudo snap disconnect chromium:camera
```

---

### 🧹 Limit stored old versions

Keep only two revisions:

```bash
sudo snap set system refresh.retain=2
```

---

### ⏰ Check auto-update schedule

```bash
snap refresh --time
```

---


