# export ANDROID_HOME=$HOME/Library/Android/sdk
# export PATH=$PATH:$HOME/library/Android/sdk/emulator/emulator
# export PATH=$PATH:$ANDROID_HOME/tools
# export PATH=$PATH:$ANDROID_HOME/tools/bin
# export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:/usr/local/sbin

export PATH=$HOME/Library/Python/3.7/bin:$PATH

export JAVA_HOME=/library/java/javavirtualmachines/jdk1.8.0_144.jdk/contents/home

export PATH=$PATH:$HOME/development/flutter/bin

export ANT_HOME=$HOME/src/apache-ant-1.10.6
export PATH=$PATH:$ANT_HOME/bin

export LDFLAGS="$LDFLAGS -L/usr/local/opt/sqlite/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/sqlite/include"
export PATH=$PATH:/usr/local/opt/sqlite/bin

export LDFLAGS="$LDFLAGS -L/usr/local/opt/qt/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/qt/include"
export PATH="/usr/local/opt/qt/bin:$PATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export TERM=xterm-256color

export CFLAGS="$CFLAGS -I/usr/local/include/"
export LDFLAGS="$LDFLAGS -L/usr/local/lib/ -largp"

export LDFLAGS="$LDFLAGS -L/usr/local/opt/ruby/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/ruby/include"
export PATH=$PATH:/usr/local/opt/ruby/bin
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

export PATH=$PATH:/usr/local/gcc-9.2/bin

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# virtualenvwrapper paths and settings
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=$(which virtualenv)
source $HOME/Library/Python/3.7/bin/virtualenvwrapper.sh

# fzf options
export FZF_DEFAULT_COMMAND="fd -t f --follow --hidden --ignore-file '$HOME/.fd-ignore-file'"
export FZF_DEFAULT_OPTS="--height 40% --layout reverse --info inline --border \
    --preview 'bat --line-range :500 {}' --bind='space:toggle-preview' --preview-window=:hidden \
    --bind='ctrl-s:toggle-sort'"
    # --color fg:#ebdbb2,bg:#282828,fg+:#ebdbb2,bg+:#3c3836 \
    # --color info:#83a598,prompt:#bdae93,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54"
    # --color 'fg:#bbccdd,fg+:#ddeeff,bg:#334455,preview-bg:#223344,border:#778899'"

export FZF_ALT_C_COMMAND="fd -t d --follow --hidden --ignore-file '$HOME/.fd-ignore-file'"
export FZF_ALT_C_OPTS="--preview 'tree -L 2 {}'"

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_CTRL_T_OPTS="--preview 'bat {}' --bind='space:toggle-preview' --preview-window=:hidden"

# setting xdg directory specifications
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# slimline settings
export SLIMLINE_PROMPT_VERSION=1
export SLIMLINE_PROMPT_SYMBOL='࿗'

# dotbare settings
export DOTBARE_DIR="$HOME/.cfg"
export DOTBARE_TREE="$HOME"
export DOTBARE_BACKUP="$XDG_DATA_HOME/dotbare"
