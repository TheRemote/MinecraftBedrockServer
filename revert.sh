#!/bin/bash
# Minecraft Server Permissions Fix Script - James A. Chambers - https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/

# Set version in version_pin.txt
# Reverts version pinning if you set a custom version to avoid updates being out of sync with Microsoft's servers
# Removing this file will enable automatic updates again

# Set path variable
USERPATH="pathvariable"
PathLength=${#USERPATH}
if [[ "$PathLength" -gt 12 ]]; then
    PATH="$USERPATH"
else
    echo "Unable to set path variable.  You likely need to download an updated version of SetupMinecraft.sh from GitHub!"
fi

ls -r1 dirname/minecraftbe/servername/downloads/ | grep bedrock-server | head -2 | tail -1 > version_pin.txt
echo "Set previous version in version_pin.txt: $(cat dirname/minecraftbe/servername/version_pin.txt)"