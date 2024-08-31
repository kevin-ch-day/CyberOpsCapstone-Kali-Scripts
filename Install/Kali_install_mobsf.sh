#!/bin/bash

# -----------------------------------------------------------------------------
# Script Name: Kali_install_mobsf.sh
# Purpose:     Installs the Mobile Security Framework (MobSF) along with all
#              necessary dependencies on Kali Linux.
# Author:      Kevin Day
# Date:        8/30/2024
# -----------------------------------------------------------------------------

# Function to print a section header
print_header() {
    echo "-------------------------------------------------------------"
    echo "$1"
    echo "-------------------------------------------------------------"
}

# -----------------------------------------------------------------------------
# Update Package Lists and Install Java (JRE & JDK)
# -----------------------------------------------------------------------------
print_header "Updating package lists and installing Java JRE & JDK..."
sudo apt update -y
sudo apt install -y default-jre default-jdk
handle_error() {
    local exit_code="$?"
    if [ "$exit_code" -ne 0 ]; then
        echo "Error: Command failed with exit code $exit_code"
        exit "$exit_code"
    fi
}

# -----------------------------------------------------------------------------
# Install Required Dependencies for MobSF
# -----------------------------------------------------------------------------
print_header "Installing required dependencies..."
sudo apt install -y python3-dev python3-venv python3-pip build-essential
sudo apt install -y libffi-dev libssl-dev libxml2-dev libxslt1-dev
sudo apt install -y libjpeg62-turbo-dev zlib1g-dev wkhtmltopdf
handle_error

# -----------------------------------------------------------------------------
# Clone MobSF Repository
# -----------------------------------------------------------------------------
print_header "Cloning the MobSF repository from GitHub..."
git clone https://github.com/MobSF/Mobile-Security-Framework-MobSF.git
handle_error

# -----------------------------------------------------------------------------
# Set Up MobSF
# -----------------------------------------------------------------------------
print_header "Setting up MobSF..."
cd Mobile-Security-Framework-MobSF
./setup.sh
handle_error
