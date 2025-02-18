#!/bin/bash

# Function to check monitors and switch modes
check_monitors() {
    # Count the number of active displays
    display_count=$(system_profiler SPDisplaysDataType | grep -c "Online")
    
    if [ $display_count -gt 1 ]; then
        echo "External monitor detected. Switching to dark mode."
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
    else
        echo "No external monitor detected. Switching to light mode."
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false'
    fi
}

# Function to get current mode
get_current_mode() {
    osascript -e 'tell app "System Events" to tell appearance preferences to get dark mode'
}

# Initial check
last_mode=$(get_current_mode)
check_monitors

echo "Auto Monitor Mode Switch script started. Waiting for monitor changes..."

# Continuously monitor for changes
while true; do
    current_mode=$(get_current_mode)
    display_count=$(system_profiler SPDisplaysDataType | grep -c "Online")
    
    if [ $display_count -gt 1 ] && [ "$current_mode" = "false" ]; then
        echo "External monitor connected. Switching to dark mode."
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to true'
    elif [ $display_count -eq 1 ] && [ "$current_mode" = "true" ]; then
        echo "External monitor disconnected. Switching to light mode."
        osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to false'
    fi
    
    sleep 2  # Check every 2 seconds
done