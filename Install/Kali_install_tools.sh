#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name: Kali_tool_install.sh
# Purpose:     Installs essential tools and utilities that might be helpful 
#              for your project on Kali Linux, including Cinnamon, Git, Geany,
#              P7Zip, dex2jar, apktool, JD-GUI, Burp Suite, VirtualBox, 
#              Google Chrome, and Visual Studio Code.
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
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $message" | tee -a Kali_tool_install.log
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
# Update package lists and upgrade existing packages
# -----------------------------------------------------------------------------
print_header "Starting Tool Installation on Kali Linux"
log_message "Updating package lists and upgrading existing packages..."
sudo apt-get update -y && sudo apt-get upgrade -y | tee -a Kali_tool_install.log
handle_error

# -----------------------------------------------------------------------------
# Install Essential Tools
# -----------------------------------------------------------------------------
log_message "Installing essential tools..."

# Install Cinnamon Desktop Environment
log_message "Installing Cinnamon Desktop Environment..."
sudo apt-get install cinnamon-desktop-environment -y | tee -a Kali_tool_install.log
handle_error

# Install Git
log_message "Installing Git..."
sudo apt-get install git -y | tee -a Kali_tool_install.log
handle_error

# Install Geany (Text Editor)
log_message "Installing Geany..."
sudo apt-get install geany -y | tee -a Kali_tool_install.log
handle_error

# Install P7Zip (File Archiver)
log_message "Installing P7Zip (full and rar support)..."
sudo apt-get install p7zip-full p7zip-rar -y | tee -a Kali_tool_install.log
handle_error

# Install dex2jar
log_message "Installing dex2jar..."
sudo apt-get install dex2jar -y | tee -a Kali_tool_install.log
handle_error

# Install apktool
log_message "Installing apktool..."
sudo apt-get install apktool -y | tee -a Kali_tool_install.log
handle_error

# Install JD-GUI
log_message "Installing JD-GUI..."
sudo apt-get install jd-gui -y | tee -a Kali_tool_install.log
handle_error

# Install Burp Suite
log_message "Installing Burp Suite..."
sudo apt-get install burpsuite -y | tee -a Kali_tool_install.log
handle_error

# Install VirtualBox
log_message "Installing VirtualBox..."
sudo apt-get install virtualbox -y | tee -a Kali_tool_install.log
handle_error

# Install Google Chrome
log_message "Installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O google-chrome.deb | tee -a Kali_tool_install.log
sudo apt install ./google-chrome.deb -y | tee -a Kali_tool_install.log
rm google-chrome.deb
handle_error

# Install Visual Studio Code
log_message "Installing Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get install apt-transport-https -y | tee -a Kali_tool_install.log
sudo apt-get update -y | tee -a Kali_tool_install.log
sudo apt-get install code -y | tee -a Kali_tool_install.log
rm packages.microsoft.gpg
handle_error

# -----------------------------------------------------------------------------
# Clean up and finish
# -----------------------------------------------------------------------------
log_message "Cleaning up after installation..."
sudo apt-get autoremove -y && sudo apt-get autoclean -y | tee -a Kali_tool_install.log
handle_error

log_message "Tool installation completed successfully."
print_header "Installation Process Completed"
