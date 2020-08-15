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
    toollist=$(printf 'zgen' | fzf --multi)
    while read tool;
    do
        if [ "$tool" = "zgen" ]; then
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
export FZF_DEFAULT_COMMAND="find -type f"
export FZF_DEFAULT_OPTS="--height 40% --layout reverse --info inline --border \
    --preview 'bat --line-range :500 {}' --preview-window=:hidden \
    --bind='space:toggle-preview' --bind='alt-s:toggle-sort' \
    --bind='alt-a:toggle-all' --bind='alt-0:top' --bind='alt-i:jump' \
    --bind='ctrl-alt-n:preview-page-down' --bind='ctrl-alt-p:preview-page-up'"

export FZF_ALT_C_COMMAND="find -type d"
export FZF_ALT_C_OPTS="--preview 'tree -L 2 {}'"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS"

# source fzf.zsh plugin
source ~/.fzf.zsh

# sfz-prompt
PROMPT_SFZ_CHAR="࿗"

# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen load zdharma/fast-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-completions
    zgen load mreinhardt/sfz-prompt.zsh
    zgen load mengelbrecht/slimline
    zgen load wfxr/forgit

    zgen save
fi

# default editor for the shell
export EDITOR=vim
export VISUAL=vim

# source alias commands file
source ~/.zsh_aliases

# don't display RPROMPT for previously accepted lines; only display it next to current line
setopt transient_rprompt

# limit correction only to commands
setopt correct
