#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name: Kali_update_upgrade.sh
# Purpose:     Updates and upgrades the Kali Linux VM to ensure all packages 
#              and the system are up-to-date, with added functionalities for 
#              error handling, logging, and optional reboot.
# Author:      Kevin Day
# Date:        8/30/2024
# -----------------------------------------------------------------------------

# Function to print a section header
print_header() {
    echo "-------------------------------------------------------------"
    echo "$1"
    echo "-------------------------------------------------------------"
}

# Function to log and display messages
log_message() {
    local message="$1"
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $message" | tee -a update_upgrade_kali.log
}

# Function to handle errors
handle_error() {
    local exit_code="$?"
    if [ "$exit_code" -ne 0 ]; then
        log_message "Error: Command failed with exit code $exit_code"
        exit "$exit_code"
    fi
}

# -----------------------------------------------------------------------------
# Update and Upgrade Kali Linux
# -----------------------------------------------------------------------------
print_header "Starting Kali Linux Update and Upgrade Process"
log_message "Starting the update and upgrade process."

# Step 1: Update the package list
log_message "Updating package list..."
sudo apt-get update -y | tee -a update_upgrade_kali.log
handle_error

# Step 2: Upgrade all installed packages
log_message "Upgrading installed packages..."
sudo apt-get upgrade -y | tee -a update_upgrade_kali.log
handle_error

# Step 3: Perform a full distribution upgrade (recommended for Kali Linux)
log_message "Performing full distribution upgrade..."
sudo apt-get dist-upgrade -y | tee -a update_upgrade_kali.log
handle_error

# Step 4: Remove unnecessary packages and dependencies
log_message "Cleaning up unnecessary packages..."
sudo apt-get autoremove -y | tee -a update_upgrade_kali.log
handle_error

log_message "Cleaning up cached packages..."
sudo apt-get autoclean -y | tee -a update_upgrade_kali.log
handle_error

# Step 5: Verify and fix broken dependencies (optional)
log_message "Fixing any broken dependencies..."
sudo apt-get -f install | tee -a update_upgrade_kali.log
handle_error

# Step 6: Optional Reboot Prompt
log_message "Update and upgrade process completed successfully."
read -p "Do you want to reboot the system now? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    log_message "Rebooting the system..."
    sudo reboot
else
    log_message "Reboot skipped. Please reboot manually if needed."
fi

# -----------------------------------------------------------------------------
# End of Script
# -----------------------------------------------------------------------------
log_message "Script execution finished."
print_header "Update and upgrade process completed."
