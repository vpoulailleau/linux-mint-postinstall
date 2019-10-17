#!/bin/bash

echo "deb https://download.scenari.org/deb bionic main" | sudo tee /etc/apt/sources.list.d/scenari.list
sudo apt update
sudo apt install -y opale3.6.fr-fr texlive texlive-latex-extra dvipng
