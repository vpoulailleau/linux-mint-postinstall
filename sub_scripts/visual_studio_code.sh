#!/bin/bash

# TODO install python

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt update -y
sudo apt install -y code
# sudo chown -R $(whoami) /usr/share/code
code --install-extension --force ms-python.python
code --install-extension --force visualstudioexptteam.vscodeintellicode
code --install-extension --force ms-vscode.cpptools
code --install-extension --force coenraads.bracket-pair-colorizer
code --install-extension --force compulim.compulim-vscode-closetag
code --install-extension --force batisteo.vscode-django
code --install-extension --force bibhasdn.django-html
code --install-extension --force donjayamanne.githistory
code --install-extension --force yzhang.markdown-all-in-one
code --install-extension --force davidanson.vscode-markdownlint
code --install-extension --force dongli.python-preview
code --install-extension --force lextudio.restructuredtext
code --install-extension --force gruntfuggly.todo-tree
code --install-extension --force vscodevim.vim
code --install-extension --force vscode-icons-team.vscode-icons
code --install-extension --force tomoki1207.pdf
code --install-extension --force dotjoshjohnson.xml

# TODO config JSON