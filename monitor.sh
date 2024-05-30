#!/bin/bash

# Directory to store log files
LOG_DIR="/var/log"
# Log files
STDOUT_LOG_FILE="stdout.log"
STDERR_LOG_FILE="stderr.log"
# Maximum log file size in bytes (1 MB)
MAX_SIZE=1048576

# Create log directory if it does not exist (though /var/log should already exist)
mkdir -p "$LOG_DIR"

# Function to truncate log file
truncate_log_file() {
    local file=$1
    # Use tail to keep only the last 1 MB of the log file
    tail -c $MAX_SIZE "$LOG_DIR/$file" > "$LOG_DIR/$file.tmp"
    mv "$LOG_DIR/$file.tmp" "$LOG_DIR/$file"
}

# Monitor and write stdout and stderr to log files
while true; do
    # Check if log files exceed the maximum size
    for file in $STDOUT_LOG_FILE $STDERR_LOG_FILE $STATUS_LOG_FILE; do
        if [ -f "$LOG_DIR/$file" ] && [ $(stat -c%s "$LOG_DIR/$file") -ge $MAX_SIZE ]; then
            truncate_log_file $file
        fi
    done

    # Read from stdin and stderr and append to the log files
    if read -r line; then
        echo "$line" >> "$LOG_DIR/$STDOUT_LOG_FILE"
    fi
done 2>> "$LOG_DIR/$STDERR_LOG_FILE" &

# Wait for the background process to finish
wait
