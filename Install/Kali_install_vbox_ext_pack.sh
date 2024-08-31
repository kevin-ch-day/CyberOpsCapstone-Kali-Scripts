#!/bin/bash

# -----------------------------------------------------------------------------
# Script Name: Kali_install_vbox_ext_pack.sh
# Purpose:     Installs the VirtualBox Extension Pack on a Debian-based system (e.g., Kali Linux).
# Author:      Kevin Day
# Date:        8/30/2024
# -----------------------------------------------------------------------------

# Function to check if a command was successful and handle errors
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error: $1 failed to execute properly. Exiting."
        exit 1
    fi
}

# Function to install the VirtualBox Extension Pack
install_extension_pack() {
    echo "Installing VirtualBox Extension Pack..."
    sudo apt-get install -y virtualbox-ext-pack
    check_success "VirtualBox Extension Pack installation"
}

# Function to verify the installation
verify_installation() {
    echo "Verifying VirtualBox Extension Pack installation..."
    if VBoxManage list extpacks | grep -q "Oracle VM VirtualBox Extension Pack"; then
        echo "VirtualBox Extension Pack installed successfully."
    else
        echo "VirtualBox Extension Pack is not installed. Please check the installation logs."
        exit 1
    fi
}

# Main script execution
echo "Starting installation of the VirtualBox Extension Pack..."

install_extension_pack
verify_installation

echo "Installation of the VirtualBox Extension Pack completed successfully."
