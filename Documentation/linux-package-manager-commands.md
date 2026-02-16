# 📦 Linux Package Manager Commands

| Task                      | 🐧 APT (.deb)                         | 📦 Snap                        | 📦 Flatpak                   | 📦 RPM                         | 🐧 Pacman (Arch)                   |
| ------------------------- | ------------------------------------- | ------------------------------ | ---------------------------- | ------------------------------ | ---------------------------------- |
| 🔄 Refresh package list   | `sudo apt update`                     | *(Auto)* `snap refresh --list` | `flatpak update --appstream` | *(Usually `dnf check-update`)* | `sudo pacman -Sy` *(rarely alone)* |
| 🚀 Refresh + full upgrade | `sudo apt update && sudo apt upgrade` | `sudo snap refresh`            | `flatpak update`             | *(Typically `dnf upgrade`)*    | `sudo pacman -Syu` ⭐               |
| 📥 Install package        | `sudo apt install pkg`                | `sudo snap install pkg`        | `flatpak install repo app`   | `sudo rpm -i file.rpm`         | `sudo pacman -S pkg`               |
| ⬆️ Upgrade package        | `sudo apt upgrade pkg`                | `sudo snap refresh pkg`        | `flatpak update app`         | `sudo rpm -U file.rpm`         | `sudo pacman -S pkg`               |
| ❌ Remove package          | `sudo apt remove pkg`                 | `sudo snap remove pkg`         | `flatpak uninstall app`      | `sudo rpm -e pkg`              | `sudo pacman -R pkg`               |
| 🧹 Remove configs + deps  | `sudo apt purge pkg` + `autoremove`   | N/A                            | `flatpak uninstall --unused` | N/A                            | `sudo pacman -Rns pkg`             |
| 🔍 Search packages        | `apt search term`                     | `snap find term`               | `flatpak search term`        | *(Repo tool required)*         | `pacman -Ss term`                  |
| ℹ️ Package info           | `apt show pkg`                        | `snap info pkg`                | `flatpak info app`           | `rpm -qi pkg`                  | `pacman -Si pkg`                   |
| 📋 List installed         | `apt list --installed`                | `snap list`                    | `flatpak list`               | `rpm -qa`                      | `pacman -Q`                        |
| 📦 List package files     | `dpkg -L pkg`                         | N/A                            | N/A                          | `rpm -ql pkg`                  | `pacman -Ql pkg`                   |
| 🔎 Check installed        | `dpkg -l pkg`                         | `snap list pkg`                | `flatpak info app`           | `rpm -q pkg`                   | `pacman -Qi pkg`                   |
| 🧼 Cleanup unused deps    | `sudo apt autoremove`                 | Auto-managed                   | `flatpak uninstall --unused` | N/A                            | `sudo pacman -Rns $(pacman -Qtdq)` |
| 🧽 Clear cache            | `sudo apt clean`                      | Auto-managed                   | N/A                          | N/A                            | `sudo pacman -Sc`                  |

---

## ⭐ Important Pacman Notes (Worth Knowing)

### ⚠️ Never run only:

```bash
sudo pacman -Sy
```

👉 This can cause **partial upgrade breakage**.
Recommended instead:

```bash
sudo pacman -Syu
```

This is a big Arch best practice.

---

### 🧠 Ecosystem Differences Recap

| Manager | Typical Use                        |
| ------- | ---------------------------------- |
| APT     | Debian/Ubuntu system packages      |
| Snap    | Universal apps with auto updates   |
| Flatpak | Desktop GUI apps (sandboxed)       |
| RPM     | Base package format (Fedora/RHEL)  |
| Pacman  | Arch Linux rolling-release manager |

---


