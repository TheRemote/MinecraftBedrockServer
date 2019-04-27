#!/bin/bash
# Minecraft Server Installation Script - James A. Chambers - https://www.jamesachambers.com
#
# Instructions: https://jamesachambers.com/2019/03/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/
# To run the setup script use:
# curl https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/SetupMinecraft.sh | bash
#
# GitHub Repository: https://github.com/TheRemote/MinecraftBedrockServer

echo "Minecraft Bedrock Server installation script by James Chambers - March 30th 2019"
echo "Latest version always at https://github.com/TheRemote/MinecraftBedrockServer"
echo "Don't forget to set up port forwarding on your router!  The default port is 19132"

# Install dependencies required to run Minecraft server in the background
echo "Installing screen, unzip, sudo, net-tools, wget, bc..."
if [ ! -n "`which sudo`" ]; then
  apt-get update && apt-get install sudo -y
fi
sudo apt-get update
sudo apt-get install screen unzip net-tools wget bc -y

# Check to see if Minecraft directory already exists, if it does then exit
cd ~
if [ -d "minecraftbe" ]; then
  echo "Directory minecraftbe already exists!  Updating scripts and configuring service ..."

  # Get Home directory path and username
  DirName=$(readlink -e ~)
  UserName=$(whoami)
  cd ~
  cd minecraftbe
  echo "Home directory is: $DirName"

  # Remove existing scripts
  rm start.sh stop.sh restart.sh

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
  read answer < /dev/tty
  if [ "$answer" != "${answer#[Yy]}" ]; then
    sudo systemctl enable minecraftbe.service

    # Automatic reboot at 4am configuration
    echo -n "Automatically restart and backup server at 4am daily (y/n)?"
    read answer < /dev/tty
    if [ "$answer" != "${answer#[Yy]}" ]; then
      croncmd="$DirName/minecraftbe/restart.sh"
      cronjob="0 4 * * * $croncmd"
      ( crontab -l | grep -v -F "$croncmd" ; echo "$cronjob" ) | crontab -
      echo "Daily restart scheduled.  To change time or remove automatic restart type crontab -e"
    fi
  fi

  # Setup completed
  echo "Setup is complete.  Starting Minecraft server..."
  sudo systemctl start minecraftbe.service

  # Sleep for 4 seconds to give the server time to start
  sleep 4s

  screen -r minecraftbe

  exit 0
fi

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
      wget http://ftp.us.debian.org/debian/pool/main/q/qemu/qemu-user-static_3.1+dfsg-7_armhf.deb
      wget http://ftp.us.debian.org/debian/pool/main/b/binfmt-support/binfmt-support_2.2.0-2_armhf.deb
      sudo dpkg --install binfmt*.deb
      sudo dpkg --install qemu-user*.deb
    elif [[ "$CPUArch" == *"aarch64"* || "$CPUArch" == *"arm64"* ]]; then
      wget http://ftp.us.debian.org/debian/pool/main/q/qemu/qemu-user-static_3.1+dfsg-7_arm64.deb
      wget http://ftp.us.debian.org/debian/pool/main/b/binfmt-support/binfmt-support_2.2.0-2_arm64.deb
      sudo dpkg --install binfmt*.deb
      sudo dpkg --install qemu-user*.deb
    fi
  else
    sudo apt-get install qemu-user-static binfmt-support -y
  fi

  if [ -n "`which qemu-x86_64-static`" ]; then
    echo "QEMU-x86_64-static installed successfully"
  else
    echo "QEMU-x86_64-static did not install successfully -- please check the above output to see what went wrong."
    rm -rf ~/minecraftbe
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
read -p 'Server Name: ' ServerName < /dev/tty
sudo sed -i "s/server-name=Dedicated Server/server-name=$ServerName/g" server.properties

# Service configuration
echo "Configuring minecraftbe service..."
sudo wget -O /etc/systemd/system/minecraftbe.service https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/minecraftbe.service
sudo chmod +x /etc/systemd/system/minecraftbe.service
sudo sed -i "s/replace/$UserName/g" /etc/systemd/system/minecraftbe.service
sudo sed -i "s:dirname:$DirName:g" /etc/systemd/system/minecraftbe.service
sudo systemctl daemon-reload
echo -n "Start Minecraft server at startup automatically (y/n)?"
read answer < /dev/tty
if [ "$answer" != "${answer#[Yy]}" ]; then
  sudo systemctl enable minecraftbe.service

  # Automatic reboot at 4am configuration
  TimeZone=$(cat /etc/timezone)
  CurrentTime=$(date)
  echo "Your time zone is currently set to $TimeZone.  Current system time: $CurrentTime"
  echo "You can adjust/remove the selected reboot time later by typing crontab -e or running SetupMinecraft.sh again."
  echo -n "Automatically restart and backup server at 4am daily (y/n)?"
  read answer < /dev/tty
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

# Wait up to 20 seconds for server to start
StartChecks=0
while [ $StartChecks -lt 20 ]; do
  if screen -list | grep -q "minecraftbe"; then
    break
  fi
  sleep 1;
  StartChecks=$((StartChecks+1))
done

# Force quit if server is still open
if ! screen -list | grep -q "minecraftbe"; then
  echo "Minecraft server failed to start after 20 seconds."
fi

screen -r minecraftbe | bash
