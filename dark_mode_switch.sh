#!/bin/bash

# Function to check monitor setup and switch appearance mode accordingly
check_and_set_mode() {
    display_count=$(system_profiler SPDisplaysDataType | grep -c "Online: Yes")
    internal_monitor=$(system_profiler SPDisplaysDataType | grep -c "Connection Type: Internal")
    dark_mode=$(osascript -e 'tell app "System Events" to tell appearance preferences to get dark mode')

    if [[ ( $internal_monitor -lt 1 && $display_count -eq 1 ) || $display_count -gt 1 ]]; then
        if [[ "$dark_mode" == "false" ]]; then
            echo "External monitor detected. Switching to dark mode."
            osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
        fi
    elif [[ $internal_monitor -eq 1  &&  $display_count -eq 1 ]]; then
        if [[ "$dark_mode" == "true" ]]; then
            echo "No external monitor detected. Switching to light mode."
            osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false'
        fi
    fi
}

# Initial run
check_and_set_mode
echo "Auto Monitor Mode Switch script started. Monitoring for changes..."

# Loop to monitor changes
while true; do
    check_and_set_mode
    sleep 2
done
