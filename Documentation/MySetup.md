# My Development Environment Setup on KUbuntu

## Prep and Script Install

1. In the BIOS, disable secure boot, disable fast boot, and enable hardware virtualization
2. Open Timeshift and create the initial backup. Configure daily backups. Keep 5.
3. Configure power settings never to sleep. Configure critical battery to shut down. Sleep does not work on Linux.</li>
4. Open a terminal and enter:
   ```bash
   sudo apt update && sudo apt upgrade
   reboot
   ```
5. After the reboot open a terminal and enter:
   ```bash
   mkdir _git
   cd _git
   git clone https://github.com/GregFinzer/Linux.git
   cd Linux/Scripts
   chmod +x SetupKUbuntu.sh
   ./SetupKUbuntu.sh
   ```
6. Reboot

## Important Manual Steps

<ol>
    <li>Install OpenDeck for the desktop computer</li>
    <li>Add SyncThing, Teams, and OpenDeck to run on Startup</li>
    <li>Make Brave the Default Browser in System Settings</li>
    <li>In Brave Sync Settings</li>
    <li>Create Greg Profile in Chrome</li>
    <li>Create Bed Brigade Profile in Chrome</li>
    <li>Login to Microsoft Chrome and Brave</li>
    <li>Login to Teams</li>
    <li>Login to Slack</li>
    <li>Sync Folders with SyncThing</li>
    <li>Configure Beyond Compare Licensing</li>
    <li>Configure Rider Licensing</li>
    <li>Configure GitHub Co-pilot in Rider</li>
    <li>VSCode Profile Sync</li>
    <li>Configure GitHub Co-pilot in VSCode</li>
    <li>Configure sites in Filezilla</li>
    <li>Go into keyboard shortcuts and add super f to launch searchmonkey</li>
    <li>In Dolphin, Menu => Configure => View Modes => Date Style Absolute</li>        
    <li>Setup/Copy Windows 11 VirtualBox with this software</li>
    <ul>
        <li>Office with Publisher</li>
        <li>Database.NET</li>
        <li>Markdown Monster</li>
        <li>Code Searcher</li>
        <li>Database Searcher</li>
        <li>PicPick</li>
    </ul>
</ol>

## Install NVidia Drivers

```bash
sudo ubuntu-drivers devices
sudo ubuntu-drivers autoinstall
sudo reboot
```

## Add dotnet to the path

```bash
nano ~/.bashrc
```

Add this at the end

```bash
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$HOME/.dotnet:$HOME/.dotnet/tools
```

Reload

```bash
source ~/.bashrc
```

## Add dotnet to VS Code

In the VS Code Terminal

```bash
nano ~/.profile
```

Add to the end

```bash
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$HOME/.dotnet:$HOME/.dotnet/tools
```

Close and reopen VS Code

## Semi-Important Manual Steps

<ol>
    <li>Configure a NetFramework Bottle using <a href="Bottles-Configuration.md">Bottles Configuration</a></li>
    <li>Install Notepad++ in the Bottle</li>
    <li>Install Developer Multitool in the Bottle</li>
    <li>Install Paint.NET 3.5 in the Bottle</li>
</ol>

## Not as Important Manual Steps

<ol>
    <li>Login to Spotify</li>
    <li>Sync Firefox Settings</li>
</ol>
