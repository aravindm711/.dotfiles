# fkill - kill processes - list only the ones you can kill.
fkill() {
    local pid
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi
}

# update script for tools, using fzf
fupdate() {
    toollist=$(printf 'pip3\nzgen' | fzf --multi)
    while read tool;
    do
        if [ "$tool" = "pip3" ]; then
            pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | grep -v 'pip' | xargs -n1 pip3 install -U
        elif [ "$tool" = "zgen" ]; then
            zgen update && zgen selfupdate
        fi
    done <<< "$toollist"
    exec zsh
}

# vim bindings for shell
bindkey -v
bindkey '^a' beginning-of-line
bindkey '^b' backward-char
bindkey '^e' end-of-line
bindkey '^f' forward-char
bindkey '^h' backward-delete-char
bindkey '^k' kill-line
bindkey '^u' kill-whole-line
bindkey '^w' backward-kill-word

# open dotfiles for editing
bindkey -s '^g' "dotbare fedit"^j

# fzf options
# export FZF_DEFAULT_COMMAND="fd -t f --follow --hidden --ignore-file '$HOME/.fdignore'"
export FZF_DEFAULT_OPTS="--height 40% --layout reverse --info inline --border \
    --preview 'bat --line-range :500 {}' --preview-window=:hidden \
    --bind='space:toggle-preview' --bind='alt-s:toggle-sort' \
    --bind='alt-a:toggle-all' --bind='alt-0:top' --bind='alt-i:jump' \
    --bind='ctrl-alt-n:preview-page-down' --bind='ctrl-alt-p:preview-page-up'"

# export FZF_ALT_C_COMMAND="fd -t d --follow --hidden --ignore-file '$HOME/.fdignore'"
export FZF_ALT_C_OPTS="--preview 'tree -L 2 {}'"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS"

# source fzf.zsh plugin
source ~/.fzf.zsh

# slimline
export SLIMLINE_PROMPT_VERSION=1
export SLIMLINE_PROMPT_SYMBOL='࿗'

# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen load zdharma/fast-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-completions
    zgen load mengelbrecht/slimline
    zgen load wfxr/forgit

    zgen save
fi

# default editor for the shell
export EDITOR=vim
export VISUAL=vim

# slimline command prompt
export SLIMLINE_CWD_FORMAT='%F{cyan}%1d%f'
# export SLIMLINE_CWD_FORMAT='%F{cyan}%10<..<%~%<<%f'

# source alias commands file
source ~/.zsh_aliases

# don't display RPROMPT for previously accepted lines; only display it next to current line
setopt transient_rprompt

# limit correction only to commands
setopt correct
