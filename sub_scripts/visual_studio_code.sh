#!/bin/bash

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


#############################################
# Configure VS code
#############################################

# first install Python, to parse easily JSON
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
eval "$DIR/python.sh"

# create python script
cat <<EOT >> config_vscode.py
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
        r'//.*?$|/\*.*?\*/|\'(?:\\.|[^\\\'])*\'|"(?:\\.|[^\\"])*"',
        re.DOTALL | re.MULTILINE,
    )
    return re.sub(pattern, replacer, text)


config = None
with open(config_json, encoding="utf-8") as file:
    content = file.read()
    content = comment_remover(content)
    config = json.loads(content)
    config["breadcrumbs.enabled"] = True
    config["diffEditor.ignoreTrimWhitespace"] = False
    config["editor.cursorStyle"] = "line"
    config["editor.formatOnSave"] = True
    config["editor.formatOnPaste"] = True
    config["files.watcherExclude"] = {
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
    config["terminal.integrated.rendererType"] = "dom"
    config["vim.incsearch"] = True
    config["vim.useSystemClipboard"] = True
    config["vim.hlsearch"] = True
    config["vim.handleKeys"] = {"<C-a>": False, "<C-f>": False}
    config["workbench.colorTheme"] = "Visual Studio Dark"

if config:
    with open(config_json, encoding="utf-8", mode="w") as file:
        json.dump(config, file, indent=4)
EOT

python3.8 config_vscode.py
