This is a macOS shell script that automatically switches between dark and light modes based on whether an external monitor is connected. 
The script runs in the background and uses system commands to detect when a monitor is attached or detached. 
When it detects a change, it immediately switches the system appearance: dark mode when an external monitor is connected, and light mode when it's disconnected. 
This automation enhances user experience by adjusting the display mode to suit different work environments without manual intervention.

## How to Keep the Script Running in the Background


1. Download the `dark_mode_switch.sh` script.
2. Open Terminal and navigate to the directory where the script is saved.
3. Run the following command to make the script executable:
   ```bash
   chmod +x dark_mode_switch.sh
   ```
4. Run the script in the background using the following command:
   ```bash
   screen -S dark_mode_switch
   ```
5. Once inside the screen session, run the script:
   ```bash
   ./dark_mode_switch.sh
   ```
6. Detach from the screen session by pressing `Ctrl + A` followed by `Ctrl + D`. To reattach to the session, use the command:
   ```bash
   screen -r dark_mode_switch
   ```
7. The script will now run in the background and automatically switch between dark and light modes based on monitor connections.