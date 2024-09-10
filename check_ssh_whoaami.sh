#!/bin/bash
# Author:  Angel Roman
# GitHub: https://github.com/legna-namor

# Initialize variables
HOSTNAME=""
USERNAME=""

# Function to display usage information
usage() {
    echo "Usage: check_ssh_whoaami.sh -H <hostname> -U <username>"
    exit 3
}

# Parse command-line arguments
while getopts "H:U:" opt; do
    case $opt in
        H) HOSTNAME="$OPTARG" ;;
        U) USERNAME="$OPTARG" ;;
        *) usage ;;
    esac
done

# Check if both hostname and username are provided
if [[ -z "$HOSTNAME" || -z "$USERNAME" ]]; then
    usage
fi

# Check SSH connection and run whoami
output=$(ssh -i /usr/lib64/nagios/.ssh/id_rsa -o "StrictHostKeyChecking no" "$HOSTNAME" "whoami" 2>/dev/null)

# Check if the SSH connection was successful and whoami output is "$USERNAME"
if [ $? -eq 0 ] && [ "$output" = "$USERNAME" ]; then
    echo "OK - SSH connection to $HOSTNAME successful and user is $USERNAME."
    exit 0
else
    echo "CRITICAL - SSH connection to $HOSTNAME failed or user is not $USERNAME."
    exit 2
fi
