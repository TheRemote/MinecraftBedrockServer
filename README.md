# Minecraft Bedrock Server
Sets up a Minecraft Bedrock dedicated server on Ubuntu / Debian / Raspbian / Armbian with options for automatic updates, backups and running automatically at startup<br>
<br>
To get started type:<br>
wget https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/SetupMinecraft.sh<br>
chmod +x SetupMinecraft.sh<br>
./SetupMinecraft.sh<br>
<br>
<b>Tested Distributions</b><br>
-Ubuntu / Ubuntu Server 18.04.2<br>
-Debian Stretch / Buster<br>
<br>
<b>Tested Platforms</b><br>
-PC X86_64<br>
-Udoo X86<br>
-Intel Compute Stick<br>
-ARM 64bit (warning: proof of concept, extremely slow)<br>
--Raspberry Pi<br>
--Tinkerboard<br>
<br>
<b>Update History</b><br>
<br>
April 26th 2019<br>
-Tested new Bedrock dedicated server 1.11.1.2<br>
-Added startup counter to server instead of waiting a flat 4s to reduce unnecessary waiting<br>
-Fixed ARM support (64 bit required)<br>
<br>
April 18th 2019<br>
-Changed StopChecks++ to StopChecks=$((StopChecks+1)) to improve portability (thanks Jason B.)<br>
-Added TimeoutStartSec=600 to server to prevent it being killed if taking longer than usual to download server<br>
<br>
March 7th 2019<br>
-Added Armbian support<br>
-Tested with Tinkerboard<br>
-Fixed portability issue with route vs /sbin/route<br>
<br>
March 2nd 2019<br>
-Running the SetupMinecraft.sh script after already installing now updates all scripts and reconfigures the minecraftbe service<br>
-Script now works on any Debian based distribution (Ubuntu, Debian, Raspbian, etc.)<br>
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