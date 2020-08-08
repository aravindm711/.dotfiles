# cd into selected bookmarked directory
bcd() {
    cd "$(cat "$HOME/.cdbookmark" | cut -d "|" -f 2 | fzf --preview="tree -L 2 {}")"
    zle accept-line
}

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
    toollist=$(printf 'brew\npip3\nzgen' | fzf --multi)
    while read tool;
    do
        if [ "$tool" = "brew" ]; then
            brew upgrade `brew outdated` && brew cleanup
        elif [ "$tool" = "pip3" ]; then
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

# key-binding for bcd
zle -N bcd
bindkey '^o' bcd

# source fzf.zsh plugin
source ~/.fzf.zsh

# load zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen load zdharma/fast-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-completions
    zgen load mengelbrecht/slimline
    zgen load mollifier/cd-bookmark
    zgen load wfxr/forgit
    zgen load kazhala/dotbare
    # zgen load urbainvaes/fzf-marks

    zgen save
fi

# default editor for the shell
export EDITOR=vim
export VISUAL=vim

# export SLIMLINE_CWD_FORMAT='%F{cyan}%10<..<%~%<<%f'
export SLIMLINE_CWD_FORMAT='%F{cyan}%1d%f'

# source all command aliases
source ~/.zsh_aliases

# don't display RPROMPT for previously accepted lines; only display it next to current line
setopt transient_rprompt

# limit correction only to commands
setopt correct
