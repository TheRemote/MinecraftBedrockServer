#!/bin/bash
# Minecraft Server Installation Script - James A. Chambers - https://www.jamesachambers.com
# GitHub Repository: https://github.com/TheRemote/MinecraftBedrockServer
echo "Minecraft Bedrock Server installation script by James Chambers - March 2nd 2019"
echo "Latest version always at https://github.com/TheRemote/MinecraftBedrockServer"
echo "Don't forget to set up port forwarding on your router!  The default port is 19132"

# Check to see if Minecraft directory already exists, if it does then exit
if [ -d "minecraftbe" ]; then
  echo "Directory minecraft already exists!  Updating scripts and configuring service ..."

  # Remove existing scripts
  rm minecraft/start.sh minecraft/stop.sh minecraft/restart.sh

  # Get Home directory path and username
  DirName=$(readlink -e ~)
  UserName=$(whoami)

  # Download start.sh from repository
  echo "Grabbing start.sh from repository..."
  wget -O start.sh https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/start.sh
  chmod +x start.sh
  sed -i "s:dirname:$DirName:g" start.sh

  # Download stop.sh from repository
  echo "Grabbing stop.sh from repository..."
  wget -O stop.sh https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/stop.sh
  chmod +x stop.sh
  sed -i "s:dirname:$DirName:g" stop.sh

  # Download restart.sh from repository
  echo "Grabbing restart.sh from repository..."
  wget -O restart.sh https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/restart.sh
  chmod +x restart.sh
  sed -i "s:dirname:$DirName:g" restart.sh

  # Update minecraftbe service
  echo "Configuring minecraftbe service..."
  sudo wget -O /etc/systemd/system/minecraftbe.service https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/minecraftbe.service
  sudo chmod +x /etc/systemd/system/minecraftbe.service
  sudo sed -i "s/replace/$UserName/g" /etc/systemd/system/minecraftbe.service
  sudo sed -i "s:dirname:$DirName:g" /etc/systemd/system/minecraftbe.service
  sudo systemctl daemon-reload
  echo -n "Start Minecraft server at startup automatically (y/n)?"
  read answer
  if [ "$answer" != "${answer#[Yy]}" ]; then
    sudo systemctl enable minecraftbe.service

    # Automatic reboot at 4am configuration
    echo -n "Automatically restart and backup server at 4am daily (y/n)?"
    read answer
    if [ "$answer" != "${answer#[Yy]}" ]; then
      croncmd="$DirName/minecraftbe/restart.sh"
      cronjob="0 4 * * * $croncmd"
      ( crontab -l | grep -v -F "$croncmd" ; echo "$cronjob" ) | crontab -
      echo "Daily restart scheduled.  To change time or remove automatic restart type crontab -e"
    fi
  fi

  exit 0
fi

# Install dependencies required to run Minecraft server in the background
echo "Installing screen, unzip, sudo, net-tools, wget..."
sudo apt-get install screen unzip sudo net-tools wget -y

# Create server directory
echo "Creating minecraft server directory..."
cd ~
mkdir minecraftbe
cd minecraftbe
mkdir downloads
mkdir backups

