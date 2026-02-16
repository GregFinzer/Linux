# 📦 RPM Quick Reference (Linux)

## ⚡ Quick Reference Commands

| Command                        | Description                        |
| ------------------------------ | ---------------------------------- |
| 📥 `sudo rpm -i <file.rpm>`    | Install an RPM package             |
| 🔄 `sudo rpm -U <file.rpm>`    | Upgrade or install package         |
| ♻️ `sudo rpm -F <file.rpm>`    | Upgrade only if installed          |
| ❌ `sudo rpm -e <pkg>`          | Remove a package                   |
| 🔍 `rpm -qa`                   | List all installed packages        |
| 🔎 `rpm -q <pkg>`              | Check if package installed         |
| ℹ️ `rpm -qi <pkg>`             | Show package info                  |
| 📂 `rpm -ql <pkg>`             | List installed files               |
| 📦 `rpm -qf <file>`            | Find owning package of file        |
| 🧪 `rpm -Vp <file.rpm>`        | Verify package integrity           |
| 🏷️ `rpm -qp <file.rpm>`       | Query package file (not installed) |
| 🔐 `rpm --checksig <file.rpm>` | Verify package signature           |

---

## 💡 Command Examples

### 📥 Install an RPM package

```bash
sudo rpm -i example.rpm
```

---

### 🔄 Upgrade or install package

(Commonly used instead of install.)

```bash
sudo rpm -U example.rpm
```

---

### ♻️ Upgrade only if already installed

```bash
sudo rpm -F example.rpm
```

---

### ❌ Remove a package

```bash
sudo rpm -e firefox
```

---

### 🔍 List installed packages

```bash
rpm -qa
```

Filter results:

```bash
rpm -qa | grep firefox
```

---

### 🔎 Check if package installed

```bash
rpm -q firefox
```

---

### ℹ️ Show package information

```bash
rpm -qi firefox
```

---

### 📂 List files installed by package

```bash
rpm -ql firefox
```

---

### 📦 Find which package owns a file

```bash
rpm -qf /usr/bin/firefox
```

---

### 🧪 Verify installed package integrity

```bash
rpm -V firefox
```

---

### 🏷️ Query package file without installing

```bash
rpm -qp example.rpm
```

Detailed info:

```bash
rpm -qpi example.rpm
```

---

### 🔐 Verify package signature

```bash
rpm --checksig example.rpm
```

---

## 💡 Notes

* RPM is used mainly by:

  * Fedora
  * Red Hat Enterprise Linux (RHEL)
  * CentOS / Rocky Linux / AlmaLinux
  * openSUSE (uses RPM format with `zypper`)
* Higher-level tools like **`dnf`**, **`yum`**, or **`zypper`** handle dependencies automatically.

---

