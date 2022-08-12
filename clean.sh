#!/bin/bash
# Minecraft Server Clean - James A. Chambers - https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/

# Cleans downloads folder and version_installed.txt
# Removes version pinning (version_pin.txt)
# This will force a reinstall if you have a broken or corrupt download / installation.

# Set path variable
USERPATH="pathvariable"
PathLength=${#USERPATH}
if [[ "$PathLength" -gt 12 ]]; then
    PATH="$USERPATH"
else
    echo "Unable to set path variable.  You likely need to download an updated version of SetupMinecraft.sh from GitHub!"
fi

rm -rf dirname/minecraftbe/servername/downloads
rm -f dirname/minecraftbe/servername/version_pin.txt
rm -f dirname/minecraftbe/servername/version_installed.txt
echo "All folders have been cleaned!"
