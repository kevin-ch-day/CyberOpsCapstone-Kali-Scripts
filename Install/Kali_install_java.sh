#!/bin/bash

# -----------------------------------------------------------------------------
# Script Name: install_java.sh
# Purpose:     Installs Java Runtime Environment (JRE) and Java Development Kit (JDK)
#              on a Linux system, including updating the package lists and 
#              providing feedback during the installation process.
# Author:      Kevin Day
# Date:        8/30/2024
# -----------------------------------------------------------------------------

# Function to print a section header
print_header() {
    echo "-------------------------------------------------------------"
    echo "$1"
    echo "-------------------------------------------------------------"
}

# Function to handle errors
handle_error() {
    local exit_code="$?"
    if [ "$exit_code" -ne 0 ]; then
        echo "Error: Command failed with exit code $exit_code"
        exit "$exit_code"
    fi
}

# Function to log messages
log_message() {
    local message="$1"
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $message" | tee -a install_java.log
}

# -----------------------------------------------------------------------------
# Update Package Lists
# -----------------------------------------------------------------------------
print_header "Updating Package Lists"
log_message "Updating package lists..."
sudo apt-get update -y | tee -a install_java.log
handle_error

# -----------------------------------------------------------------------------
# Install Java Runtime Environment (JRE)
# -----------------------------------------------------------------------------
print_header "Installing Java Runtime Environment (JRE)"
log_message "Installing default-jre..."
sudo apt-get install -y default-jre | tee -a install_java.log
handle_error

# -----------------------------------------------------------------------------
# Install Java Development Kit (JDK)
# -----------------------------------------------------------------------------
print_header "Installing Java Development Kit (JDK)"
log_message "Installing default-jdk..."
sudo apt-get install -y default-jdk | tee -a install_java.log
handle_error

# -----------------------------------------------------------------------------
# Verify Installation
# -----------------------------------------------------------------------------
print_header "Verifying Java Installation"
log_message "Checking Java version..."

java_version=$(java -version 2>&1 | head -n 1)
if [[ $java_version == *"openjdk"* ]]; then
    log_message "Java installed successfully. Version: $java_version"
else
    log_message "Java installation failed or not found."
    exit 1
fi

log_message "Java installation completed successfully."
print_header "Java Installation Process Completed"
