#!/bin/bash
# Minecraft Server Permissions Fix Script - James A. Chambers - https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/

# Set version in version_pin.txt
# Reverts version pinning if you set a custom version to avoid updates being out of sync with Microsoft's servers
# Removing this file will enable automatic updates again

ls -r1 downloads/ | grep bedrock-server | head -2 | tail -1 > version_pin.txt
echo "Set previous version in version_pin.txt: $(cat version_pin.txt)"