#!/bin/bash

# -----------------------------------------------------------------------------
# Script Name: system_health_check.sh
# Purpose:     Periodically checks the health of the system by monitoring disk 
#              usage, memory usage, CPU load, running processes, network activity,
#              and system temperature. It logs the data and generates summary reports.
# Last Updated Dated:   [Date]
# Version:              1.0
# -----------------------------------------------------------------------------

# =========================
# Configuration Parameters
# =========================

# Thresholds (can be modified as needed)
DISK_USAGE_THRESHOLD=80    # in percentage
MEMORY_USAGE_THRESHOLD=80  # in percentage
CPU_LOAD_THRESHOLD=5       # 1-minute load average
TEMP_THRESHOLD=75          # in Celsius (if sensors are available)

# Log file locations
LOG_DIR="/var/log/system_health"
DISK_LOG="$LOG_DIR/disk_usage.log"
MEMORY_LOG="$LOG_DIR/memory_usage.log"
CPU_LOG="$LOG_DIR/cpu_load.log"
PROCESS_LOG="$LOG_DIR/top_processes.log"
NETWORK_LOG="$LOG_DIR/network_activity.log"
TEMP_LOG="$LOG_DIR/system_temperature.log"

# Report generation
REPORT_DIR="/var/report/system_health"
DAILY_REPORT="$REPORT_DIR/daily_report_$(date +%F).txt"

# =========================
# Function Definitions
# =========================

# Function to print a section header
print_header() {
    echo "============================================================="
    echo "$1"
    echo "============================================================="
}

# Function to initialize directories and logs
initialize() {
    mkdir -p "$LOG_DIR"
    mkdir -p "$REPORT_DIR"

    # Initialize log files with headers if they don't exist
    [[ ! -f "$DISK_LOG" ]] && echo "Timestamp,Filesystem,Size,Used,Avail,Use%" >> "$DISK_LOG"
    [[ ! -f "$MEMORY_LOG" ]] && echo "Timestamp,Total,Used,Free,Shared,Buffers,Cached" >> "$MEMORY_LOG"
    [[ ! -f "$CPU_LOG" ]] && echo "Timestamp,Load_1min,Load_5min,Load_15min" >> "$CPU_LOG"
    [[ ! -f "$PROCESS_LOG" ]] && echo "Timestamp,Process_Name,CPU_Usage,Memory_Usage" >> "$PROCESS_LOG"
    [[ ! -f "$NETWORK_LOG" ]] && echo "Timestamp,Active_Connections" >> "$NETWORK_LOG"
    [[ ! -f "$TEMP_LOG" ]] && echo "Timestamp,CPU_Temp" >> "$TEMP_LOG"
}

# Function to check disk usage
check_disk_usage() {
    local TIMESTAMP
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    df -h --output=source,size,used,avail,pcent | tail -n +2 | while read -r FS SIZE USED AVAIL PERCENT; do
        echo "$TIMESTAMP,$FS,$SIZE,$USED,$AVAIL,$PERCENT" >> "$DISK_LOG"
        # Extract numeric value from PERCENT
        USAGE=${PERCENT%\%}
        if [ "$USAGE" -ge "$DISK_USAGE_THRESHOLD" ]; then
            echo "Warning: Disk usage exceeds $DISK_USAGE_THRESHOLD% on $FS ($PERCENT used)"
        fi
    done
}

# Function to check memory usage
check_memory_usage() {
    local TIMESTAMP
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    # Using free with --si for consistent units
    read -r _ TOTAL USED FREE SHARED BUFFERS CACHED <<< $(free -h --si | awk '/^Mem:/ {print $1, $2, $3, $4, $5, $6, $7}')
    echo "$TIMESTAMP,$TOTAL,$USED,$FREE,$SHARED,$BUFFERS,$CACHED" >> "$MEMORY_LOG"
    
    # Calculate memory usage percentage
    USED_PERCENT=$(echo "scale=2; ($USED/$TOTAL)*100" | bc)
    if (( $(echo "$USED_PERCENT >= $MEMORY_USAGE_THRESHOLD" | bc -l) )); then
        echo "Warning: Memory usage exceeds $MEMORY_USAGE_THRESHOLD% ($USED_PERCENT% used)"
    fi
}

