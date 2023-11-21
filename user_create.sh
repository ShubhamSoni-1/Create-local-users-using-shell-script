#!/bin/bash
#Version- 1.0
#date- 19 Nov 2023

#Script should be executed with sudo/root access
if [[ "${UID}" -ne 0 ]]
then 
	echo "Please run the script with sudo or root user"
	exit 1
fi

#User should provide at least one argument as username else guide the admin
if [[ "${#}" -lt 1 ]]
then
	echo "Usage: ${0} USER_NAME [COMMENT]…"
	echo "Create a user with name USER_NAME and comments field of COMMENT "
	exit 1
fi
#Store the 1st argument as user name
USER_NAME="${1}"
#echo $USER_NAME

#In case of more than one argument, store it as account comments
shift
COMMENT="${@}"
#echo $COMMENT

#create a password
PASSWORD=$(date +%s%N)
#echo PASSWORD

#Create the user
useradd -c "${COMMENT}" -m $USER_NAME

# Check if the user is successfully created or not
if [[ $? -ne 0 ]]
then 
	echo "The Account could not be created"
	exit 1
fi

#Set the password for the user
echo -e "$PASSWORD\n$PASSWORD" |passwd "$USER_NAME"

#Check if password is successfully created or not
if [[ $? -ne 0 ]]
then 
	echo "Password could not be set"
	exit 1
fi


#Force password change on its first login
passwd -e $USER_NAME


# Display the username, password and host where the user is created.
echo
echo "Username: $USER_NAME"
echo
echo "Password: $PASSWORD"
echo
echo "Hostname: $(hostname)"


