## 🐧 Arch Linux Package Format & Manager

### 📦 Package Format

**`.pkg.tar.zst`**

* Compressed tar archive (`tar`)
* Uses **Zstandard compression (`zst`)**
* Contains:

  * Program files
  * Metadata
  * Install scripts
* Similar conceptually to:

  * `.deb` (Debian/Ubuntu)
  * `.rpm` (Fedora/RHEL)

👉 Example file:

```bash
firefox-122.0-1-x86_64.pkg.tar.zst
```

---

### ⚙️ Package Manager

**`pacman`** (Package Manager)

This is Arch’s official tool:

* Installs packages
* Resolves dependencies
* Updates system
* Manages repositories

---

## ⚡ Common `pacman` Commands

| Task                            | Command                |
| ------------------------------- | ---------------------- |
| 🔄 Update package database      | `sudo pacman -Sy`      |
| ⬆️ Full system update           | `sudo pacman -Syu`     |
| 📥 Install package              | `sudo pacman -S pkg`   |
| ❌ Remove package                | `sudo pacman -R pkg`   |
| 🧹 Remove package + unused deps | `sudo pacman -Rns pkg` |
| 🔍 Search packages              | `pacman -Ss term`      |
| 📋 List installed packages      | `pacman -Q`            |
| ℹ️ Package info                 | `pacman -Si pkg`       |
| 📦 List files in package        | `pacman -Ql pkg`       |
| 🧽 Clean package cache          | `sudo pacman -Sc`      |

---

## 🌍 Arch Ecosystem Extras (Very Important)

### ⭐ AUR (Arch User Repository)

Not an official repo, but hugely popular:

* Community-maintained packages
* Build scripts (`PKGBUILD`)
* Tools like:

  * `yay`
  * `paru`
  * `trizen`

Example:

```bash
yay -S google-chrome
```

👉 This is a major reason developers like Arch.

---

## 🧠 How Arch Differs from Ubuntu/Fedora

| Feature           | Arch            |
| ----------------- | --------------- |
| Release model     | Rolling release |
| Package freshness | Very latest     |
| Package manager   | `pacman`        |
| Format            | `.pkg.tar.zst`  |
| Community repo    | AUR             |
| Philosophy        | Minimal, DIY    |

---

## 👍 Quick Summary

**Arch Linux uses:**

* 📦 Package format: `.pkg.tar.zst`
* ⚙️ Package manager: `pacman`
* 🌐 Extra repo ecosystem: AUR

---

