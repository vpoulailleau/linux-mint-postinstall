#!/bin/bash

########################################
# General
########################################
sudo apt update -y
sudo apt upgrade -y

sudo apt install -y software-properties-common build-essential checkinstall wget curl git libssl-dev gcc automake gpg
sudo apt install -y gthumb
sudo apt install -y synaptic
sudo apt install -y ubuntu-restricted-extras libavcodec-extra vlc vlc-data browser-plugin-vlc

########################################
# git config
########################################


########################################
# Python
########################################
sudo apt install -y python3.7 python3.7-venv python3-pip

sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update -y
sudo apt install -y python3.8 python3.8-venv

########################################
# Firefox
########################################

########################################
# Virtual Box
########################################

########################################
# VS Code
########################################
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt update -y
sudo apt install -y code
# sudo chown -R $(whoami) /usr/share/code
code --install-extension ms-python.python

########################################
# end
########################################
sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y
