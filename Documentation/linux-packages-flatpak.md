# 📦 Flatpak Quick Reference (Linux)

## ⚡ Quick Reference Commands

| Command                                 | Description                      |
| --------------------------------------- | -------------------------------- |
| 🔍 `flatpak search <term>`              | Search Flatpak apps              |
| 📥 `flatpak install <repo> <app>`       | Install an app                   |
| ⬆️ `flatpak update`                     | Update all Flatpak apps          |
| 🔄 `flatpak update <app>`               | Update a specific app            |
| ❌ `flatpak uninstall <app>`             | Remove an app                    |
| 📋 `flatpak list`                       | List installed Flatpaks          |
| ℹ️ `flatpak info <app>`                 | Show app details                 |
| 🧹 `flatpak uninstall --unused`         | Remove unused runtimes           |
| ➕ `flatpak remote-add`                  | Add a repository (e.g., Flathub) |
| 📚 `flatpak remotes`                    | List configured repositories     |
| 📦 `flatpak run <app>`                  | Run an application               |
| 🔐 `flatpak override`                   | Modify app permissions           |
| 📂 `flatpak info --show-location <app>` | Show install location            |

---

## 💡 Command Examples

### ➕ Add Flathub repository (most common)

```bash
flatpak remote-add --if-not-exists flathub \
https://flathub.org/repo/flathub.flatpakrepo
```

---

### 🔍 Search for apps

```bash
flatpak search spotify
```

---

### 📥 Install an app

Example installing VLC from Flathub:

```bash
flatpak install flathub org.videolan.VLC
```

---

### ⬆️ Update all apps

```bash
flatpak update
```

---

### 🔄 Update one app

```bash
flatpak update org.videolan.VLC
```

---

### ❌ Remove an app

```bash
flatpak uninstall org.videolan.VLC
```

---

### 📋 List installed Flatpaks

```bash
flatpak list
```

---

### ℹ️ Show app details

```bash
flatpak info org.mozilla.firefox
```

---

### 🧹 Remove unused runtimes

(This frees disk space.)

```bash
flatpak uninstall --unused
```

---

### 📦 Run an app manually

```bash
flatpak run org.mozilla.firefox
```

---

### 🔐 Modify permissions

Example allow home folder access:

```bash
flatpak override --filesystem=home org.mozilla.firefox
```

---

### 📂 Show installation location

```bash
flatpak info --show-location org.mozilla.firefox
```

Typical locations:

* User install: `~/.local/share/flatpak/`
* System install: `/var/lib/flatpak/`

---


