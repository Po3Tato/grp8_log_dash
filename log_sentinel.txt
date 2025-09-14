#!/bin/bash
# Configuration
LOGS_DIR="$HOME/.sentinel/logs"
LOG_FILE="$LOGS_DIR/operations.log"

# Setup logging directory
setup_logs() {
    mkdir -p "$LOGS_DIR"
    touch "$LOG_FILE"
}

# Timestamped logging
log_message() {
    local timestamp=$(date +"%Y-%m-%d %T")
    echo "[$timestamp] $1" | tee -a "$LOG_FILE"
}

# Logging - Save report with timestamp using date and file I/O
save_report() {
    log_file="$1"
    validate_file "$log_file" || return 1
    
    timestamp=$(date +"%Y%m%d_%H%M%S")
    report_file="report_$timestamp.csv"
    
    echo "Saving report to: $report_file"
    
    # CSV Header
    echo "Timestamp,Level,Message" > "$report_file"
    
    # Process log entries to CSV format
    awk -F' - ' '{
        timestamp = $1
        gsub(/^\[|\].*/, "", timestamp)
        level = $1
        gsub(/.*\[|\].*/, "", level)
        message = $2
        gsub(/"/, "\"\"", message)
        printf "\"%s\",\"%s\",\"%s\"\n", timestamp, level, message
    }' "$log_file" >> "$report_file"
    
    echo "Report saved successfully!"
}

# validate_entries1 - Input Validation
validate_file(){
        if [[ $# -eq 0 ]]; then
                echo "Error: No file specified"
                return 1
        fi
        if [[ ! -f "$1" ]]; then
                echo "Error: File '$1' not found"
                return 1
        fi
        return 0
}

# Log Filtering - Extract ERROR, WARNING, INFO entries
extract_entries() {
        log_file="$1"
        level="$2"
        validate_file "$log_file" || return 1
        echo "Extracting $level entries from $log_file"
        grep "\\[$level\\]" "$log_file"
}

filter_all_levels() {
        log_file="$1"
        validate_file "$log_file" || return 1
        echo "=== ERROR Entries ==="
        grep "\\[ERROR\\]" "$log_file"
        echo
        echo "=== WARNING Entries ==="
        grep "\\[WARNING\\]" "$log_file"
        echo
        echo "=== INFO Entries ==="
        grep "\\[INFO\\]" "$log_file"
}

# Frequency Count - Count each log level using for loop
count_entries(){
        log_file="$1"
        validate_file "$log_file" || return 1
        echo "Summary of log levels:"
        
        levels=("ERROR" "WARNING" "INFO")
        for level in "${levels[@]}"; do
                count=$(grep -c "\\[$level\\]" "$log_file")
                echo "$level: $count"
        done
        
        total=$(wc -l < "$log_file")
        echo "Total lines: $total"
}

# Redaction - Mask emails/IPs using sed and regex
redact_sensitive_data() {
    log_file="$1"
    validate_file "$log_file" || return 1
    echo "Redacting sensitive data from $log_file"
    sed -E \
        -e 's/[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/[REDACTED_EMAIL]/g' \
        -e 's/([0-9]{1,3}\.){3}[0-9]{1,3}/[REDACTED_IP]/g' \
        -e 's/password[[:space:]]*=[[:space:]]*[^[:space:]]*/password=[REDACTED]/gi' \
        -e 's/token[[:space:]]*=[[:space:]]*[^[:space:]]*/token=[REDACTED]/gi' \
        "$log_file"
}

clean_temp_files() {
    find . -type f \( -name "*.tmp" -o -name "*.log.bak" \) -exec rm -v {} \;
}

# Report Generator - Format timestamps and messages using awk/cut
generate_report() {
    log_file="$1"
    validate_file "$log_file" || return 1
    
    echo "=== LOG ANALYSIS REPORT ==="
    echo "File: $log_file"
    echo "Generated: $(date)"
    echo "=========================="
    echo
    
    echo "FORMATTED LOG ENTRIES:"
    awk -F' - ' '{
        timestamp = $1
        gsub(/^\[|\].*/, "", timestamp)
        level = $1
        gsub(/.*\[|\].*/, "", level)
        message = $2
        printf "%-20s | %-8s | %s\n", timestamp, level, message
    }' "$log_file"
    
    echo
    echo "SUMMARY BY HOUR:"
    cut -d' ' -f3 "$log_file" | cut -d':' -f1 | sort | uniq -c | awk '{printf "Hour %s: %d entries\n", $2, $1}'
}


# Interactive menu
show_menu() {
    clear
    echo "🛡️  Sentinel Systems Log Intelligence Dashboard 🛡️"
    echo "------------------------------------------------"

    PS3=$'\n'"Enter your choice (1-5): "
    options=(
        "Live Log Monitoring"
        "Anomaly Detection Scan"
        "Generate Intelligence Report"
        "View Audit Trail"
        "Exit"
    )

    select opt in "${options[@]}"; do
        case $REPLY in
            1) 
                echo "Live Log Monitoring - showing filtered log entries:"
                filter_all_levels sample.log
                ;;
            2) 
                echo "Anomaly Detection Scan - redacting sensitive data:"
                redact_sensitive_data sample.log
                ;;
            3) 
                echo "Generate Intelligence Report:"
                save_report sample.log
                ;;
            4) 
                echo "View Audit Trail - showing all log entries:"
                cat sample.log
                ;;
            5) 
                clean_temp_files
                echo "Exiting..."
                exit 0
                ;;
            *) 
                echo "Invalid option. Please try again."
                ;;
        esac
        echo
        read -p "Press Enter to continue..."
    done
}

# Main execution
show_menu
