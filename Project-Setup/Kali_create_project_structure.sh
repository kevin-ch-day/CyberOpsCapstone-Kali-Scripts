#!/bin/bash

# -----------------------------------------------------------------------------
# Script Name: Kali_create_project_structure.sh
# Purpose:     Creates a directory structure for the Capstone Project on Android
#              banking Trojan analysis, initializes important text files for
#              note-taking, tracking analysis, and setting up the project in
#              a Kali Linux environment.
# Author:      Kevin Day
# Date:        8/30/2024
# -----------------------------------------------------------------------------

# Define the base directory for the project
BASE_DIR=~/Capstone_Project

# Log file
LOG_FILE="$BASE_DIR/creation_log.txt"

# Function to create a directory and log the process
create_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "Created directory: $1" | tee -a "$LOG_FILE"
    else
        echo "Directory already exists: $1" | tee -a "$LOG_FILE"
    fi
}

# Function to create a text file with initial content
create_file() {
    if [ ! -f "$1" ]; then
        touch "$1"
        echo "$2" > "$1"
        echo "Created file: $1 with initial content" | tee -a "$LOG_FILE"
    else
        echo "File already exists: $1" | tee -a "$LOG_FILE"
    fi
}

# Start logging
echo "--------------------------------------------" | tee -a "$LOG_FILE"
echo "Project Directory Structure Creation - $(date)" | tee -a "$LOG_FILE"
echo "--------------------------------------------" | tee -a "$LOG_FILE"

# Create the base project directory
create_dir "$BASE_DIR"

# 01_Research Directory Structure and Files
create_dir "$BASE_DIR/01_Research/01_Literature_Review/papers"
create_dir "$BASE_DIR/01_Research/01_Literature_Review/summaries"
create_dir "$BASE_DIR/01_Research/01_Literature_Review/notes"
create_file "$BASE_DIR/01_Research/01_Literature_Review/notes/literature_review_notes.txt" "Literature Review Notes - Date: $(date)"
create_dir "$BASE_DIR/01_Research/02_Data_Collection/raw_data"
create_dir "$BASE_DIR/01_Research/02_Data_Collection/processed_data"
create_file "$BASE_DIR/01_Research/02_Data_Collection/data_collection_notes.txt" "Data Collection Notes - Date: $(date)"
create_dir "$BASE_DIR/01_Research/03_Tools/installed_tools"
create_dir "$BASE_DIR/01_Research/03_Tools/scripts"
create_file "$BASE_DIR/01_Research/03_Tools/tool_installation_notes.txt" "Tool Installation and Configuration Notes - Date: $(date)"
create_dir "$BASE_DIR/01_Research/04_Experiments/setup_scripts"
create_dir "$BASE_DIR/01_Research/04_Experiments/execution_scripts"
create_dir "$BASE_DIR/01_Research/04_Experiments/results"
create_dir "$BASE_DIR/01_Research/04_Experiments/logs"
create_file "$BASE_DIR/01_Research/04_Experiments/experiment_log.txt" "Experiment Log - Date: $(date)"
create_dir "$BASE_DIR/01_Research/05_Analysis/notebooks"
create_dir "$BASE_DIR/01_Research/05_Analysis/analysis_scripts"
create_dir "$BASE_DIR/01_Research/05_Analysis/results"
create_file "$BASE_DIR/01_Research/05_Analysis/analysis_notes.txt" "Analysis Notes - Date: $(date)"

# 02_Development Directory Structure and Files
create_dir "$BASE_DIR/02_Development/01_Local_Projects/src"
create_dir "$BASE_DIR/02_Development/01_Local_Projects/builds"
create_dir "$BASE_DIR/02_Development/01_Local_Projects/libs"
create_dir "$BASE_DIR/02_Development/01_Local_Projects/resources"
create_file "$BASE_DIR/02_Development/01_Local_Projects/development_notes.txt" "Development Notes and To-Dos - Date: $(date)"
create_dir "$BASE_DIR/02_GitHub_Repositories/downloaded"
create_dir "$BASE_DIR/02_GitHub_Repositories/management_scripts"
create_file "$BASE_DIR/02_GitHub_Repositories/github_repo_notes.txt" "GitHub Repository Management Notes - Date: $(date)"
create_dir "$BASE_DIR/02_Development/03_Android_Apps/apk_files"
create_dir "$BASE_DIR/02_Development/03_Android_Apps/decompiled"
create_dir "$BASE_DIR/02_Development/03_Android_Apps/custom_app_development"
create_file "$BASE_DIR/02_Development/03_Android_Apps/android_app_dev_notes.txt" "Android App Development Notes - Date: $(date)"

