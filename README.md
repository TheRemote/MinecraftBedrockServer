# Minecraft Bedrock Server

Sets up a Minecraft Bedrock dedicated server on Ubuntu / Debian with options for automatic updates, backups and running automatically at startup<br>
View installation instructions at: https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/

<h3>Features</h3>
<ul>
  <li>Sets up the official Minecraft Bedrock Server (currently in alpha testing)</li>
  <li>Fully operational Minecraft Bedrock edition server in a couple of minutes</li>
  <li>Ubuntu / Debian distributions supported</li>
  <li>Sets up Minecraft as a system service with option to autostart at boot</li>
  <li>Automatic backups when server restarts</li>
  <li>Supports multiple instances -- you can run multiple Bedrock servers on the same system</li>
  <li>Updates automatically to the latest version when server is started</li>
  <li>Easy control of server with start.sh, stop.sh and restart.sh scripts</li>
  <li>Optional scheduled daily restart of server using cron</li>
</ul>

<b>UPDATE 12/10/2020 - Multiple instances are currently broken due to the Minecraft Bedrock Edition dedicated server opening up a set of ports it is not supposed to.  Official bug is here on Mojang's official website here: https://bugs.mojang.com/browse/BDS-3989.  This should fix itself eventually as it has nothing to do with this script but is in fact a bug in the server itself but for now be advised multiple instances don't work.  Single instances of the server are still fine.</b>

<h3>Installation Instuctions</h3>
To run the installation type:<br>
<pre>wget -qO- https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/SetupMinecraft.sh | bash</pre>

<h3>Tested Distributions</h3>
<ul>
 <li>Ubuntu / Ubuntu Server 20.04</li>
 <li>Ubuntu / Ubuntu Server 18.04</li>
 <li>Debian Stretch / Buster</li>
</ul>
  
<h3>Tested Platforms</h3>
<ul>
 <li>All PC X86_64 (WORKING)</li>
 <li><a href="https://jamesachambers.com/udoo-x86-microboard-breakdown/">Udoo X86 (WORKING)</a></li>
 <li><a href="https://jamesachambers.com/install-ubuntu-server-18-04-on-intel-compute-stick-guide/">Intel Compute Stick (WORKING)</a></li>
 <li>Other X86_64 platforms (WORKING)</li>
  <ul><li>ARM 64bit (BROKEN -- needs linker and other binaries used for emulation to be updated)</li>
    <ul>
      <li>Raspberry Pi (BROKEN)</li>
      <li>Tinkerboard (BROKEN)</li>
    </ul>
  </ul>
</ul>

<h3>RTX Beta Note</h3>
<p>RTX has been released into normal Minecraft.  If you had the RTX beta version you need to downgrade your Minecraft to the "normal" version for the dedicated server to work.  Go into the "Xbox Insider" app and change back to the normal version of Minecraft and then uninstall your beta version and install the normal version.</p>

<h3>Installing Resource Packs / RTX Support</h3>
<p>For instructions on how to install resource packs (including optional RTX support) view my <a href="https://jamesachambers.com/minecraft-bedrock-server-resource-pack-guide/" target="_blank" rel="noopener">step by step Minecraft Bedrock Dedicated Server Resource Packs / Optional RTX guide here</a>.</p>

