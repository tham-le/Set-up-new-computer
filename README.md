# Ubuntu New Computer Setup Guide

## 0. Backup Current System (Before Reinstalling)

### Create Backup Directory
```bash
# Create backup location (adjust path as needed)
mkdir -p ~/backup_$(date +%Y%m%d)
```

### Backup Home Directory with rsync
```bash
# Backup entire home directory (excluding cache, temp files, and large SDKs)
rsync -aAXv --info=progress2 \
    --exclude='.cache/' \
    --exclude='.local/share/Trash/' \
    --exclude='snap/' \
    --exclude='android-ndk-r25c-linux.zip' \
    --exclude='android-ndk-r25c/' \
    --exclude='android-sdk-linux/' \
    --exclude='.cargo/registry/' \
    --exclude='.cargo/git/' \
    --exclude='.rustup/toolchains/*/share/doc/' \
    --exclude='.gradle/caches/' \
    --exclude='.npm/_cacache/' \
    --exclude='.nv/' \
    --exclude='.wine/' \
    --exclude='*.zwc' \
    --exclude='.zcompdump*' \
    ~/ ~/backup_$(date +%Y%m%d)/home_backup/
```

**rsync flags explained:**
- `-a`: Archive mode (preserves permissions, timestamps, symlinks, etc.)
- `-A`: Preserve ACLs (Access Control Lists)
- `-X`: Preserve extended attributes
- `-v`: Verbose output
- `--info=progress2`: Show overall progress

### Save Installed Packages List
```bash
cd ~/backup_$(date +%Y%m%d)

# Save list of manually installed packages
apt-mark showmanual > package_list.txt

# Save all package selections
dpkg --get-selections > installed_packages.txt

# Save APT sources
cp /etc/apt/sources.list sources.list.backup
cp -r /etc/apt/sources.list.d/ apt_sources_backup/
```

### Backup Important Configurations
```bash
# Copy system configs 
sudo cp /etc/fstab fstab.backup 2>/dev/null || true
sudo cp /etc/hosts hosts.backup 2>/dev/null || true

# Document installed snaps
snap list > snap_list.txt 2>/dev/null || true

# Document Docker images/containers (if applicable)
docker images > docker_images.txt 2>/dev/null || true
docker ps -a > docker_containers.txt 2>/dev/null || true
```

### Verify Your Backup
```bash
# Check backup size and contents
du -sh ~/backup_$(date +%Y%m%d)/home_backup/
ls -lh ~/backup_$(date +%Y%m%d)/

echo "Backup location: ~/backup_$(date +%Y%m%d)"
echo "Copy this entire directory to external drive or cloud storage"
```

**Important:** Copy the backup directory to an external drive, USB stick, or cloud storage before reinstalling Ubuntu.

---

## After Fresh Ubuntu Installation

### Restore From Backup

#### 1. Copy Backup to New System
```bash
# Mount your backup drive or download from cloud
# Then copy backup directory to home
```

#### 2. Restore Home Directory with rsync
```bash
# Navigate to where you stored your backup
cd /path/to/backup_YYYYMMDD

# Restore home directory
rsync -aAXv --info=progress2 \
    home_backup/ ~/
```

#### 3. Fix Permissions
```bash
sudo chown -R $USER:$USER ~/
chmod 700 ~/.ssh  # if SSH keys exist
chmod 600 ~/.ssh/id_* 2>/dev/null || true
```

#### 4. Restore APT Sources (Optional)
```bash
# Only if you had custom PPAs
cd /path/to/backup_YYYYMMDD
sudo cp sources.list.backup /etc/apt/sources.list
sudo cp -r apt_sources_backup/* /etc/apt/sources.list.d/
sudo apt update
```

---

## Fresh Installation Setup

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl git
```

## 1. Set up ZSH, Oh-My-Zsh, theme, and plugins

### Install ZSH
1. Run: `sudo apt-get install zsh`
2. Set ZSH as default shell: `chsh -s $(which zsh)`
3. Log out and log back in

### Install Oh-My-Zsh
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

**Note:** If you restored your backup, your `.zshrc` is already configured. Otherwise, continue with theme and plugin setup below.

### Add plugins (Skip if restored from backup)
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
```

Update plugins in `~/.zshrc`:
```bash
plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use)
```

Look at `FZF` for fuzzy finding.

## 2. Set up Zed
```bash
curl -f https://zed.dev/install.sh | sh
```

## 3. Set up Obsidian
```bash
# Download from https://obsidian.md/download
chmod +x Obsidian.AppImage
sudo mv Obsidian.AppImage /opt/Obsidian.AppImage
echo "export PATH=\$PATH:/opt" >> ~/.zshrc
echo "alias obsidian='/opt/Obsidian.AppImage'" >> ~/.zshrc
source ~/.zshrc
```

**Note:** Your Obsidian vaults are already restored if you backed up your home directory.

## 4. Git Setup
```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

**Note:** If restored from backup, your git config is already set.

## 5. Docker Installation
```bash
sudo apt-get install docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER  # Add yourself to docker group
```

Log out and back in for docker group to take effect.

## 6. SSH Key Setup
```bash
# Generate new SSH key (skip if restored from backup)
ssh-keygen -t ed25519 -C "your_email@example.com"

# Start ssh-agent and add key
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copy public key to clipboard (install xclip if needed)
sudo apt install xclip
xclip -selection clipboard < ~/.ssh/id_ed25519.pub
```

Add the key to GitHub at https://github.com/settings/keys

**Note:** If you restored from backup, your SSH keys are already in `~/.ssh/`

## 7. Python and uv Setup
```bash
sudo apt-get install python3 python3-pip python3-venv
```

Install uv:
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## 8. Rust Setup
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
```

**Note:** If restored from backup, Rust toolchain is already installed but you may need to update:
```bash
rustup update
```


## Quick Restore Packages (Optional Method)

If you want to reinstall all your previous packages at once:

```bash
# From your backup directory
sudo apt update
xargs sudo apt install -y < package_list.txt
```

This will reinstall everything you had before, though it may take some time.

---

## Verification Checklist

After setup, verify everything works:
- [ ] ZSH loads with your theme and plugins
- [ ] Git commands work with your credentials
- [ ] SSH keys work (test with `ssh -T git@github.com`)
- [ ] Docker runs without sudo
- [ ] Python and uv are accessible
- [ ] Rust compiler works (`rustc --version`)
- [ ] Your development projects still build
- [ ] Obsidian opens your vaults correctly
