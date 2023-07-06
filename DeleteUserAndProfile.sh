#!/bin/bash

#############################################
#######  Delete User ACC and Profile  #######
#######      By: Kendall Cabrera      #######
#############################################

# Check if the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

# List user accounts
echo "User accounts:"
awk -F':' '{ if ( $3 >= 1000 ) print $1 }' /etc/passwd

# Prompt for the username to remove
read -p "Enter the username to remove: " username

# Check if the user exists
if ! id -u "$username" &>/dev/null; then
    echo "User $username does not exist."
    exit 1
fi

# Prompt for confirmation before removing the user
read -p "Are you sure you want to remove user $username and delete their home folder? (y/n): " choice

# Check the user's response
if [[ $choice == "y" || $choice == "Y" ]]; then
    # Remove the user account and home folder
    userdel -r "$username"
    echo "User $username has been removed."
else
    echo "Operation cancelled."
    exit 0
fi
