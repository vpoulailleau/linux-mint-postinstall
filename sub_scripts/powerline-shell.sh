#!/bin/bash

sudo apt install -y fonts-powerline
pip3 install powerline-shell

INSTALLED=`cat ~/.bashrc | grep "powerline-shell" | wc -l`
if [ "$INSTALLED" = "0" ]
then
    echo ""                                                                  >> ~/.bashrc
    echo "# https://github.com/vpoulailleau/linux-mint-postinstall"          >> ~/.bashrc
    echo 'function _update_ps1() {'                                          >> ~/.bashrc
    echo '    PS1=$(powerline-shell $?)'                                     >> ~/.bashrc
    echo '}'                                                                 >> ~/.bashrc
    echo ''                                                                  >> ~/.bashrc
    echo 'if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then' >> ~/.bashrc
    echo '    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"'                 >> ~/.bashrc
    echo 'fi'                                                                >> ~/.bashrc
fi