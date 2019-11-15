#!/bin/bash

sudo apt install -y python3.7 python3.7-venv python3.7-dev python3-pip python3-venv python3-dev

sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update -y
sudo apt install -y python3.8 python3.8-venv python3.8-dev

# install pipx
python3.8 -m pip install --user --upgrade pipx
python3.8 -m pipx ensurepath --force
export PATH=$PATH:~/.local/bin

# install userpath
pipx install userpath
pipx upgrade userpath

# install python-dev-tools
pipx install python-dev-tools
pipx upgrade python-dev-tools
TOOLS_PATH=$(ls -l ~/.local/bin/whataformatter | sed -e "s/.*-> //" | sed -e "s#/bin.*#/bin#")
userpath prepend $TOOLS_PATH

# install poetry
curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python3.7  # not yet python3.8 https://github.com/sdispater/poetry/pull/1437
source $HOME/.poetry/env
poetry completions bash | sudo tee /etc/bash_completion.d/poetry.bash-completion