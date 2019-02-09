#!/bin/bash
# James Chambers - February 8th 2019
# Minecraft Bedrock server startup script using screen

# Check if server is already started
if screen -list | grep -q "minecraft"; then
    echo "Server is already started!  Press screen -r minecraft to open it"
    exit 1
fi

# Start server
cd /home/replace/minecraft/
cp -r worlds backups/$(date +%Y.%m.%d.%H.%M.%S)

# Retrieve latest version of Minecraft Bedrock dedicated server
echo "Checking for the latest version of Minecraft Bedrock server..."
wget -O downloads/version.html https://minecraft.net/en-us/download/server/bedrock/
DownloadURL=$(grep -o 'https://minecraft.azureedge.net/bin-linux/[^"]*' downloads/version.html)
DownloadFile=$(echo "$DownloadURL" | sed 's#.*/##')

# Download latest version of Minecraft Bedrock dedicated server
if [ -f "downloads/$DownloadFile" ]
then
	echo "Minecraft Bedrock server is up to date..."
else
	echo "New version $DownloadFile is available.  Updating Minecraft Bedrock server..."
    wget -O "downloads/$DownloadFile" "$DownloadURL"
    unzip -o "downloads/$DownloadFile" -x "*server.properties*" "*permissions.json*" "*whitelist.json*"
fi

echo "Starting Minecraft server.  To view window type screen -r minecraft."
echo "To minimize the window and let the server run in the background, press Ctrl+A then Ctrl+D"
/usr/bin/screen -dmS minecraft /bin/bash -c "LD_LIBRARY_PATH=/home/replace/minecraft /home/replace/minecraft/bedrock_server"