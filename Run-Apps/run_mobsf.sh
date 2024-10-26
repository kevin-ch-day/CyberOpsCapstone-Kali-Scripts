#!/bin/bash

# -----------------------------------------------------------------------------
# Script Name: run_mobsf.sh
# Purpose:     Runs the Mobile Security Framework (MobSF) and ensures it is
#              started successfully.
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
# Run MobSF
# -----------------------------------------------------------------------------
print_header "Starting MobSF..."

# Navigate to the MobSF directory
cd ~/Mobile-Security-Framework-MobSF || { echo "MobSF directory not found!"; exit 1; }

# Start MobSF
./run.sh
