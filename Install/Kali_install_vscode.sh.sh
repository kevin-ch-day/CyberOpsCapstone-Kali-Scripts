#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name: install_vscode.sh
# Purpose:     Installs Visual Studio Code on Kali Linux.
# Author:      [Your Name]
# Date:        [Date]
# -----------------------------------------------------------------------------

# Function to print a section header
print_header() {
    echo "-------------------------------------------------------------"
    echo "$1"
    echo "-------------------------------------------------------------"
}

# Start of the script
print_header "Starting Visual Studio Code Installation"

# Update the package list
echo "Updating package list..."
sudo apt-get update -y

# Install necessary dependencies
echo "Installing dependencies..."
sudo apt-get install -y software-properties-common apt-transport-https wget

# Import the Microsoft GPG key
echo "Importing Microsoft GPG key..."
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -

# Enable the Visual Studio Code repository
echo "Enabling the Visual Studio Code repository..."
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# Update the package list again after adding the repository
echo "Updating package list after adding the repository..."
sudo apt-get update -y

# Install Visual Studio Code
echo "Installing Visual Studio Code..."
sudo apt-get install -y code

# Confirm installation
if command -v code &> /dev/null; then
    echo "Visual Studio Code has been installed successfully."
else
    echo "There was an issue installing Visual Studio Code."
fi

# End of the script
print_header "Visual Studio Code Installation Complete"
