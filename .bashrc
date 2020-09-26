# bash aliases
source ~/.bash_aliases

# fzf key-bindings and completion
source '/data/data/com.termux/files/usr/share/fzf/key-bindings.bash'
source '/data/data/com.termux/files/usr/share/fzf/completion.bash'

# dotbare
source ~/bash-plugins/dotbare/dotbare.plugin.bash

# powerline prompt
source ~/bash-plugins/pureline/pureline ~/.pureline.conf

# powerline settings
export PL_PATH_TRIM=2
export PL_TIME_SHOW_SECONDS=false

export PL_SSH_SHOW_HOST=false
export PL_USER_SHOW_HOST=false

# fzf settings
export FZF_DEFAULT_COMMAND="fd -t f --follow --hidden --ignore-file '$HOME/.config/fd/ignore'"
export FZF_DEFAULT_OPTS="--height 40% --layout reverse --info inline --border \
    --preview 'bat --line-range :500 {}' --preview-window=:hidden \
    --bind='space:toggle-preview' --bind='alt-s:toggle-sort' \
    --bind='alt-a:toggle-all' --bind='alt-0:top' --bind='alt-i:jump' \
    --bind='ctrl-alt-d:preview-page-down' --bind='ctrl-alt-u:preview-page-up'"

export FZF_ALT_C_COMMAND="fd -t d --follow --hidden --ignore-file '$HOME/.config/fd/ignore'"
export FZF_ALT_C_OPTS="--preview 'tree -L 2 {}'"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS"

# default editor for the shell
export EDITOR=vim
export VISUAL=vim

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# dotbare variables
export DOTBARE_DIR="$HOME/.cfg"
export DOTBARE_TREE="$HOME"

