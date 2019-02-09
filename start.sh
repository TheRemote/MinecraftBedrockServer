#!/bin/bash
# James Chambers - February 3rd 2019
# Minecraft Bedrock server startup script using screen

# Start server
cd /home/replace/minecraft/
cp -r worlds backup$(date +%Y.%m.%d.%H.%M.%S)

# Retrieve latest version of Minecraft Bedrock dedicated server
echo "Checking for the latest version of Minecraft Bedrock server..."
wget -O downloads/version.html https://minecraft.net/en-us/download/server/bedrock/
DownloadURL=$(grep -o 'https://minecraft.azureedge.net/bin-linux/[^"]*' downloads/version.html)
DownloadFile=$(echo "$DownloadURL" | sed 's#.*/##')
echo "$DownloadURL"
echo "$DownloadFile"

# Download latest version of Minecraft Bedrock dedicated server
if [ -f "$file" ]
then
	echo "Minecraft Bedrock server is up to date..."
else
	echo "New version $DownloadFile is available.  Updating Minecraft Bedrock server..."
    wget -O "downloads/$DownloadFile" "$DownloadURL"
    unzip -o "downloads/$DownloadFile" -x "server.properties" -x "permissions.json" -x "whitelist.json"
fi

echo "Starting Minecraft server.  To view window type screen -r minecraft."
echo "To minimize the window and let the server run in the background, press Ctrl+A then Ctrl+D"
/usr/bin/screen -dmS minecraft LD_LIBRARY_PATH=/home/replace/minecraft/ /home/replace/minecraft/bedrock_server