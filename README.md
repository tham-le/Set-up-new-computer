# An Easier Life with Ubuntu

A guide to make Ubuntu actually pleasant to use — better shell, smarter CLI tools, a good-looking desktop, and a dev environment that doesn't fight you.

## What's in here

- [**Shell**](#1-zsh--oh-my-zsh) — ZSH with autosuggestions, syntax highlighting, and a clean custom prompt
- [**CLI tools**](#2-cli-power-tools) — Modern replacements for `find`, `cat`, `cd`, plus fuzzy search for everything
- [**Desktop**](#3-make-gnome-look-good) — Catppuccin theme, Papirus icons, useful GNOME extensions
- [**Fonts**](#4-fonts-that-dont-hurt-your-eyes) — Coding and writing fonts that look good on any screen
- [**Dev setup**](#dev-environment) — Git, Docker, Python, Rust, Node — quick and painless

An example [`.zshrc`](.zshrc) is included as a starting point. Pick what you like, ignore the rest.

---

## Shell

### 1. ZSH + Oh-My-Zsh

Bash works, but ZSH with [Oh-My-Zsh](https://ohmyz.sh/) is a significant quality-of-life upgrade: better tab completion, plugin ecosystem, and easier to customize.

```bash
sudo apt install zsh
chsh -s $(which zsh)
# Log out and back in
```

Install Oh-My-Zsh:
```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### Plugins worth installing

These three make the biggest difference day-to-day:

```bash
# Suggests commands as you type, based on history
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Colors valid/invalid commands as you type — catches typos before you hit Enter
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Reminds you when you have an alias for the command you just typed
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
```

Then in your `~/.zshrc`:
```bash
plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use)
```

#### Custom prompt (optional)

The included `.zshrc` replaces the default theme with a minimal prompt that shows your full path and git branch with dirty/clean status:

```
~/projects/my-app (main ✔) ➜
```

No fancy powerline fonts required.

### 2. CLI Power Tools

These four tools are the biggest productivity boost you can get in a terminal. Once you use them, you won't go back.

```bash
sudo apt install fd-find fzf bat
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
```

| Tool | Replaces | Why it's better |
|------|----------|----------------|
| **[fd](https://github.com/sharkdp/fd)** (`fdfind`) | `find` | Sane defaults, respects `.gitignore`, way faster |
| **[fzf](https://github.com/junegunn/fzf)** | — | Fuzzy-find anything: files, history (`Ctrl+R`), git branches |
| **[bat](https://github.com/sharkdp/bat)** (`batcat`) | `cat` | Syntax highlighting, line numbers, git diff integration |
| **[zoxide](https://github.com/ajeetdsouza/zoxide)** | `cd` | Learns your frequent directories — `z proj` jumps to `~/projects` |

> **Note:** On Ubuntu, the binaries are named `fdfind` and `batcat` to avoid conflicts. The `.zshrc` aliases them to `fd` and `bat`.

#### Fuzzy git helpers

The `.zshrc` includes three fzf-powered git functions:

- **`gbc`** — fuzzy checkout branch (sorted by most recent)
- **`gfix`** — pick a recent commit and `git commit --fixup` to it
- **`gadd`** — pick unstaged files to stage, with diff preview

These are just examples of how fzf can wrap any command. Build your own.

### Shell tuning

A few settings in the `.zshrc` that make a real difference:

```bash
HISTSIZE=50000                  # Remember more commands
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS     # No duplicates in history
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY            # Share history across terminal sessions
unsetopt BEEP                   # No more terminal beeps
bindkey '^U' backward-kill-line # Ctrl+U clears to start of line (like Bash)
```

---

## Desktop

### 3. Make GNOME Look Good

#### Catppuccin GTK theme

[Catppuccin](https://github.com/catppuccin/catppuccin) is a community-driven pastel theme with good contrast. The Mocha variant is easy on the eyes for long sessions.

```bash
# Download from https://github.com/catppuccin/gtk/releases
# Extract to /usr/share/themes/ or ~/.themes/
```

#### Papirus icons

Clean, consistent icon theme that pairs well with Catppuccin.

```bash
sudo add-apt-repository ppa:papirus/papirus
sudo apt update
sudo apt install papirus-icon-theme
```

#### Apply everything

```bash
gsettings set org.gnome.desktop.interface gtk-theme 'catppuccin-mocha-lavender-standard+default'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Light'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

### 4. Fonts That Don't Hurt Your Eyes

**For code** — [JetBrains Mono](https://www.jetbrains.com/lp/mono/): excellent ligatures, clear at small sizes.
```bash
mkdir -p ~/.local/share/fonts
# Download from https://www.jetbrains.com/lp/mono/
cp JetBrainsMono*.ttf ~/.local/share/fonts/
fc-cache -fv
```

**Alternative** — [Fira Code](https://github.com/tonsky/FiraCode): similar vibe, available directly from apt.
```bash
sudo apt install fonts-firacode
```

**For writing** — [iA Writer Quattro](https://github.com/iaolo/iA-Fonts): proportional font designed for long-form text.

### 5. GNOME Extensions

Install from https://extensions.gnome.org/:

| Extension | What it does |
|-----------|-------------|
| **[Vitals](https://extensions.gnome.org/extension/1460/vitals/)** | CPU, RAM, temperature in the top bar |
| **[Space Bar](https://extensions.gnome.org/extension/5090/space-bar/)** | Workspace names/indicator in the top bar |
| **[Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/)** | Blur effect on overview and panel |
| **[Clipboard Indicator](https://extensions.gnome.org/extension/779/clipboard-indicator/)** | Clipboard history — never lose a copy again |
| **Tiling Assistant** | Window tiling (comes with Ubuntu 24.04+) |

---

## Apps

### 6. Zed Editor

Fast, modern code editor. Worth trying if you want something lighter than VS Code.

```bash
curl -f https://zed.dev/install.sh | sh
```

Pairs well with **Catppuccin Macchiato** theme (set in Zed settings).

### 7. Obsidian

Markdown-based note-taking with local files. Great for personal knowledge bases.

```bash
# Download AppImage from https://obsidian.md/download
chmod +x Obsidian.AppImage
sudo mv Obsidian.AppImage /opt/Obsidian.AppImage
```

---

## Dev Environment

### 8. Git
```bash
sudo apt install git
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

### 9. SSH Keys
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Copy public key to clipboard
sudo apt install xclip
xclip -selection clipboard < ~/.ssh/id_ed25519.pub
```

Add it to [GitHub](https://github.com/settings/keys) / [GitLab](https://gitlab.com/-/user_settings/ssh_keys).

### 10. Docker
```bash
sudo apt install docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
# Log out and back in for group to take effect
```

### 11. Python + uv
```bash
sudo apt install python3 python3-pip python3-venv
curl -LsSf https://astral.sh/uv/install.sh | sh
```

[uv](https://github.com/astral-sh/uv) is a fast Python package manager — think `pip` but 10-100x faster.

### 12. Rust
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
```

### 13. Node.js (via NVM)
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# Restart shell, then:
nvm install --lts
```

---

## Backup & Restore

When it's time to reinstall, back up your home directory with rsync:

```bash
mkdir -p ~/backup_$(date +%Y%m%d)

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

Save your package list too:
```bash
apt-mark showmanual > ~/backup_$(date +%Y%m%d)/package_list.txt
```

To restore on a fresh install:
```bash
rsync -aAXv --info=progress2 home_backup/ ~/
sudo chown -R $USER:$USER ~/
```
