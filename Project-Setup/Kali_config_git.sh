#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name: configure_git.sh
# Purpose:     Installs and configures Git on Kali Linux.
# Author:      Kevin Day
# Date:        8/30/2024
# -----------------------------------------------------------------------------

# Function to print a section header
print_header() {
    echo "-------------------------------------------------------------"
    echo "$1"
    echo "-------------------------------------------------------------"
}

# Start of the script
print_header "Starting Git Installation and Configuration"

# Update package list
echo "Updating package list..."
sudo apt-get update -y

# Install Git if it's not installed
if ! command -v git &> /dev/null; then
    echo "Git not found. Installing Git..."
    sudo apt-get install -y git
else
    echo "Git is already installed."
fi

# Configure Git username
git_username="kevinday612-softwaredev"
git config --global user.name "$git_username"
echo "Git username set to $git_username"

# Configure Git email
git_email="kevinday612-softwaredev@outlook.com"
git config --global user.email "$git_email"
echo "Git email set to $git_email"

# Set default Git configurations
echo "Setting default Git configurations..."
git config --global core.editor "nano"
git config --global merge.tool "vimdiff"
git config --global pull.rebase false
git config --global color.ui true

# Display the configured settings
echo "Git has been configured with the following settings:"
git config --global --list

# End of the script
print_header "Git Installation and Configuration Complete"
