# Minecraft Bedrock Server
Sets up a Minecraft Bedrock dedicated server on Ubuntu with options for automatic updates and running at startup<br>
<br>
To get started type:<br>
wget -O SetupMinecraft.sh https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/SetupMinecraft.sh<br>
chmod +x SetupMinecraft.sh<br>
./SetupMinecraft.sh<br>
<br>
<b>Version History</b><br>
<br>
March 2nd 2019<br>
-Script now works on any Debian based distribution (Ubuntu, Debian, Raspbian, etc.)
-Added *very slow* support for ARM platforms such as Raspberry Pi with QEMU emulation of x86_64<br>
-Renamed service to minecraftbe to avoid confusion with Java version<br>
<br>
February 15th 2019<br>
-Backups now compress into .tar.gz format (saved in backups folder)<br>
-Startup service waits up to 20 seconds for an internet connection to allow time for DHCP to retrieve an IP address<br>
-Removed unnecessary sleep time on stop.sh script so it returns as soon as the minecraft server closes<br>
<br>
February 8th 2019<br>
-Initial release<br>