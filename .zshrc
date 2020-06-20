# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:/usr/local/bin:$PATH

source ~/.zsh_aliases

# bindkey -v
# bindkey '^a' beginning-of-line
# bindkey '^b' backward-char
# bindkey '^e' end-of-line
# bindkey '^f' forward-char
# bindkey '^h' backward-delete-char
# bindkey '^k' kill-line
# bindkey '^u' kill-whole-line
# bindkey '^w' backward-kill-word

# zsh-plugins
fpath=($HOME/.zsh/zsh-completions/src $fpath)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# powerlevel10k
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
source ~/.p10k.zsh
# Don't shorten this many last directory segments. They are anchors.
typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
# source ~/.zsh/.zsh-theme-gruvbox-material-dark

# fzf
source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--height 40% --layout reverse --info inline --border \
    --preview 'head -100 {}' --preview-window right:50% \
    --color fg:#ebdbb2,bg:#282828,fg+:#ebdbb2,bg+:#3c3836 \
    --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54"
#    --color 'fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899'"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh
