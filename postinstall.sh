#!/bin/bash

########################################
# General
########################################
sudo apt update -y
sudo apt upgrade -y
sudo apt install -y --fix-broken

sudo apt install -y software-properties-common checkinstall wget curl gpg
sudo apt install -y build-essential libssl-dev gcc automake screen zlib1g-dev libjpeg-dev
sudo apt install -y filezilla
sudo apt install -y synaptic
sudo apt install -y xvfb
sudo apt install -y gwenview

########################################
# Execute sub scripts
########################################
chmod u+x sub_scripts/*.sh
for SCRIPT in sub_scripts/*.sh
do
    echo ""
    echo "###########################################"
    echo "#   $SCRIPT"
    echo "###########################################"
    echo ""
    PROGRAM_NAME=`basename $SCRIPT`
    PROGRAM_NAME=${PROGRAM_NAME%.*}
    read -p "Do you want to install ${PROGRAM_NAME}? " choice
    case "$choice" in 
        [yY][eE][sS]|[yY] )
            eval $SCRIPT
            ;;
        [nN][oO]|[nN] )
            echo "skip installation of ${PROGRAM_NAME}"
            ;;
        * ) 
            echo "invalid answer"
            ;;
    esac
done

########################################
# end
########################################
sudo apt update -y
sudo apt upgrade -y
sudo apt autoremove -y