# 03_Malware_Samples Directory Structure and Files
create_dir "$BASE_DIR/03_Malware_Samples/01_Original_APKs/banking_trojans/sorted_by_source"
create_dir "$BASE_DIR/03_Malware_Samples/01_Original_APKs/banking_trojans/sorted_by_date"
create_dir "$BASE_DIR/03_Malware_Samples/01_Original_APKs/banking_trojans/sorted_by_variant"
create_dir "$BASE_DIR/03_Malware_Samples/01_Original_APKs/other_malware_types"
create_dir "$BASE_DIR/03_Malware_Samples/01_Original_APKs/backups"
create_file "$BASE_DIR/03_Malware_Samples/01_Original_APKs/sample_collection_notes.txt" "Notes on Sample Collection and Organization - Date: $(date)"
create_dir "$BASE_DIR/03_Malware_Samples/02_Decompiled_APKs/banking_trojans/by_tool_used"
create_dir "$BASE_DIR/03_Malware_Samples/02_Decompiled_APKs/banking_trojans/source_code"
create_dir "$BASE_DIR/03_Malware_Samples/02_Decompiled_APKs/banking_trojans/smali_files"
create_file "$BASE_DIR/03_Malware_Samples/02_Decompiled_APKs/decompilation_notes.txt" "Decompilation Notes - Date: $(date)"
create_dir "$BASE_DIR/03_Malware_Samples/03_Analysis_Workspace/results"
create_dir "$BASE_DIR/03_Malware_Samples/03_Analysis_Workspace/visualizations"
create_file "$BASE_DIR/03_Malware_Samples/03_Analysis_Workspace/analysis_workspace_notes.txt" "Analysis Workspace Notes - Date: $(date)"
create_dir "$BASE_DIR/03_Malware_Samples/04_Backups/original_samples"
create_dir "$BASE_DIR/03_Malware_Samples/04_Backups/decompiled_samples"
create_dir "$BASE_DIR/03_Malware_Samples/04_Backups/analysis_reports"
create_file "$BASE_DIR/03_Malware_Samples/04_Backups/backup_notes.txt" "Backup Process Notes - Date: $(date)"

# 04_Documentation Directory Structure and Files
create_dir "$BASE_DIR/04_Documentation/01_Research_Notes/methodology_notes"
create_dir "$BASE_DIR/04_Documentation/01_Research_Notes/literature_summaries"
create_dir "$BASE_DIR/04_Documentation/01_Research_Notes/general_notes"
create_file "$BASE_DIR/04_Documentation/01_Research_Notes/methodology_notes.txt" "Methodology Notes - Date: $(date)"
create_dir "$BASE_DIR/04_Documentation/02_Development_Docs/design_documents"
create_dir "$BASE_DIR/04_Documentation/02_Development_Docs/api_documentation"
create_dir "$BASE_DIR/04_Documentation/02_Development_Docs/user_manuals"
create_dir "$BASE_DIR/04_Documentation/02_Development_Docs/setup_guides"
create_dir "$BASE_DIR/04_Documentation/02_Development_Docs/general_notes"
create_file "$BASE_DIR/04_Documentation/02_Development_Docs/development_documentation_notes.txt" "Development Documentation Notes - Date: $(date)"
create_dir "$BASE_DIR/04_Documentation/03_Analysis/results"
create_dir "$BASE_DIR/04_Documentation/03_Analysis/visualizations"
create_file "$BASE_DIR/04_Documentation/03_Analysis/analysis_documentation_notes.txt" "Analysis Documentation Notes - Date: $(date)"
create_dir "$BASE_DIR/04_Downloads/tools"
create_file "$BASE_DIR/04_Downloads/download_notes.txt" "Notes on Downloads and Tools - Date: $(date)"

# Completion message
echo "--------------------------------------------" | tee -a "$LOG_FILE"
echo "Project directory structure created successfully in $BASE_DIR" | tee -a "$LOG_FILE"
echo "Log file saved to $LOG_FILE"
echo "--------------------------------------------" | tee -a "$LOG_FILE"
