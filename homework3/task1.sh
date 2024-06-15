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

username="${1}"

# The rest of the parameters are for the account comments.

comment="${@}"

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

if [[ $? -ne 0 ]]; then
        echo "Did not set a password"
        exit 1
fi

# Force password change on first login.

passwd -e ${username}  &> /dev/null

# Display the username, password, and the host where the user was created.

echo "Username: ${username}"
echo "Password: ${password}"
echo "Host: ${HOSTNAME}"
