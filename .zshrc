# Path to your oh-my-zsh installation.
export ZSH="/home/thomasoca/.oh-my-zsh"

# zsh theme
ZSH_THEME="robbyrussell"

# Load plugins 
plugins=(git fzf-tab zsh-syntax-highlighting zsh-autosuggestions)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
#ZSH_TMUX_AUTOSTART=true
autoload -U compinit; compinit
source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=$HOME/.config/rofi/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH="/home/thomasoca/.local/bin:$PATH"
export PATH=$PATH:/home/thomasoca/bin
export PATH=$PATH:~/.spoof-dpi/bin
export CGO_ENABLED=1
export CXX=clang++
# export MANPATH="/usr/local/man:$MANPATH"

# FZF setting
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
alias vim='nvim'
alias oldvim='vim'
alias ls='ls --color=auto'
alias lf='lfrun'
alias docker-start='sudo systemctl start docker'

# The following lines were added by compinstall
zstyle :compinstall filename '/home/thomasoca/.zshrc'

autoload -Uz compinit
compinit
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init zsh --cmd cd)"
# End of lines added by compinstall

# pyenv config
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
