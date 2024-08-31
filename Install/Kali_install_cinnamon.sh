#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name: install_cinnamon.sh
# Purpose:     Installs the Cinnamon desktop environment on Kali Linux.
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
print_header "Starting Cinnamon Desktop Environment Installation"

# Update the package list
echo "Updating package list..."
sudo apt-get update -y

# Install Cinnamon Desktop Environment
echo "Installing Cinnamon Desktop Environment..."
sudo apt-get install -y cinnamon-desktop-environment

# Install additional Cinnamon packages (optional, but recommended)
echo "Installing additional Cinnamon packages..."
sudo apt-get install -y cinnamon-core lightdm slick-greeter

# Optionally set LightDM as the default display manager (if prompted, choose LightDM)
echo "Configuring LightDM as the default display manager..."
sudo dpkg-reconfigure lightdm

# Confirm installation
if dpkg -l | grep -q cinnamon; then
    echo "Cinnamon Desktop Environment has been installed successfully."
else
    echo "There was an issue installing Cinnamon Desktop Environment."
fi

# End of the script
print_header "Cinnamon Desktop Environment Installation Complete"
