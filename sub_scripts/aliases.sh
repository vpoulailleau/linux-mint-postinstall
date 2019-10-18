#!/bin/bash

# add common aliases
cat <<EOT > ~/.bash_aliases_linux_mint_postinstall.sh
alias ls='ls --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias ga='git add'
alias gc='git commit'
alias gs='git status'
alias gl='git log --graph --oneline --decorate --all'

alias act='source venv/bin/activate'
EOT

INSTALLED=`cat ~/.bashrc | grep bash_aliases_linux_mint_postinstall.sh | wc -l`
if [ "$INSTALLED" = "0" ]
then
    echo ""                                                         >> ~/.bashrc
    echo "# https://github.com/vpoulailleau/linux-mint-postinstall" >> ~/.bashrc
    echo "source ~/.bash_aliases_linux_mint_postinstall.sh"         >> ~/.bashrc
fi