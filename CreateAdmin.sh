#!/bin/bash

#############################################
########     Create Admin Account    ########
#######      By: Kendall Cabrera      #######
#############################################

# Define the username and password for the new admin account
username="adminuser"
password="adminpassword"

# Create the new admin account
sudo useradd -m -s /bin/bash "$username"

# Set the password for the new admin account
echo "$username:$password" | sudo chpasswd

# Add the new admin account to the admin group
sudo usermod -aG sudo "$username"

# Display a confirmation message
echo "Admin account '$username' has been created and added to the admin group."