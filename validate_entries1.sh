#!/bin/bash

validate_file(){
        if [[ ! -f "$1" ]]; then
                echo "Error: file not found"
                exit 1
        fi
}

extract_entries() {
        log_file="$1"
        level="$2"
        validate_file "$log_file"
        echo "Extracting $level entries from $log_file"
        grep "[$level]" "$log_file"
}

count_entries(){
        log_file="$1"
        level="$2"
        validate_file="$level"
        echo "Summary of log levels : "
        echo "ERROR: $(grep -c "[ERROR]" "$log_file")"
        echo "WARNING: $(grep -c "[WARNING]" "$log_file")"
        echo "INFO: $(grep -c "[INFO]" "$log_file")"
}


if [[ $# -eq 1 ]]; then
        log_file="$1"
        count_entries "$log_file"
        echo
        extract_entries "$log_file" "ERROR"
else
        echo "Usage $0 <logfile>"
        exit 1
fi