<h3>Update History</h3>
<ul>
  <li>December 20th 2020</li>
  <ul>
    <li>Added experimental QEMU support for 32 bit (i386, i686) similar to how the ARM support works</li>
  </ul>
  <li>December 18th 2020</li>
  <ul>
    <li>Added safety check to prevent the script from being ran as root or sudo.  This would cause the script to be installed to the /root folder.</li>
    <li>If you know what you are doing and want to override just edit the check out of SetupMinecraft.sh but otherwise just run it as ./SetupMinecraft.sh normally.</li>
    <li>Fixed a nasty bug that could cause start.sh and stop.sh to disapper (thanks Paul and James).  This was related to log pruning and not having a hard path.  If you downloaded the SetupMinecraft script in the past 3 days update and try again here and you'll be set!</li>
  </ul>
  <li>December 15th 2020</li>
  <ul>
    <li>Resource packs (including ones that optionally enable RTX support) are working</li>
    <li>Guide available at <a href="https://jamesachambers.com/minecraft-bedrock-server-resource-pack-guide/" target="_blank" rel="noopener">https://jamesachambers.com/minecraft-bedrock-server-resource-pack-guide/</a></li>
    <li>Added automatic backup rotation -- server keeps last 10 backups - thanks aghadjip <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/33">Issue 33</a></li>
    <li>Added valid_known_packs to unzip whitelist to prevent resource packs from getting overwritten - thanks kmpoppe - <a href="https://github.com/TheRemote/MinecraftBedrockServer/pull/53">Pull Request 53</a></li>
    <li>Create logs directory if it doesn't exist - thanks omkhar - <a href="https://github.com/TheRemote/MinecraftBedrockServer/pull/39">Pull Request 39</a></li>
  </ul>
  <li>December 13th 2020</li>
  <ul>
    <li>RTX beta is now supported as long as you aren't on the "beta" channel anymore.  Unenroll from the RTX beta and downgrade to normal Minecraft.  RTX is in normal Minecraft now.</li>
    <li>Fixed ARM support for Raspberry Pi, Tinkerboard, and others.  Be warned, it's still very slow on ARM!</li>
    <li>Updated depends.zip</li>
  </ul>
  <li>December 10th 2020</li>
  <ul>
    <li>Cleaned up documentation</li>
    <li>Added notice that the RTX beta version of Minecraft's dedicated server has not been released yet.  Support will be added the moment it is!</li>
    <li>Added alpha software notice for Bedrock dedicated server per <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/34">issue 34</a></li>
  </ul>
  <li>November 17th 2020</li>
  <ul>
    <li>Fixed server autoupdating in start.sh</li>
    <li>Minecraft.net had made a change where the "--spider" parameter would return a 503 -- removed this to fix automatic updates</li>
  </ul>
  <li>July 24th 2019</li>
  <ul>
    <li>Fixed Raspberry Pi support</li>
  </ul>
  <li>July 10th 2019</li>
  <ul>
    <li>Fixed OpenSSL error in 1.12 (thanks obviator!)</li>
    <li>Fixed ports not choosing defaultS if nothing is entered (thanks sweavo!)</li>
  </ul>
  <li>July 2nd 2019</li>
  <ul>
    <li>Added libcurl4 Bedrock server dependency to installer script to prevent server startup from failing</li>
  </ul>
  <li>July 1st 2019</li>
  <ul>
    <li>Added support for multiple servers</li>
    <li>Choose the folder name and port for the server in SetupMinecraft.sh (must be unique per server instance)</li>
  </ul>
  <li>May 23rd 2019</li>
  <ul>
    <li>Fixed typo in restart.sh where there was a space after stop command preventing the server from closing cleanly</li>
    <li>Added 10 second sleep after a force close to give the server time to fully close before calling start.sh</li>
    <li>Fixed server not restarting after scheduled nightly reboot (related to restart.sh bug)</li>
    <li>Removed some direct (for example paths like /bin/sleep) that were harming cross platform compatibility</li>
  </ul>
  <li>April 26th 2019</li>
  <ul>
    <li>Tested new Bedrock dedicated server 1.11.1.2</li>
    <li>Added startup counter to server instead of waiting a flat 4s to reduce unnecessary waiting</li>
    <li>Fixed ARM support (64 bit required)</li>
  </ul>
  <li>April 18th 2019</li>
  <ul>
    <li>Changed StopChecks++ to StopChecks=$((StopChecks+1)) to improve portability (thanks Jason B.)</li>
    <li>Added TimeoutStartSec=600 to server to prevent it being killed if taking longer than usual to download server</li>
  </ul>
  <li>March 7th 2019</li>
  <ul>
    <li>Added Armbian support</li>
    <li>Tested with Tinkerboard</li>
    <li>Fixed portability issue with route vs /sbin/route</li>
  </ul>
  <li>March 2nd 2019</li>
  <ul>
    <li>Running the SetupMinecraft.sh script after already installing now updates all scripts and reconfigures the minecraftbe service</li>
    <li>Script now works on any Debian based distribution (Ubuntu, Debian, Raspbian, etc.)<br>
    <li>Added *very slow* support for ARM platforms such as Raspberry Pi with QEMU emulation of x86_64</li>
    <li>Renamed service to minecraftbe to avoid confusion with Java version</li>
  </ul>
  <li>February 15th 2019</li>
  <ul>
    <li>Backups now compress into .tar.gz format (saved in backups folder)</li>
    <li>Startup service waits up to 20 seconds for an internet connection to allow time for DHCP to retrieve an IP address</li>
    <li>Removed unnecessary sleep time on stop.sh script so it returns as soon as the minecraft server closes</li>
  </ul>
  <li>February 8th 2019</li>
  <ul>
    <li>Initial release</li>
  </ul>
</ul>
