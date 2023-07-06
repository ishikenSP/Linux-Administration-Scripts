#!/bin/bash

#############################################
#######  InTune App Install - Ubuntu  #######
#######      By: Kendall Cabrera      #######
#############################################

# Check if the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

# Update Repositories
apt update && apt dist-upgrade -y

# Install dependencies
apt install curl gpg

# Get Ubuntu Version
# Read the version information from the /etc/os-release file
source /etc/os-release

# Extract the Ubuntu version
ubuntu_version=${VERSION_ID}

# Define the supported Ubuntu versions
supported_versions=("20.04" "22.04")

# Install package signing key
if [[ " ${supported_versions[@]} " =~ " ${ubuntu_version} " ]]; then
    echo "The Ubuntu version is ${ubuntu_version}."

    # Ubuntu 20.04
    if [[ ${ubuntu_version} == "20.04" ]]; then
        curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
        install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/
        sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/20.04/prod focal main" > /etc/apt/sources.list.d/microsoft-ubuntu-focal-prod.list'
        rm microsoft.gpg
    else
    # Ubuntu 22.04
        curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
        sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/
        sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/ubuntu/22.04/prod jammy main" > /etc/apt/sources.list.d/microsoft-ubuntu-jammy-prod.list'
        sudo rm microsoft.gpg
    fi
else
    echo "This Ubuntu version is not supported."
fi

# Install The Microsoft Intune App
apt install intune-portal

# Reboot System
shutdown -r +2
echo "The system will reboot in two (2) minutes. Please save any open work immediately."