# Function to check CPU load
check_cpu_load() {
    local TIMESTAMP LOAD1 LOAD5 LOAD15
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    read -r LOAD1 LOAD5 LOAD15 <<< $(uptime | awk -F'load average: ' '{print $2}' | tr ',' ' ')
    echo "$TIMESTAMP,$LOAD1,$LOAD5,$LOAD15" >> "$CPU_LOG"
    
    # Check 1-minute load average against threshold
    LOAD_INT=${LOAD1%.*}
    if [ "$LOAD_INT" -ge "$CPU_LOAD_THRESHOLD" ]; then
        echo "Warning: 1-minute load average exceeds $CPU_LOAD_THRESHOLD (Current: $LOAD1)"
    fi
}

# Function to list top processes
list_top_processes() {
    local TIMESTAMP
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    # Top 5 by CPU
    ps aux --sort=-%cpu | awk 'NR<=5 {print $11","$3","$4}' | while IFS=, read -r PROC CPU MEM; do
        echo "$TIMESTAMP,$PROC,$CPU,$MEM" >> "$PROCESS_LOG"
    done
    # Top 5 by Memory can be added similarly if needed
}

# Function to check network activity
check_network_activity() {
    local TIMESTAMP ACTIVE_CONN
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
    ACTIVE_CONN=$(ss -tun | grep -v State | wc -l)
    echo "$TIMESTAMP,$ACTIVE_CONN" >> "$NETWORK_LOG"
    # Example alert: if active connections exceed a threshold
    CONNECTION_THRESHOLD=100
    if [ "$ACTIVE_CONN" -ge "$CONNECTION_THRESHOLD" ]; then
        echo "Warning: Active network connections exceed $CONNECTION_THRESHOLD (Current: $ACTIVE_CONN)"
    fi
}

# Function to check system temperature
check_system_temperature() {
    if command -v sensors &> /dev/null; then
        local TIMESTAMP CPU_TEMP
        TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
        CPU_TEMP=$(sensors | awk '/^Core 0/ {print $3}' | tr -d '+°C')
        echo "$TIMESTAMP,$CPU_TEMP" >> "$TEMP_LOG"
        if [ "$CPU_TEMP" -ge "$TEMP_THRESHOLD" ]; then
            echo "Warning: CPU temperature exceeds $TEMP_THRESHOLD°C (Current: ${CPU_TEMP}°C)"
        fi
    fi
}

# Function to generate a daily report
generate_daily_report() {
    print_header "Generating System Health Report"
    {
        echo "System Health Report for $HOSTNAME"
        echo "Generated on: $(date)"
        echo ""
        
        echo "Disk Usage (Last 24 Hours):"
        awk -F, -v date="$(date -d '1 day ago' '+%Y-%m-%d')" '$1 >= date {print $0}' "$DISK_LOG"
        echo ""
        
        echo "Memory Usage (Last 24 Hours):"
        awk -F, -v date="$(date -d '1 day ago' '+%Y-%m-%d')" '$1 >= date {print $0}' "$MEMORY_LOG"
        echo ""
        
        echo "CPU Load (Last 24 Hours):"
        awk -F, -v date="$(date -d '1 day ago' '+%Y-%m-%d')" '$1 >= date {print $0}' "$CPU_LOG"
        echo ""
        
        echo "Top Processes (Last Check):"
        tail -n 5 "$PROCESS_LOG"
        echo ""
        
        echo "Network Activity (Last 24 Hours):"
        awk -F, -v date="$(date -d '1 day ago' '+%Y-%m-%d')" '$1 >= date {print $0}' "$NETWORK_LOG"
        echo ""
        
        if [ -f "$TEMP_LOG" ]; then
            echo "System Temperature (Last 24 Hours):"
            awk -F, -v date="$(date -d '1 day ago' '+%Y-%m-%d')" '$1 >= date {print $0}' "$TEMP_LOG"
            echo ""
        fi
    } > "$DAILY_REPORT"
    
    echo "Report saved to $DAILY_REPORT"
}

# Function to clean old logs (older than 7 days)
clean_old_logs() {
    find "$LOG_DIR" -type f -mtime +7 -exec rm {} \;
    find "$REPORT_DIR" -type f -mtime +7 -exec rm {} \;
}

# =========================
# Main Script Execution
# =========================

# Initialize directories and log files
initialize

# Perform system health checks
check_disk_usage
check_memory_usage
check_cpu_load
list_top_processes
check_network_activity
check_system_temperature

# Generate a report based on the collected data
generate_daily_report

# Clean old logs to save space
clean_old_logs

# End of the script
echo "============================================================="
echo "System Health Check Completed on $(date)"
echo "============================================================="
