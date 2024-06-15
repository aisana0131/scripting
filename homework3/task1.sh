#!/bin/bash

# Make sure the script is being executed with superuser privileges.
if [[ "${PID}" -ne 0 ]]; then
	echo "Please run as a root or with superuser privileges"
	exit
fi



# The first parameter is the user name.
username="${1}"


# The rest of the parameters are for the account comments.
comment="${@}"

# Generate a password.
password="$(date +%s%N | sha256sum | head -c36)" &> /dev/null

# If the user doesn’t supply at least one argument, then give them help.
while [ $# = 0 ]; do
        read -p "Provide username: " username
        read -p "Add a comment: " comment
	break
done


# Create the user with the password.
useradd -m  ${username} -c "${comment}"

# Check to see if the useradd command succeeded.
if [[ $? -ne 0 ]]; then
	echo "Could not add the user, sorry"
	exit 1
fi

# Set the password.

echo ${password} | passwd --stdin ${username} &> /dev/null

# Check to see if the passwd command succeeded.
if [[ $? -ne 0 ]]; then
        echo "Could not set the password, sorry"
        exit 1
fi
# Force password change on first login.
passwd -e ${username}  &> /dev/null

# Display the username, password, and the host where the user was created.
echo 
echo "Username: ${username}"
echo "Password: ${password}"
echo "Host: ${HOSTNAME}"
echo
