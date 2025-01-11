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

# Initial check
check_monitors

echo "Auto Monitor Mode Switch script started. Waiting for monitor changes..."

# Monitor for USB events (which should capture most monitor connections)
ioreg -f -w 0 -r -c IODisplayWrangler | while read line; do
    if [[ $line == *"IODisplayWrangler"* && $line == *"ActivityTickle"* ]]; then
        echo "Monitor change detected."
        # Wait a moment for the system to recognize the change
        sleep 2
        check_monitors
    fi
done