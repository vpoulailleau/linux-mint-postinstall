#!/bin/bash

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt update -y
sudo apt install -y code
# sudo chown -R $(whoami) /usr/share/code
code --install-extension ms-python.python
code --install-extension visualstudioexptteam.vscodeintellicode
code --install-extension ms-vscode.cpptools
code --install-extension coenraads.bracket-pair-colorizer
code --install-extension compulim.compulim-vscode-closetag
code --install-extension batisteo.vscode-django
code --install-extension bibhasdn.django-html
code --install-extension donjayamanne.githistory
code --install-extension yzhang.markdown-all-in-one
code --install-extension davidanson.vscode-markdownlint
code --install-extension dongli.python-preview
code --install-extension lextudio.restructuredtext
code --install-extension gruntfuggly.todo-tree
code --install-extension vscodevim.vim
code --install-extension vscode-icons-team.vscode-icons
code --install-extension tomoki1207.pdf
code --install-extension dotjoshjohnson.xml