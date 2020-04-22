#!/bin/bash

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt update -y
sudo apt install -y code
# sudo chown -R $(whoami) /usr/share/code

# Use --force to update? Seems it doesn't work.
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
code --install-extension bungcip.better-toml
code --install-extension grapecity.gc-excelviewer
code --install-extension ms-pyright.pyright


#############################################
# Add open folder in VS code in contextual menu
#############################################

cat <<EOT > ~/.local/share/nemo/actions/vscode.nemo_action
[Nemo Action]
Name=Ouvrir dans VS Code
Comment=Ouvrir dans VS Code
Exec=code %F
Icon-Name=visual-studio-code
Selection=Any
Extensions=dir;
EOT

#############################################
# Configure VS code
#############################################

# first install Python, to parse easily JSON
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
eval "$DIR/python.sh"

# create python script
cat <<EOT > config_vscode.py
import json
import re
from pathlib import Path

home = Path.home()
config_json = home / ".config/Code/User/settings.json"


def comment_remover(text):
    def replacer(match):
        s = match.group(0)
        if s.startswith("/"):
            return " "  # note: a space and not an empty string
        else:
            return s

    pattern = re.compile(
        r'//.*?$|/\*.*?\*/|\'(?:\\\\.|[^\\\\\\'])*\'|"(?:\\\\.|[^\\\\"])*"',
        re.DOTALL | re.MULTILINE,
    )
    return re.sub(pattern, replacer, text)


config = {}
try:
    with open(config_json, encoding="utf-8") as file:
        content = file.read()
        content = comment_remover(content)
        config = json.loads(content)
except FileNotFoundError:
    pass

config["breadcrumbs.enabled"] = True
config["diffEditor.ignoreTrimWhitespace"] = False
config["editor.cursorStyle"] = "line"
config["editor.formatOnSave"] = True
config["editor.formatOnPaste"] = True
config["files.watcherExclude"] = {
    "**/.tox/**": True,
    "**/venv/**": True,
    "**/build/**": True,
    "**/.git/objects/**": True,
    "**/.git/subtree-cache/**": True,
    "**/node_modules/*/**": True,
}
config["python.editor.formatOnPaste"] = False
config["python.pythonPath"] = "/usr/bin/python3.8"
config["python.linting.enabled"] = True
config["python.linting.flake8Enabled"] = True
config["python.linting.flake8Path"] = f"~/.local/bin/whatalinter"
config["python.formatting.provider"] = "black"
config["python.formatting.blackPath"] = "~/.local/bin/whataformatter"
config["python.formatting.blackArgs"] = []
# TODO supprimer ces deux lignes
config[
    "python.formatting.blackPath"
] = "~/.local/pipx/venvs/python-dev-tools/bin/black"
config["python.formatting.blackArgs"] = [
    "--line-length",
    "79",
    "--target-version=py36",
]
config["scm.defaultViewMode"] = "tree"
config["terminal.integrated.rendererType"] = "dom"
config["vim.incsearch"] = True
config["vim.useSystemClipboard"] = True
config["vim.hlsearch"] = True
config["vim.handleKeys"] = {"<C-a>": False, "<C-f>": False}
config["window.titleBarStyle"] = "custom"
config["workbench.colorTheme"] = "Visual Studio Dark"
config["workbench.iconTheme"] = "vscode-icons"

if config:
    with open(config_json, encoding="utf-8", mode="w") as file:
        json.dump(config, file, indent=4)
EOT

python3.8 config_vscode.py

