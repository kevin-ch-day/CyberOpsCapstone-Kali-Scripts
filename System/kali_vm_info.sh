#!/bin/bash
# -----------------------------------------------------------------------------
# Script Name: kali_vm_info.sh
# Purpose:     Collects and displays hardware and software configuration details
#              of the Kali Linux virtual machine for malware analysis purposes.
# Author:      Kevin Day
# Date:        8/30/2024
# -----------------------------------------------------------------------------

# Function to print a section header
print_header() {
    echo "-------------------------------------------------------------"
    echo "$1"
    echo "-------------------------------------------------------------"
}

# Function to print a subsection header
print_subheader() {
    echo ""
    echo "$1:"
}

# -----------------------------------------------------------------------------
# Collect and display Operating System information
# -----------------------------------------------------------------------------
print_header "Kali Linux VM Configuration Report"

print_subheader "Operating System"
grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2 | tr -d '"'

# -----------------------------------------------------------------------------
# Collect and display System Type (Architecture) information
# -----------------------------------------------------------------------------
print_subheader "System Type"
uname -m

# -----------------------------------------------------------------------------
# Collect and display Processor details
# -----------------------------------------------------------------------------
print_subheader "Processor"
echo -n "Model: "
lscpu | grep 'Model name:' | awk -F: '{print $2}' | xargs

echo -n "Cores/Threads: "
lscpu | grep '^CPU(s):' | awk '{print $2}'

# -----------------------------------------------------------------------------
# Collect and display current CPU utilization
# -----------------------------------------------------------------------------
print_subheader "Current CPU Utilization"
mpstat | awk '$3 ~ /[0-9.]+/ {print 100 - $13"% used"}'

# -----------------------------------------------------------------------------
# Collect and display RAM information
# -----------------------------------------------------------------------------
print_subheader "RAM"
echo -n "Total Memory: "
free -h --si | awk '/^Mem:/ {print $2}'

echo -n "Used Memory: "
free -h --si | awk '/^Mem:/ {print $3 " used out of " $2}'

# -----------------------------------------------------------------------------
# Collect and display Storage information
# -----------------------------------------------------------------------------
print_subheader "Storage"
echo -n "Total Storage: "
df -h --total | grep 'total' | awk '{print $2}'

# -----------------------------------------------------------------------------
# Collect and display network interfaces and IP addresses
# -----------------------------------------------------------------------------
print_subheader "Network Interfaces"
ip -o -4 addr show | awk '{print $2 ": " $4}'

# -----------------------------------------------------------------------------
# Check if Oracle VirtualBox is installed
# -----------------------------------------------------------------------------
print_subheader "Virtualization Platform"
if command -v vboxmanage &> /dev/null; then
    echo "Oracle VirtualBox is installed"
else
    echo "Oracle VirtualBox is not installed or the command 'vboxmanage' is not in the PATH."
fi

# -----------------------------------------------------------------------------
# End of Script
# -----------------------------------------------------------------------------
echo ""
echo "Configuration report generated successfully."
echo "-------------------------------------------------------------"
