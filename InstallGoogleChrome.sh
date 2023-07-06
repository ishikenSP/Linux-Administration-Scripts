#!/bin/bash

##############################################
####### Install Google Chrome on Linux #######
#######      By: Kendall Cabrera       #######
##############################################

# Check if the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

# Determine the Linux distribution and package manager
distro=""
package_manager=""

if command -v apt-get &> /dev/null; then
    distro="Debian/Ubuntu"
    package_manager="apt-get"
elif command -v yum &> /dev/null; then
    distro="Red Hat/CentOS"
    package_manager="yum"
elif command -v dnf &> /dev/null; then
    distro="Fedora"
    package_manager="dnf"
else
    echo "Unsupported Linux distribution. Please install Google Chrome manually."
    exit 1
fi

# Install Google Chrome based on the package manager
case "$distro" in
    "Debian/Ubuntu")
        $package_manager update -y
        $package_manager install -y wget gpg
        wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
        echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
        $package_manager update -y
        $package_manager install -y google-chrome-stable
        ;;
    "Red Hat/CentOS"|"Fedora")
        $package_manager install -y wget
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
        $package_manager localinstall -y google-chrome-stable_current_x86_64.rpm
        rm google-chrome-stable_current_x86_64.rpm
        ;;
    *)
        echo "Unsupported Linux distribution. Please install Google Chrome manually."
        exit 1
        ;;
esac

# Display a confirmation message
echo "Google Chrome has been installed."
