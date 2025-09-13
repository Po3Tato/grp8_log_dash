#!/bin/bash
# Function to redact sensitive data from log files
redact_sensitive_data() {
    sed -E \
        -e 's/[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/[REDACTED_EMAIL]/g' \
        -e 's/([0-9]{1,3}\.){3}[0-9]{1,3}/[REDACTED_IP]/g' \
        "$1"
}

clean_temp_files() {
    find . -type f \( -name "*.tmp" -o -name "*.log.bak" \) -exec rm -v {} \;
}

countdown() {
    echo "Cleanup will begin in:"
    for i in {5..1}; do
        echo "$i..."
        sleep 1
    done
    echo "Starting Cleanup."
}

LOG_FILE="system_logs.txt"

redact_sensitive_data "$LOG_FILE" > redacted_logs.txt

countdown

clean_temp_files