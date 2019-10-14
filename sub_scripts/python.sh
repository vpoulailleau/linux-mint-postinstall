#!/bin/bash

sudo apt install -y python3.7 python3.7-venv python3.7-dev python3-pip python3-venv python3-dev

sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update -y
sudo apt install -y python3.8 python3.8-venv python3.8-dev

# install pipx
python3.8 -m pip install --user --upgrade pipx
python3.8 -m pipx ensurepath

# install userpath
pipx install userpath
pipx upgrade userpath

# install python-dev-tools
pipx install python-dev-tools
pipx upgrade python-dev-tools
TOOLS_PATH=$(ls -l ~/.local/bin/whataformatter | sed -e "s/.*-> //" | sed -e "s#/bin.*#/bin#")
userpath prepend $TOOLS_PATH
