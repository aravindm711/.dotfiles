export PATH=/usr/local/bin:$PATH

export JAVA_HOME=/library/java/javavirtualmachines/jdk1.8.0_144.jdk/contents/home

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$HOME/library/Android/sdk/emulator/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH=$PATH:$HOME/development/flutter/bin

export ANT_HOME=$HOME/src/apache-ant-1.10.6
export PATH=$PATH:$ANT_HOME/bin

export PATH=$PATH:$HOME/bin

export LDFLAGS="$LDFLAGS -L/usr/local/opt/sqlite/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/sqlite/include"
export PATH=$PATH:/usr/local/opt/sqlite/bin

export LDFLAGS="$LDFLAGS -L/usr/local/opt/qt/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/qt/include"
export PATH="/usr/local/opt/qt/bin:$PATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

export TERM=xterm-256color

export CFLAGS="$CFLAGS -I/usr/local/include/"
export LDFLAGS="$LDFLAGS -L/usr/local/lib/ -largp"

export LDFLAGS="$LDFLAGS -L/usr/local/opt/ruby/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/ruby/include"
export PATH=$PATH:/usr/local/opt/ruby/bin
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

export PATH=/usr/local/gcc-9.2/bin:$PATH

export PATH="/usr/local/sbin:$PATH"

#export CPATH=/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/usr/include

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
