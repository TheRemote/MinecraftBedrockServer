#!/bin/bash
# wertie
# Minecraft Bedrock Server Auto Commands script

# Set path variable
USERPATH="pathvariable"
PathLength=${#USERPATH}
if [[ "$PathLength" -gt 12 ]]; then
    PATH="$USERPATH"
else
    echo "Unable to set path variable.  You likely need to download an updated version of SetupMinecraft.sh from GitHub!"
fi

# Check to make sure we aren't running as root
if [[ $(id -u) = 0 ]]; then
   echo "This script is not meant to be run as root. Please run ./restart.sh as a non-root user, without sudo;  Exiting..."
   exit 1
fi

echo "Sending commands to server...";

# execute commands on startup  
screen -Rd servername -X stuff "gamerule commandblocksenabled false $(printf '\r')";
# screen -Rd servername -X stuff "example command $(printf '\r')";
sleep 1;

# execute commands in loop
while screen -list | grep -q "\.servername"; do
    screen -Rd servername -X stuff "Kill @e[type=npc] $(printf '\r')";
    # screen -Rd servername -X stuff "example command $(printf '\r')";

    # the speed can be changed if you need the loop to be slower.
    sleep 0.1;
done
