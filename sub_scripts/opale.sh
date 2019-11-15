#!/bin/bash

UBUNTU_VERSION=`cat /etc/os-release | grep UBUNTU_CODENAME`
UBUNTU_VERSION=${UBUNTU_VERSION#*=}

echo "deb https://download.scenari.org/deb ${UBUNTU_VERSION} main" | sudo tee /etc/apt/sources.list.d/scenari.list
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com C1B92A9981DBBE62
sudo apt update
sudo apt install -y opale3.7.fr-fr texlive texlive-latex-extra dvipng
