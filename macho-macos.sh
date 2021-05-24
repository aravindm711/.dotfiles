# !/bin/sh

# macho man pages script variant for MacOS

# requirements - ripgrep, fzf
# run this command to include man pages for packages installed by homebrew,
#    `$sudo /usr/libexec/makewhatis /usr/share/man /usr/local/share/man`

# manual=$(apropos . | \
#     cut -d '-' -f 1 | \
#     awk -F ', ' '{for(i=1;i<=NF;++i)if($i!="")printf("%s\n",$i)}' | \
#     rg -v '[:!@#\$%&\*\.]' | \
#     fzf --preview-window=right \
#         --preview 'echo {1} | sed -e "s/([^()]*)//g" | xargs -I{S} man -Pcat {S} {2} 2>/dev/null' | \
#     sed -e 's/([^()]*)//g')

manual=$(apropos . | \
    cut -d '-' -f 1 | \
    awk -F ', ' '{for(i=1;i<=NF;++i)if($i!="")printf("%s\n",$i)}' | \
    rg -v '[:!@#\$%&\*\.]' | \
    sed -e 's/([^()]*)//g' | \
    fzf --preview-window=right \
    --preview 'echo {1} | xargs -I{S} man -Pcat {S} {2} 2>/dev/null')

[ -z $manual ] && exit 0
man $manual