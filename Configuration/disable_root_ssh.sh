#!/bin/bash

# -----------------------------------------------------------------------------
# Script Name: disable_root_ssh.sh
# Purpose:     Disables root login via SSH on Kali Linux.
# -----------------------------------------------------------------------------

# Function to print a section header
print_header() {
    echo "-------------------------------------------------------------"
    echo "$1"
    echo "-------------------------------------------------------------"
}

# Start of the script
print_header "Disabling Root Login via SSH"

# Backup the current SSH configuration file
SSH_CONFIG="/etc/ssh/sshd_config"
BACKUP_SSH_CONFIG="/etc/ssh/sshd_config.bak"

echo "Backing up current SSH configuration file..."
sudo cp $SSH_CONFIG $BACKUP_SSH_CONFIG

# Disable root login by modifying the SSH configuration
echo "Disabling root login in SSH configuration..."
sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' $SSH_CONFIG

# Restart the SSH service to apply changes
echo "Restarting SSH service..."
sudo systemctl restart ssh

# Confirm the change
if sudo grep -q "^PermitRootLogin no" $SSH_CONFIG; then
    echo "Root login via SSH has been disabled successfully."
else
    echo "There was an issue disabling root login via SSH."
fi

# End of the script
print_header "Root Login via SSH Disabled"
