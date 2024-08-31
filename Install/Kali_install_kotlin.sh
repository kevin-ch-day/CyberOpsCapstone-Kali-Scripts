#!/bin/bash

# -----------------------------------------------------------------------------
# Script Name: install_kotlin_dev_environment.sh
# Purpose:     Installs a complete Kotlin development environment on Kali Linux,
#              including OpenJDK, Snapd, Kotlin, IntelliJ IDEA, Gradle, and 
#              additional tools that are helpful for Kotlin development.
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

# -----------------------------------------------------------------------------
# Update and Install OpenJDK (Java Development Kit)
# -----------------------------------------------------------------------------
print_header "Installing OpenJDK"
sudo apt-get update -y
sudo apt-get install -y openjdk-11-jdk
handle_error

# -----------------------------------------------------------------------------
# Install Snapd (Snap Package Manager)
# -----------------------------------------------------------------------------
print_header "Installing Snapd"
sudo apt-get install -y snapd
handle_error

# Start and enable Snapd service
sudo systemctl start snapd
handle_error
sudo systemctl enable snapd
handle_error

# -----------------------------------------------------------------------------
# Install Kotlin via Snap
# -----------------------------------------------------------------------------
print_header "Installing Kotlin"
sudo snap install --classic kotlin
handle_error

# -----------------------------------------------------------------------------
# Install IntelliJ IDEA (Community Edition)
# -----------------------------------------------------------------------------
print_header "Installing IntelliJ IDEA (Community Edition)"
sudo snap install intellij-idea-community --classic
handle_error

# -----------------------------------------------------------------------------
# Install Gradle (Build Automation Tool)
# -----------------------------------------------------------------------------
print_header "Installing Gradle"
sudo apt-get install -y gradle
handle_error

# -----------------------------------------------------------------------------
# Install Additional Tools and Plugins for Kotlin Development
# -----------------------------------------------------------------------------
print_header "Installing Additional Tools and Plugins"

# Install Kotlin Plugin for IntelliJ IDEA (If not bundled with the IDE)
print_header "Installing Kotlin Plugin for IntelliJ IDEA"
# Start IntelliJ IDEA to install the Kotlin plugin from the JetBrains Marketplace
echo "Please start IntelliJ IDEA and install the Kotlin plugin from the JetBrains Marketplace if it's not already included."

# Install SDKMAN! for managing parallel versions of SDKs
print_header "Installing SDKMAN!"
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
handle_error

# Install Maven (Build Automation Tool)
print_header "Installing Maven"
sudo apt-get install -y maven
handle_error

# Install Git (Version Control)
print_header "Installing Git"
sudo apt-get install -y git
handle_error

# -----------------------------------------------------------------------------
# Optional: Stop Snapd Service
# -----------------------------------------------------------------------------
print_header "Stopping Snapd (Optional)"
sudo systemctl stop snapd
handle_error

echo "Kotlin development environment installation completed successfully."
echo "Please restart your terminal or source ~/.bashrc to apply SDKMAN! to your environment."
