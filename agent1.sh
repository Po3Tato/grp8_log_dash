#!/bin/bash

validate_file(){
        if [[ ! -f "$1" ]]; then
                echo "Error: '$1' file not found"
                exit 1
        fi
}

extract_entries() {
        log_file="$1"
        level="$2"
        validate_file "$log_file"
        echo "Extracting $level entries from $log_file"
        grep "\[$level\]" "$log_file"
}

count_entries(){
        log_file="$1"
        validate_file "$log_file"
        echo "Summary of log levels in $log_file:"
        echo "ERROR: $(grep -c "[ERROR]" "$log_file")"
        echo "WARNING: $(grep -c "[WARNING]" "$log_file")"
        echo "INFO: $(grep -c "[INFO]" "$log_file")"
}

#Main 
if [[ $# -eq 2 ]]; then
        log_file="$1"
        level="$2"
        extract_entries "$log_file" "$level"
elif [[ $# -eq 1 ]]; then
        log_file="$1"
        count_entries "$log_file"
else
        echo "Usage $0 <logfile> [ERROR|WARNING|INFO]"
        exit 1
fi
