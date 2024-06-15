#!/bin/bash

# Make sure the script is being executed with superuser privileges.

if (( $EUID != 0 )); then
	echo "Please run as superuser: root"
	exit
fi

# If the user doesn’t supply at least one argument, then give them help.

if [ $# -le 0 ]; then
	echo "You have to provide at least one argument"
	exit
fi 

# The first parameter is the user name.

# The rest of the parameters are for the account comments.

# Generate a password.

#################  $ genpasswd

# Create the user with the password.

useradd -p $(openssl passwd -1 password) username

# Check to see if the useradd command succeeded.

if [ $? -eq 0 ]; then
        echo Succeeded
else
        echo Failed
fi

# Set the password.

passwd -e $1

# Check to see if the passwd command succeeded.

# Force password change on first login.

# Display the username, password, and the host where the user was created.

echo """User: $1
Password: $random_passwd
host: $(curl ifconfig.me)
"""
