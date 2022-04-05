# {{{ custom commands

# remove zgen uninstalled plugins
zclean() {
    cd
    list=$(find .zgen -not -path '*/\.*' -type d -mindepth 2 -maxdepth 2 | xargs -n 1 printf '/Users/aravindmurali/%s\n')
    installed=$(cat ~/.zgen/init.zsh | grep 'source' | cut -d ' ' -f 2 | cut -d '"' -f 2 | \
        awk -F '/' '{for(i=2;i<NF;++i)printf("/%s", $i);printf("\n");}')

    while read item;
    do
        exists=0
        while read installedItem;
        do
            if [ "$item" = "$installedItem" ]; then
                exists=1
                break
            fi
        done <<< "$installed"

        if [ $exists -eq 0 ]; then
            echo 'removing' $item
            rm -rf $item
        fi
    done <<< "$list"

    cd -
}

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
    local toollist
    toollist=$(printf 'brew\nzgen' | fzf --multi)
    while read tool;
    do
        if [ "$tool" = "brew" ]; then
            brew upgrade `brew outdated` && brew cleanup
        # elif [ "$tool" = "pip3" ]; then
        #     pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | grep -v 'pip' | xargs -n1 pip3 install -U
        elif [ "$tool" = "zgen" ]; then
            zgen update || zgen selfupdate
        fi
    done <<< "$toollist"
    exec zsh
}

# update script for tools, using fzf
fblack() {
    if [ $(pwd) = "/Users/aravindmurali" ]; then
        return -1
    fi
    local pys
    pys=$(fd -t f --hidden --ignore-file $HOME/.config/fd/ignore -e py)
    echo $pys
    pys=$(awk '{ printf("%s ",$0) } END { printf "\n" }' <<< "$pys")
    if [ "$pys" = "" ]; then
        return -1
    fi
    cmd="/usr/local/bin/black --line-length 119 ${pys}"
    eval $cmd
}
# }}}

# {{{ key-bindings
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
# }}}

# {{{ variables

# Less Colors for Man Pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

# fzf options
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

# sfz-prompt
PROMPT_SFZ_CHAR="࿗"

# command history settings
HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=$HISTSIZE

# }}}

# {{{ zgen
source "${HOME}/.zgen/zgen.zsh"

# if the init script doesn't exist
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen load zdharma-continuum/fast-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-completions
    zgen load mreinhardt/sfz-prompt.zsh
    zgen load mollifier/cd-bookmark
    zgen load kazhala/dotbare
    zgen load wfxr/forgit

    zgen save
fi
# }}}

# {{{ source
# fzf plugin
source ~/.fzf.zsh

# shell aliases
source ~/.zsh_aliases
# }}}

# {{{  setopt
# limit correction only to commands
setopt correct

# setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt SHARE_HISTORY

# don't display RPROMPT for previously accepted lines; only display it next to current line
# setopt transient_rprompt
# }}}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Volumes/aravindm711/miniconda/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Volumes/aravindm711/miniconda/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Volumes/aravindm711/miniconda/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$PATH:/Volumes/aravindm711/miniconda/miniconda3/bin"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

