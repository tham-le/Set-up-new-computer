# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Custom prompt: full path + git info
ZSH_THEME=""
PROMPT='%F{cyan}%~%f $(git_prompt_info) %F{green}➜%f '
ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%f "
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}✗%f"
ZSH_THEME_GIT_PROMPT_CLEAN=" %F{green}✔%f"

# Plugins
plugins=(git zsh-autosuggestions
	zsh-syntax-highlighting
	you-should-use)

source $ZSH/oh-my-zsh.sh

# --- Aliases ---
alias python='python3'
alias py='python3'
alias pip='pip3'
alias bat='batcat'
alias f='fd -e rs | fzf --preview "batcat --color=always {}"'
alias gl20='git log --oneline -20'

# --- fzf defaults ---
export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# --- Fuzzy git helpers (fzf) ---

# Fuzzy checkout branch
gbc() {
    git branch --all --sort=-committerdate | fzf --height 40% --reverse | sed 's/remotes\/origin\///' | xargs git checkout
}

# Fuzzy fixup: pick a commit to fixup from log
gfix() {
    local commit
    commit=$(git log --oneline -20 | fzf --height 40% --reverse | awk '{print $1}')
    [ -n "$commit" ] && git commit --fixup="$commit"
}

# Fuzzy git add: pick unstaged files
gadd() {
    git diff --name-only | fzf -m --height 40% --reverse --preview 'git diff --color=always {}' | xargs -r git add
}

# --- Shell behavior ---
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
unsetopt BEEP
bindkey '^U' backward-kill-line

# zoxide (smart cd)
eval "$(zoxide init zsh)"
