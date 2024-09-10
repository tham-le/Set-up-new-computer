# Ubuntu New Computer Setup Guide

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
1. In `~/.zshrc`, find the line starting with `plugins=`
2. Add your desired plugins, e.g., `plugins=(git)`
3. Save the file and run `source ~/.zshrc` to apply changes

look at ``FZF``


## 2. Set up Sublime Text

1. Install the GPG key:
   ```
   wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
   ```

2. Add the Sublime Text repository:
   ```
   echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
   ```

3. Update apt and install Sublime Text:
   ```
   sudo apt-get update
   sudo apt-get install sublime-text
   ```

4. Install Package Control:
```
https://packagecontrol.io/installation
```
   - Open Sublime Text
   - Press ``Ctrl+P`` to open the console
   - Paste the installation code from packagecontrol.io and press Enter

5. Install desired packages:
   - Press Ctrl+Shift+P
   - Type "Package Control: Install Package"
   - Search for and install desired packages
 
 ```
 - A File Icon
 - BracketHighlighter
 - EasylangComplete
 - Gitignore
 - LSP
 - LSP-clangd
 - LSP-pylsp
 - MonokaiFree

 ```

 6. Setting

```
 {
	"ignored_packages":
	[
		"Vintage",
          ],
	 "preview_on_click": true,
	"index_files": true,
	"save_on_focus_lost": true,
	"draw_white_space": ["all"],
	 "animation_enabled": false,
    "block_caret": false,
    "caret_extra_bottom": 0,
    "caret_extra_top": 0,
    "caret_style": "blink",
    "file_tab_style": "square",
    "color_scheme": "MonokaiFree.sublime-color-scheme",
    "monokaifree.vcs_status_badges": false,
    "theme": "Adaptive.sublime-theme",
    "show_file": true,
    "show_file_name": true,
    "auto_complete": true,
    "auto_complete_cycle": true,
     "auto_complete_trailing_symbols": true,
    "auto_complete_use_history": true,
    "auto_complete_with_fields": true,
}
```

## 3. Set up Doxygen

1. Install Doxygen:
   ```

   sudo apt-get update
   sudo apt-get install flex
   sudo apt-get install bison
   sudo apt-get install libiconv
   sudo apt-get install doxygen
   sudo apt install doxygen-gui
   ```

2. Create a configuration file:
   - Navigate to your project directory
   - Run `doxygen -g` to generate a default Doxyfile

3. Edit the Doxyfile to customize settings as needed:
   ```
   nano Doxyfile
   ```

4. To generate documentation, navigate to your project directory and run:
   ```
   doxygen Doxyfile
   ```

### 4. Git Setup

- Git Setup

```arduino
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

```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
### 7. Python and Pip Setup
```
sudo apt-get install python3 python3-pip
```
### 8. Syncthing

https://syncthing.net/downloads/
