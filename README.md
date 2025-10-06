# Ubuntu New Computer Setup Guide
```bash
sudo apt install curl
sudo apt install git
```


## 1. Set up ZSH, Oh-My-Zsh, theme, and plugins

### Install ZSH
1. Open Terminal
2. Run: `sudo apt-get update && sudo apt-get install zsh`
3. Set ZSH as default shell: `chsh -s $(which zsh)`
4. Log out and log back in for the changes to take effect

### Install Oh-My-Zsh
1. Run: `sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

### Set up theme
1. Open `~/.zshrc` with a text editor\`
2. Find the line starting with `ZSH_THEME` and change it to your preferred theme

### Add plugins
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
```
1. In `~/.zshrc`, find the line starting with `plugins=`
2. Add your desired plugins, e.g., `plugins=(git)`
3. Save the file and run `source ~/.zshrc` to apply changes

look at ``FZF``


## 2. Set up Zed
```
 curl -f https://zed.dev/install.sh | sh
```


## 3. Set up Obsidian

1. Download and install Obsidian from https://obsidian.md/download
```
chmod +x Obsidian.AppImage
mv Obsidian.AppImage /opt/Obsidian.AppImage
echo "export PATH=$PATH:/opt" >> ~/.zshrc
echo "alias obsidian='/opt/Obsidian.AppImage'" >> ~/.zshrc
```
### 4. Git Setup

- Git Setup

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

### 5. Docker Installation

```
sudo apt-get install docker.io
sudo systemctl start docker
sudo systemctl enable docker
```
### 6. SSH Key Setup

- Generate an SSH key for GitHub/other services:
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
put the key in the GitHub
### 7. Python and uv Setup
```
sudo apt-get install python3
```
for uv
```
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## 8. Rust Setup

- Rust Setup

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
export PATH="$HOME/.cargo/bin:$PATH"
```
