#!/bin/bash

##############################################
#######    Check For All Admin Users   #######
#######      By: Kendall Cabrera       #######
##############################################

# Check if the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

# Define the admin group name
admin_group="sudo"  # Modify this if your system uses a different admin group name

# Get a list of all users belonging to the admin group
admin_users=$(getent group "$admin_group" | cut -d: -f4)

# Check if there are any admin users
if [[ -z "$admin_users" ]]; then
    echo "No admin accounts found."
else
    echo "Admin accounts:"
    echo "$admin_users"
fi
