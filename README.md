# Ubuntu New Computer Setup Guide

## 0. Backup Current System (Before Reinstalling)

### Create Backup Directory
```bash
mkdir -p ~/backup_$(date +%Y%m%d)
```

### Backup Home Directory with rsync
```bash
rsync -aAXv --info=progress2 \
    --exclude='.cache/' \
    --exclude='.local/share/Trash/' \
    --exclude='snap/' \
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

**rsync flags:** `-a` archive, `-A` preserve ACLs, `-X` preserve extended attributes, `-v` verbose, `--info=progress2` overall progress.

### Save Installed Packages List
```bash
cd ~/backup_$(date +%Y%m%d)
apt-mark showmanual > package_list.txt
dpkg --get-selections > installed_packages.txt
cp /etc/apt/sources.list sources.list.backup
cp -r /etc/apt/sources.list.d/ apt_sources_backup/
```

### Backup Important Configurations
```bash
sudo cp /etc/fstab fstab.backup 2>/dev/null || true
sudo cp /etc/hosts hosts.backup 2>/dev/null || true
snap list > snap_list.txt 2>/dev/null || true
docker images > docker_images.txt 2>/dev/null || true
```

Copy the backup directory to an external drive before reinstalling.

---

## After Fresh Ubuntu Installation

### Restore From Backup

```bash
# Mount backup drive, then restore home directory
rsync -aAXv --info=progress2 home_backup/ ~/

# Fix permissions
sudo chown -R $USER:$USER ~/
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_* 2>/dev/null || true
```

---

## Fresh Installation Setup

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl git
```

## 1. ZSH + Oh-My-Zsh

### Install ZSH
```bash
sudo apt install zsh
chsh -s $(which zsh)
# Log out and back in
```

### Install Oh-My-Zsh
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Add plugins
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
```

### Apply config
```bash
cp .zshrc ~/.zshrc
source ~/.zshrc
```

The included `.zshrc` sets up:
- **Custom prompt** with full path + git branch/status (no theme)
- **Plugins:** autosuggestions, syntax highlighting, you-should-use
- **History:** 50k lines, dedup, shared across sessions
- **Fuzzy git helpers:** `gbc` (checkout branch), `gfix` (fixup commit), `gadd` (stage files) — all via fzf

## 2. CLI Power Tools

### fd, fzf, bat, zoxide
```bash
sudo apt install fd-find fzf bat
```

Install zoxide:
```bash
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
```

These replace common tools with better defaults:
- **fd** (`fdfind`) — faster `find`
- **fzf** — fuzzy finder for files, history (Ctrl+R), branches
- **bat** (`batcat`) — `cat` with syntax highlighting
- **zoxide** — smarter `cd` that learns your frequent directories

The `.zshrc` already wires these up with aliases (`bat` for `batcat`, `f` for fuzzy file search).

## 3. GNOME Theme — Catppuccin

### Install Catppuccin GTK theme
```bash
# Download from https://github.com/catppuccin/gtk/releases
# Extract to /usr/share/themes/ (system-wide) or ~/.themes/ (user only)
```

### Install Papirus icons
```bash
sudo add-apt-repository ppa:papirus/papirus
sudo apt update
sudo apt install papirus-icon-theme
```

### Apply theme
```bash
gsettings set org.gnome.desktop.interface gtk-theme 'catppuccin-mocha-lavender-standard+default'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Light'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

## 4. Fonts

### JetBrains Mono (coding)
```bash
# Download from https://www.jetbrains.com/lp/mono/
mkdir -p ~/.local/share/fonts
cp JetBrainsMono*.ttf ~/.local/share/fonts/
fc-cache -fv
```

### Fira Code (alternative)
```bash
sudo apt install fonts-firacode
```

### iA Writer Quattro (writing/notes)
```bash
# Download from https://github.com/iaolo/iA-Fonts
cp ia-writer-quattro*.ttf ~/.local/share/fonts/
fc-cache -fv
```

## 5. GNOME Extensions

Install via https://extensions.gnome.org/ or `gnome-extensions`:

- **Vitals** — system monitor in top bar (CPU, RAM, temp)
- **Space Bar** — workspace indicator in top bar
- **Blur my Shell** — blur effect on overview/panel
- **Clipboard Indicator** — clipboard history manager
- **Tiling Assistant** — window tiling (comes with Ubuntu)

## 6. Zed Editor
```bash
curl -f https://zed.dev/install.sh | sh
```

Theme: **Catppuccin Macchiato** (set in Zed settings).

## 7. Obsidian
```bash
# Download from https://obsidian.md/download
chmod +x Obsidian.AppImage
sudo mv Obsidian.AppImage /opt/Obsidian.AppImage
```

## 8. Git Setup
```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

## 9. Docker
```bash
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
# Log out and back in
```

## 10. SSH Key Setup
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copy to clipboard
sudo apt install xclip
xclip -selection clipboard < ~/.ssh/id_ed25519.pub
```

Add the key to GitHub at https://github.com/settings/keys

## 11. Python + uv
```bash
sudo apt install python3 python3-pip python3-venv
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## 12. Rust
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
```

## 13. NVM (Node.js)
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# Restart shell, then:
nvm install --lts
```

---

## Verification Checklist

- [ ] ZSH loads with custom prompt and plugins
- [ ] Git credentials work (`ssh -T git@github.com`)
- [ ] Docker runs without sudo
- [ ] `fzf`, `fd`, `bat`, `zoxide` all work
- [ ] Catppuccin theme applied (dark mode)
- [ ] Zed opens with Catppuccin Macchiato theme
- [ ] Python, uv, Rust, Node accessible
- [ ] Obsidian opens vaults
