#!/bin/bash
# James Chambers - February 8th 2019
# Minecraft Bedrock Server restart script

screen -Rd minecraft -X stuff "say Server is restarting in 30 seconds! $(printf '\r')"
sleep 23s
screen -Rd minecraft -X stuff "say Server is restarting in 7 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Server is restarting in 6 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Server is restarting in 5 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Server is restarting in 4 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Server is restarting in 3 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Server is restarting in 2 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Server is restarting in 1 second! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Closing server...$(printf '\r')"
screen -Rd minecraft -X stuff "save $(printf '\r')"
sleep 5s
screen -Rd minecraft -X stuff "stop $(printf '\r')"
sleep 15s
  
if screen -list | grep -q "minecraft"; then
    # Server still hasn't stopped after 20s, tell Screen to close it
    echo "Minecraft server still hasn't closed after 20 seconds, closing screen manually"
    screen -S minecraft -X quit
fi

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