# Clam Antivirus
Generated from ChatGPT

On **Linux Mint**, the antivirus package is **ClamAV**, and the common GUI frontend is **ClamTk**.
ClamAV provides the scanning engine, while ClamTk provides the graphical interface.

Below is the **recommended installation process for Linux Mint (Cinnamon, MATE, XFCE)**.

---

# Install ClamAV + GUI (ClamTk) on Linux Mint

## 1. Update package lists

```bash
sudo apt update
```

---

## 2. Install ClamAV and related tools

```bash
sudo apt install clamav clamav-daemon
```

**Packages installed**

| Package       | Purpose                     |
| ------------- | --------------------------- |
| clamav        | virus scanning engine       |
| clamav-daemon | background scanning service |
| freshclam     | updates virus definitions   |

---

## 3. Install the GUI (ClamTk)

```bash
sudo apt install clamtk
```

This installs the graphical frontend used to:

* Scan files or folders
* Update signatures
* Configure scanning rules
* Schedule scans
* Manage quarantine

---

# Update the Virus Definitions

After installing, update the database.

```bash
sudo systemctl stop clamav-freshclam
sudo freshclam
sudo systemctl start clamav-freshclam
```

You should see something like:

```
ClamAV update process started
Database updated
```

---

# Launch the GUI

Open the GUI from the menu:

```
Menu → Administration → ClamTk
```

or run:

```bash
clamtk
```

---

# Run a Scan

Inside **ClamTk** you can:

* Scan a **file**
* Scan a **directory**
* Scan your **home folder**
* Scan **recursively**

Example command line scan:

```bash
clamscan -r /home
```

or remove infected files automatically:

```bash
clamscan -r --remove /home
```

---

# Enable Automatic Signature Updates

Check the service:

```bash
systemctl status clamav-freshclam
```

Enable if needed:

```bash
sudo systemctl enable clamav-freshclam
sudo systemctl start clamav-freshclam
```

This keeps virus definitions updated automatically.

---

# Optional: Install Additional ClamAV Tools

```bash
sudo apt install clamav-docs
```

---

# Verify Installation

```bash
clamscan --version
```

Example output:

```
ClamAV 1.x.x
```

---

# Useful ClamAV Commands

| Command                   | Purpose                    |
| ------------------------- | -------------------------- |
| `clamscan -r /path`       | scan directory recursively |
| `clamscan -r --bell -i /` | show only infected files   |
| `freshclam`               | update virus database      |
| `clamscan --help`         | show options               |

---

# Recommended ClamTk Settings

Inside **ClamTk → Settings**

Enable:

✔ Scan recursively
✔ Scan hidden files
✔ Scan for PUA (Potentially Unwanted Apps)
✔ Scan archives

---

💡 **Tip:**
ClamAV is mainly useful on Linux for:

* Scanning **Windows malware in downloads**
* Scanning **email attachments**
* Protecting **shared drives or Samba servers**

Linux malware is rare, but scanning downloads is still helpful.


