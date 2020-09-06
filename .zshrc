# custom commands
# cd into selected bookmarked directory
fcdb() {
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

# copy "The Sopranos" magnet link to clipboard
ss() {
    echo "magnet:?xt=urn:btih:15D3C9A633CFCF74DDF4466B96C3A5E5D599A035&dn=The+Sopranos+%281999%29+Season+1-6+S01-S06+%281080p+BluRay+x265+HEVC+10bit+AAC+5.1+ImE%29+%5BQxR%5D&tr=udp%3A%2F%2Ftracker.opentrackr.org%3A1337%2Fannounce&tr=udp%3A%2F%2Ftracker.torrent.eu.org%3A451%2Fannounce&tr=udp%3A%2F%2Ftracker.internetwarriors.net%3A1337%2Fannounce&tr=udp%3A%2F%2Ftracker.zer0day.to%3A1337%2Fannounce&tr=udp%3A%2F%2Ftracker.leechers-paradise.org%3A6969%2Fannounce&tr=udp%3A%2F%2Fcoppersurfer.tk%3A6969%2Fannounce" | pbcopy
}

# key-bindings
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

# key-binding for fcdb
zle -N fcdb
bindkey '^o' fcdb

# conf
# fzf options
export FZF_DEFAULT_COMMAND="fd -t f --follow --hidden --ignore-file '$HOME/.config/fd/ignore'"
export FZF_DEFAULT_OPTS="--height 40% --layout reverse --info inline --border \
    --preview 'bat --line-range :500 {}' --preview-window=:hidden \
    --bind='space:toggle-preview' --bind='alt-s:toggle-sort' \
    --bind='alt-a:toggle-all' --bind='alt-0:top' --bind='alt-i:jump' \
    --bind='ctrl-alt-n:preview-page-down' --bind='ctrl-alt-p:preview-page-up'"

export FZF_ALT_C_COMMAND="fd -t d --follow --hidden --ignore-file '$HOME/.config/fd/ignore'"
export FZF_ALT_C_OPTS="--preview 'tree -L 2 {}'"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="$FZF_DEFAULT_OPTS"

# default editor for the shell
export EDITOR=vim
export VISUAL=vim

# sfz-prompt
PROMPT_SFZ_CHAR="࿗"

# zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen load zdharma/fast-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-completions
    zgen load mreinhardt/sfz-prompt.zsh
    zgen load mollifier/cd-bookmark
    zgen load kazhala/dotbare
    zgen load wfxr/forgit

    zgen save
fi

# source
# fzf plugin
source ~/.fzf.zsh

# shell aliases
source ~/.zsh_aliases

# setopt
# limit correction only to commands
setopt correct

# don't display RPROMPT for previously accepted lines; only display it next to current line
setopt transient_rprompt