# Check CPU archtecture to see if we need to do anything special for the platform the server is running on
echo "Getting system CPU architecture..."
CPUArch=$(uname -m)
echo "System Architecture: $CPUArch"
if [[ "$CPUArch" == *"aarch"* || "$CPUArch" == *"arm"* ]]; then
  # ARM architecture detected -- download QEMU and dependency libraries
  echo "ARM platform detected -- installing dependencies..."
  # Check if latest available QEMU version is at least 3.0 or higher
  QEMUVer=$(apt-cache show qemu-user-static | grep Version | awk 'NR==1{ print $2 }' | cut -c3-3)
  if [[ "$QEMUVer" -lt "3" ]]; then
    echo "Available QEMU version is not high enough to emulate x86_64.  Downloading alternative..."
    if [[ "$CPUArch" == *"armv7"* || "$CPUArch" == *"armhf"* ]]; then
      wget http://ftp.us.debian.org/debian/pool/main/q/qemu/qemu-user-static_3.1+dfsg-4_armhf.deb
      wget http://ftp.us.debian.org/debian/pool/main/b/binfmt-support/binfmt-support_2.2.0-2_armhf.deb
      sudo dpkg --install binfmt*.deb
      sudo dpkg --install qemu-user*.deb
    elif [[ "$CPUArch" == *"aarch64"* || "$CPUArch" == *"arm64"* ]]; then
      wget http://ftp.us.debian.org/debian/pool/main/q/qemu/qemu-user-static_3.1+dfsg-4_arm64.deb
      wget http://ftp.us.debian.org/debian/pool/main/b/binfmt-support/binfmt-support_2.2.0-2_arm64.deb
      sudo dpkg --install binfmt*.deb
      sudo dpkg --install qemu-user*.deb
    fi
  else
    sudo apt-get install qemu-user-static -y
  fi

  if [ -n "`which qemu-x86_64-static`" ]; then
    echo "QEMU-x86_64-static installed successfully"
  else
    echo "QEMU-x86_64-static did not install successfully -- please check the above output to see what went wrong."
    rm -rf minecraftbe
    exit 1
  fi
  
  # Retrieve depends.zip from GitHub repository
  wget -O depends.zip https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/depends.zip
  unzip depends.zip
  sudo mkdir /lib64
  # Create soft link ld-linux-x86-64.so.2 mapped to ld-2.28.so
  sudo ln -s ~/minecraftbe/ld-2.28.so /lib64/ld-linux-x86-64.so.2
fi

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
DirName=$(readlink -e ~)
wget -O "downloads/$DownloadFile" "$DownloadURL"
unzip -o "downloads/$DownloadFile"

# Download start.sh from repository
echo "Grabbing start.sh from repository..."
wget -O start.sh https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/start.sh
chmod +x start.sh
sed -i "s:dirname:$DirName:g" start.sh

# Download stop.sh from repository
echo "Grabbing stop.sh from repository..."
wget -O stop.sh https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/stop.sh
chmod +x stop.sh
sed -i "s:dirname:$DirName:g" stop.sh

# Download restart.sh from repository
echo "Grabbing restart.sh from repository..."
wget -O restart.sh https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/restart.sh
chmod +x restart.sh
sed -i "s:dirname:$DirName:g" restart.sh

# Server configuration
echo "Enter a name for your server..."
read -p 'Server Name: ' ServerName
sudo sed -i "s/server-name=Dedicated Server/server-name=$ServerName/g" server.properties

# Service configuration
echo "Configuring minecraftbe service..."
sudo wget -O /etc/systemd/system/minecraftbe.service https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/minecraftbe.service
sudo chmod +x /etc/systemd/system/minecraftbe.service
sudo sed -i "s/replace/$UserName/g" /etc/systemd/system/minecraftbe.service
sudo sed -i "s:dirname:$DirName:g" /etc/systemd/system/minecraftbe.service
sudo systemctl daemon-reload
echo -n "Start Minecraft server at startup automatically (y/n)?"
read answer
if [ "$answer" != "${answer#[Yy]}" ]; then
  sudo systemctl enable minecraftbe.service

  # Automatic reboot at 4am configuration
  echo -n "Automatically restart and backup server at 4am daily (y/n)?"
  read answer
  if [ "$answer" != "${answer#[Yy]}" ]; then
    croncmd="$DirName/minecraftbe/restart.sh"
    cronjob="0 4 * * * $croncmd"
    ( crontab -l | grep -v -F "$croncmd" ; echo "$cronjob" ) | crontab -
    echo "Daily restart scheduled.  To change time or remove automatic restart type crontab -e"
  fi
fi

# Finished!
echo "Setup is complete.  Starting Minecraft server..."
sudo systemctl start minecraftbe.service

# Sleep for 2 seconds to give the server time to start
sleep 2

screen -r minecraftbe