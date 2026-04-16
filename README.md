# An Easier Life with Linux

A guide to make Linux actually pleasant to use — better shell, smarter CLI tools, a fast terminal, a good-looking desktop, and a dev environment that doesn't fight you.

Works on any distro. Ubuntu-specific install commands are in their own section at the end.

## What's in here

| File | What it is |
|------|-----------|
| [`.zshrc`](.zshrc) | ZSH config — prompt, plugins, aliases, fuzzy git helpers |
| [`ghostty/config`](ghostty/config) | Ghostty terminal config — Catppuccin theme, splits, keybinds |

Pick what you like, ignore the rest.

---

## 1. Terminal — Ghostty

[Ghostty](https://ghostty.org/) is a GPU-accelerated terminal with native splits, tabs, and built-in themes. Fast, zero-config out of the box, and deeply customizable when you want it.

Why Ghostty over the default terminal:
- **GPU rendering** — noticeably smoother scrolling and redraw
- **Native splits** — no need for tmux or zellij for basic pane management
- **Built-in themes** — Catppuccin and many others, no manual theme files
- **Font ligatures** — `!=` `=>` `->` render as proper symbols

### Install

See [ghostty.org/download](https://ghostty.org/download) for your distro.

### Configure

```bash
mkdir -p ~/.config/ghostty
cp ghostty/config ~/.config/ghostty/config
```

### Keybinds

The included config sets up:

**Splits:**

| Key | Action |
|-----|--------|
| `Alt \` | Split right |
| `Alt -` | Split down |
| `Alt x` | Close split |
| `Alt z` | Zoom split (toggle) |
| `Alt hjkl` or `Ctrl ←↓↑→` | Move between splits |
| `Alt HJKL` | Resize splits |

**Tabs:**

| Key | Action |
|-----|--------|
| `Alt t` | New tab |
| `Alt w` | Close tab |
| `Alt 1-5` | Jump to tab |
| `Alt ←→` | Previous / next tab |

**Other:** Copy on select is enabled — select text and it goes straight to clipboard.

---

## 2. Shell — ZSH + Oh-My-Zsh

Bash works, but ZSH with [Oh-My-Zsh](https://ohmyz.sh/) is a significant quality-of-life upgrade: better tab completion, plugin ecosystem, and easier to customize.

### Install Oh-My-Zsh

```bash
# Install ZSH first (see distro-specific section below)
chsh -s $(which zsh)
# Log out and back in, then:
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Plugins worth installing

These three make the biggest difference day-to-day:

```bash
# Suggests commands as you type, based on history
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Colors valid/invalid commands as you type — catches typos before you hit Enter
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Reminds you when you have an alias for the command you just typed
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
```

### Apply config

```bash
cp .zshrc ~/.zshrc
source ~/.zshrc
```

The included `.zshrc` sets up:
- **Custom prompt** — full path + git branch with dirty/clean status, no theme needed
- **Plugins** — autosuggestions, syntax highlighting, you-should-use
- **History** — 50k lines, dedup, shared across terminal sessions
- **Fuzzy git helpers** — `gbc` (checkout branch), `gfix` (fixup commit), `gadd` (stage files)

---

## 3. CLI Power Tools

These four tools are the biggest productivity boost you can get in a terminal. Once you use them, you won't go back.

| Tool | Replaces | Why it's better |
|------|----------|----------------|
| **[fd](https://github.com/sharkdp/fd)** | `find` | Sane defaults, respects `.gitignore`, way faster |
| **[fzf](https://github.com/junegunn/fzf)** | — | Fuzzy-find anything: files, history (`Ctrl+R`), git branches |
| **[bat](https://github.com/sharkdp/bat)** | `cat` | Syntax highlighting, line numbers, git diff integration |
| **[zoxide](https://github.com/ajeetdsouza/zoxide)** | `cd` | Learns your frequent directories — `z proj` jumps to `~/projects` |

Install zoxide:
```bash
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
```

For fd, fzf, and bat — see the distro-specific section below.

> **Note:** On some distros (Ubuntu/Debian), the binaries are named `fdfind` and `batcat` to avoid conflicts. The `.zshrc` aliases them to `fd` and `bat`.

### Fuzzy git helpers

The `.zshrc` includes three fzf-powered git functions:

- **`gbc`** — fuzzy checkout branch (sorted by most recent)
- **`gfix`** — pick a recent commit and `git commit --fixup` to it
- **`gadd`** — pick unstaged files to stage, with diff preview

These are examples of how fzf can wrap any command. Build your own.

---

## 4. Desktop — Catppuccin

[Catppuccin](https://github.com/catppuccin/catppuccin) is a community-driven pastel theme with good contrast. Available for GTK, KDE, and pretty much everything else.

### GTK theme (GNOME, XFCE, etc.)

```bash
# Download from https://github.com/catppuccin/gtk/releases
# Extract to /usr/share/themes/ (system-wide) or ~/.themes/ (user)
```

Apply on GNOME:
```bash
gsettings set org.gnome.desktop.interface gtk-theme 'catppuccin-mocha-lavender-standard+default'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

### Papirus icons

Clean, consistent icon set. Works on any desktop environment.

```bash
# See distro-specific section for install commands
```

Apply on GNOME:
```bash
gsettings set org.gnome.desktop.interface icon-theme 'Papirus-Light'
```

### Everything else

Catppuccin has ports for nearly everything: [catppuccin.com](https://catppuccin.com/ports)
- Ghostty (built-in, already in the config)
- Zed, VS Code, JetBrains
- Firefox, Chrome
- Slack, Discord
- And many more

---

## 5. Fonts

**For code** — [JetBrains Mono](https://www.jetbrains.com/lp/mono/): excellent ligatures, clear at small sizes.
```bash
mkdir -p ~/.local/share/fonts
# Download from https://www.jetbrains.com/lp/mono/
cp JetBrainsMono*.ttf ~/.local/share/fonts/
fc-cache -fv
```

**Alternative** — [Fira Code](https://github.com/tonsky/FiraCode): similar vibe, widely packaged.

**For writing** — [iA Writer Quattro](https://github.com/iaolo/iA-Fonts): proportional font designed for long-form text.

---

## 6. Apps

### Zed Editor

Fast, modern code editor. Worth trying if you want something lighter than VS Code.

```bash
curl -f https://zed.dev/install.sh | sh
```

Pairs well with **Catppuccin Macchiato** theme (set in Zed settings).

### Obsidian

Markdown-based note-taking with local files. Great for personal knowledge bases.

```bash
# Download AppImage from https://obsidian.md/download
chmod +x Obsidian.AppImage
sudo mv Obsidian.AppImage /opt/Obsidian.AppImage
```

---

## 7. Dev Environment

These all work the same regardless of distro.

### Git
```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

### SSH Keys
```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

### Python + uv
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

[uv](https://github.com/astral-sh/uv) is a fast Python package manager — think `pip` but 10-100x faster.

### Rust
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source "$HOME/.cargo/env"
```

### Node.js (via NVM)
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
# Restart shell, then:
nvm install --lts
```

### Docker

See distro-specific section below for install commands.

---

## Distro-Specific Install Commands

### Ubuntu / Debian

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install curl git zsh fd-find fzf bat xclip python3 python3-pip python3-venv

# Ghostty
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

# Papirus icons
sudo add-apt-repository ppa:papirus/papirus
sudo apt update
sudo apt install papirus-icon-theme

# Fira Code (if you want it from apt instead of manual install)
sudo apt install fonts-firacode

# Docker
sudo apt install docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# Set Ghostty as default terminal
sudo update-alternatives --set x-terminal-emulator /usr/bin/ghostty
```

#### GNOME Extensions (Ubuntu)

Install from https://extensions.gnome.org/:

| Extension | What it does |
|-----------|-------------|
| **[Vitals](https://extensions.gnome.org/extension/1460/vitals/)** | CPU, RAM, temperature in the top bar |
| **[Space Bar](https://extensions.gnome.org/extension/5090/space-bar/)** | Workspace names/indicator in the top bar |
| **[Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/)** | Blur effect on overview and panel |
| **[Clipboard Indicator](https://extensions.gnome.org/extension/779/clipboard-indicator/)** | Clipboard history — never lose a copy again |
| **Tiling Assistant** | Window tiling (comes with Ubuntu 24.04+) |

#### Backup & Restore (Ubuntu)

Back up your home directory before reinstalling:

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

# Save package list
apt-mark showmanual > ~/backup_$(date +%Y%m%d)/package_list.txt
```

Restore:
```bash
rsync -aAXv --info=progress2 home_backup/ ~/
sudo chown -R $USER:$USER ~/
```

### Fedora

```bash
sudo dnf update -y
sudo dnf install curl git zsh fd-find fzf bat xclip python3 python3-pip

# Ghostty
sudo dnf copr enable pgdev/ghostty
sudo dnf install ghostty

# Papirus icons
sudo dnf install papirus-icon-theme

# Docker
sudo dnf install docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
```

> **Note:** On Fedora, `fd` and `bat` use their real names — no aliases needed. You can remove the `alias bat='batcat'` line from `.zshrc`.
