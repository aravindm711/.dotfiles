bcd() {
    cd $HOME && cd "$(cat "$HOME/.cdbookmark" | cut -d "|" -f 2 | fzf --preview="tree -L 2 {}")"
    zle accept-line
}

bindkey -v
bindkey '^a' beginning-of-line
bindkey '^b' backward-char
bindkey '^e' end-of-line
bindkey '^f' forward-char
bindkey '^h' backward-delete-char
bindkey '^k' kill-line
bindkey '^u' kill-whole-line
bindkey '^w' backward-kill-word

bindkey -s '^g' "dotbare fedit"^j

# open bookmarked directories in fzf pane
zle -N bcd
bindkey '^o' bcd

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
