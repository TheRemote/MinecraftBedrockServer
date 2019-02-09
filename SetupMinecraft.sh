#!/bin/bash
# Minecraft Server Installation Script - James A. Chambers - https://www.jamesachambers.com
# GitHub Repository: https://github.com/TheRemote/MinecraftBedrockServer
echo "Minecraft Bedrock Server installation script by James Chambers - February 8th 2019"
echo "Latest version always at https://github.com/TheRemote/MinecraftBedrockServer"
echo "Don't forget to set up port forwarding on your router!  The default port is 19132"

# Check to see if Minecraft directory already exists, if it does then exit
if [ -d "minecraft" ]; then
  echo "Directory minecraft already exists!  Exiting..."
  exit 1
fi

# Install screen to run minecraft in the background
echo "Installing screen..."
sudo apt-get install screen -y

# Create server directory
echo "Creating minecraft server directory..."
mkdir minecraft
cd minecraft
mkdir downloads
mkdir backups

# Retrieve latest version of Minecraft Bedrock dedicated server
echo "Checking for the latest version of Minecraft Bedrock server..."
wget -O downloads/version.html https://minecraft.net/en-us/download/server/bedrock/
DownloadURL=$(grep -o 'https://minecraft.azureedge.net/bin-linux/[^"]*' downloads/version.html)
DownloadFile=$(echo "$DownloadURL" | sed 's#.*/##')
echo "$DownloadURL"
echo "$DownloadFile"

# Download latest version of Minecraft Bedrock dedicated server
echo "Downloading the latest version of Minecraft Bedrock server..."
UserName=$(whoami)
wget -O "downloads/$DownloadFile" "$DownloadURL"
unzip -o "downloads/$DownloadFile"

# Download start.sh from repository
echo "Grabbing start.sh from repository..."
wget -O start.sh https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/start.sh
chmod +x start.sh
sed -i "s/replace/$UserName/g" start.sh

# Download stop.sh from repository
echo "Grabbing stop.sh from repository..."
wget -O stop.sh https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/stop.sh
chmod +x stop.sh
sed -i "s/replace/$UserName/g" stop.sh

# Download restart.sh from repository
echo "Grabbing restart.sh from repository..."
wget -O restart.sh https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/restart.sh
chmod +x restart.sh
sed -i "s/replace/$UserName/g" restart.sh

# Server configuration
echo "Enter a name for your server..."
read -p 'Server Name: ' ServerName
sudo sed -i "s/server-name=Dedicated Server/server-name=$ServerName/g" server.properties

# Service configuration
sudo wget -O /etc/systemd/system/minecraft.service https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/minecraft.service
sudo chmod +x /etc/systemd/system/minecraft.service
sudo sed -i "s/replace/$UserName/g" /etc/systemd/system/minecraft.service
sudo systemctl daemon-reload
echo -n "Start Minecraft server at startup automatically (y/n)?"
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
  sudo systemctl enable minecraft.service

  # Automatic reboot at 4am configuration
  echo -n "Automatically restart and update server at 4am daily (y/n)?"
  read answer
  if [ "$answer" != "${answer#[Yy]}" ]; then
    croncmd="/home/$UserName/minecraft/restart.sh"
    cronjob="0 4 * * * $croncmd"
    ( crontab -l | grep -v -F "$croncmd" ; echo "$cronjob" ) | crontab -
    echo "Daily restart scheduled.  To change time or remove automatic restart type crontab -e"
  fi
fi

# Finished!
echo "Setup is complete.  Starting Minecraft server..."
sudo systemctl start minecraft.service

# Sleep for 2 seconds to give the server time to start
sleep 2

screen -r minecraft
