#!/bin/bash
# Minecraft Server Permissions Fix Script - James A. Chambers - https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/

# Takes ownership of server files to fix common permission errors such as access denied
# This is very common when restoring backups, moving and editing files, etc.

# If you are using the systemd service (sudo systemctl start servername) it performs this automatically for you each startup

# Set path variable
USERPATH="pathvariable"
PathLength=${#USERPATH}
if [[ "$PathLength" -gt 12 ]]; then
    PATH="$USERPATH"
else
    echo "Unable to set path variable.  You likely need to download an updated version of SetupMinecraft.sh from GitHub!"
fi

# Get an optional custom countdown time (in minutes)
Automated=0
while getopts ":a:" opt; do
  case $opt in
    t)
      case $OPTARG in
        ''|*[!0-9]*)
          Automated=1
          ;;
        *)
          Automated=1
          ;;
      esac
      ;;
    \?)
      echo "Invalid option: -$OPTARG; countdown time must be a whole number in minutes." >&2
      ;;
  esac
done

echo "Taking ownership of all server files/folders in dirname/minecraftbe/servername..."
if [[ $Automated == 1 ]]; then
    sudo -n chown -R userxname dirname/minecraftbe/servername
    sudo -n chmod -R 755 dirname/minecraftbe/servername/*.sh
    sudo -n chmod 755 dirname/minecraftbe/servername/bedrock_server
    sudo -n chmod +x dirname/minecraftbe/servername/bedrock_server
else
    sudo chown -Rv userxname dirname/minecraftbe/servername
    sudo chmod -Rv 755 dirname/minecraftbe/servername/*.sh
    sudo chmod 755 dirname/minecraftbe/servername/bedrock_server
    sudo chmod +x dirname/minecraftbe/servername/bedrock_server

    NewestLog=$(find dirname/minecraftbe/servername/logs -type f -exec stat -c "%y %n" {} + | sort -r | head -n1 | cut -d " " -f 4-)
    echo "Displaying last 10 lines from log file $NewestLog in /logs folder:"
    tail -10 "$NewestLog"
fi

echo "Complete"