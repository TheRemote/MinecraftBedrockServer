# Minecraft Bedrock Server

[日本語版 README はこちら](https://github.com/TheRemote/MinecraftBedrockServer/blob/master/README_jp.md)

Sets up a Minecraft Bedrock dedicated server on Ubuntu / Debian with options for automatic updates, backups and running automatically at startup.<br>
View installation instructions at: https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/<br>
<br>
If you are looking for a Docker containerized version of the Minecraft Bedrock Dedicated Server, it is available here:  <a href="https://github.com/TheRemote/Legendary-Bedrock-Container">https://github.com/TheRemote/Legendary-Bedrock-Container</a>

<h2>Features</h2>
<ul>
  <li>Sets up the official Minecraft Bedrock Server (currently in alpha testing)</li>
  <li>Fully operational Minecraft Bedrock edition server in a couple of minutes</li>
  <li>Ubuntu / Debian distributions supported</li>
  <li>Sets up Minecraft as a system service with option to autostart at boot</li>
  <li>Automatic backups when server restarts</li>
  <li>Supports multiple instances -- you can run multiple Bedrock servers on the same system</li>
  <li>Updates automatically to the latest or user-defined version when server is started</li>
  <li>Easy control of server with start.sh, stop.sh and restart.sh scripts</li>
  <li>Adds logging with timestamps to "logs" directory</li>
  <li>Optional scheduled daily restart of server using cron</li>
  <li>*NEW* Box64 support for 64 bit ARM (aarch64) which greatly improves emulation speed over QEMU by translating some system calls to native system calls</li>
</ul>

<h2>Quick Installation Instuctions</h2>
To run the installation type:<br>
<pre>curl https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/SetupMinecraft.sh | bash</pre>

<h2>Installation Guide</h2>
<a href="https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/">Minecraft Bedrock Dedicated Server Script Installation / Configuration Guide</a>

<h2>Installing Resource Packs / RTX Support</h2>
<p>For instructions on how to install resource packs (including optional RTX support), view my <a href="https://jamesachambers.com/minecraft-bedrock-server-resource-pack-guide/" target="_blank" rel="noopener">step-by-step Minecraft Bedrock Dedicated Server Resource Packs / Optional RTX guide here</a>.</p>

<h2>Tested Distributions</h2>
<ul>
 <li>Ubuntu / Ubuntu Server 22.04</li>
 <li>Ubuntu / Ubuntu Server 20.04</li>
 <li>Ubuntu / Ubuntu Server 18.04</li>
 <li>Debian Stretch / Buster</li>
</ul>
  
<h2>Tested Platforms</h2>
<ul>
 <li>All PC X86_64 (WORKING)</li>
 <li><a href="https://jamesachambers.com/udoo-x86-microboard-breakdown/">Udoo X86 (WORKING)</a></li>
 <li><a href="https://jamesachambers.com/install-ubuntu-server-18-04-on-intel-compute-stick-guide/">Intel Compute Stick (WORKING)</a></li>
 <li>Other X86_64 platforms (WORKING)</li>
  <ul><li>ARM 64bit (WORKING -- speed improved with Box64)</li>
    <ul>
      <li>Raspberry Pi 64 bit (WORKING -- Box64)</li>
      <li>Raspberry Pi 32 bit (WORKING -- VERY SLOW -- 64 bit recommended!)</li>
      <li>Tinkerboard (WORKING, 32 bit is slow, 64 bit uses Box64)</li>
    </ul>
  </ul>
</ul>

<h2>Multiple Servers and Installation Paths</h2>
<p>The server supports multiple servers at once.  When you run SetupMinecraft.sh again, pick the identical root path as any previous servers.  The path structure of the scripts is $ROOTPATH/minecraftbe/yourservername, which is why the "root" path SetupMinecraft.sh asks you for should always be the same.</p>
<p>The individual server folder is determined by the "server name" you enter for your server.  If it's an existing server, the scripts will be safely updated.  If it's a new server, then a new folder will be created under $ROOTPATH/minecraftbe/newservername.</p>
<p>Keep the installation path the same for all servers and the script will manage all this for you.</p>

<h2>Version Override</h2>
You can revert to a previous version with the revert.sh script included in your directory like this: <pre>./revert.sh
Set previous version in version_pin.txt: bedrock-server-1.19.10.20.zip</pre>
If you have a specific version you would like to run, you can also create version_pin.txt yourself like this: <pre>echo "bedrock-server-1.18.33.02.zip" > version_pin.txt</pre>
The version hold can be removed by deleting version_pin.txt.  This will allow it to update to the latest version again!

<h2>Buy A Coffee / Donate</h2>
<p>People have expressed some interest in this (you are all saints, thank you, truly)</p>
<ul>
 <li>PayPal: 05jchambers@gmail.com</li>
 <li>Venmo: @JamesAChambers</li>
 <li>CashApp: $theremote</li>
 <li>Bitcoin (BTC): 3H6wkPnL1Kvne7dJQS8h7wB4vndB9KxZP7</li>
</ul>

<h2>Update History</h2>
<ul>
  <li>September 4th 2022</li>
  <ul>
    <li>Remove unnecessary code from fixpermissions.sh</li>
  </ul>
  <li>August 12th 2022</li>
  <ul>
    <li>Add clean.sh utility script to clean up downloads folder, remove version pinning and force reinstall of current version</li>
    <li>Enable content log by default which shows errors related to resource/behavior packs</li>
  </ul>
  <li>August 12th 2022</li>
  <ul>
    <li>Add clean.sh utility script to clean up downloads folder, remove version pinning and force reinstall of current version</li>
    <li>Enable content log by default which shows errors related to resource/behavior packs</li>
  </ul>
  <li>August 10th 2022</li>
  <ul>
    <li>Moved DirName variable to a custom variable at the top of SetupMinecraft.sh</li>
  </ul>
  <li>August 4th 2022</li>
  <ul>
    <li>Script now removes non-alphanumeric characters from the servername variable (to prevent using quotes and other symbols that will break it)</li>
  </ul>
  <li>August 2nd 2022</li>
    <ul>
      <li>Add Box64 support for 64 bit ARM (aarch64).  32 bit ARM is not recommended as it cannot use Box64 so it will be much slower than if you install a 64-bit version of your OS on the device.</li>
      <li>You must be running a 64-bit OS to benefit from the Box64 increased speeds (both Ubuntu and Raspberry Pi OS have 64-bit versions)</li>
      <li>An easy way to check and make sure you are running 64 bit is to use <pre>uname -m</pre> which will return "aarch64" if you are on 64-bit ARM</li>
    </ul>
  <li>July 24th 2022</li>
    <ul>
        <li>Use libssl1.1 from repository instead of Ubuntu servers due to it changing every week or two (thanks theblujuice, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/129">issue #129)</a></li>
    </ul>
  <li>July 21st 2022</li>
    <ul>
        <li>Increase timeout in minecraftbe.service to help servers with longer backup times from having startup issues</li>
    </ul>
  <li>July 19th 2022</li>
    <ul>
        <li>Fix minor syntax error in update.sh</li>
    </ul>
  <li>July 14th 2022</li>
    <ul>
        <li>Fix syntax error in new libssl3 install</li>
        <li>Updated depends.zip for ARM devices (the Docker version is strongly recommended for ARM devices)</li>
    </ul>
  <li>July 14th 2022</li>
    <ul>
        <li>Add libssl3 to dependencies</li>
    </ul>
  <li>July 7th 2022</li>
    <ul>
        <li>Updated curl fallback installation URL to newest package</li>
        <li>Punctuation / grammar fixes to README (thanks TheWilbo, <a href="https://github.com/TheRemote/MinecraftBedrockServer/pull/128">pull request #128)</a></li>
    </ul>
  <li>June 11th 2022</li>
    <ul>
        <li>Added allowlist.json and permissions.json default template files to prevent crashes when they are missing (thanks Eike)</li>
    </ul>
  <li>June 10th 2022</li>
    <ul>
        <li>Fixed problem in escaping screen command in SetupMinecraft.sh (on the startup check)</li>
    </ul>
  <li>June 5th 2022</li>
    <ul>
        <li>Added additional escaping to screen -list commands to prevent similar names from matching the grep query (thanks wheelibin)</li>
        <li>Changed grep -q command to use single quotes to prevent expansion of additional characters (I still recommend only letters and numbers for the server label/name for the least amount of trouble)</li>
    </ul>
  <li>May 31st 2022</li>
    <ul>
        <li>Add check to make sure server.properties exists when unzipping server as without it there will be a startup error</li>
    </ul>
  <li>May 26th 2022</li>
    <ul>
        <li>Add revert.sh to SetupMinecraft.sh downloads</li>
        <li>Add version override documentation</li>
    </ul>
  <li>May 25th 2022</li>
    <ul>
        <li>Added version_pin.txt to allow for manual override of running server version. Run ./revert.sh in your server folder to set version n-1 to run on next restart. Delete version_pin.txt when you want to resume automatic updates. (thanks smallsam)</li>
    </ul>
  <li>May 15th 2022</li>
    <ul>
        <li>Added screen -wipe to beginning of start.sh to prevent a startup issue that could occur if there was a "dead" screen instance (thanks grimholme)</li>
    </ul>
  <li>May 9th 2022</li>
  <ul>
    <li>Updated fallback installation URL for OpenSSL 1.1</li>
  </ul>
  <li>May 4th 2022</li>
  <ul>
    <li>Fixed an issue on Debian where the route command (/sbin/route) is not on the default path by adding a check for this</li>
    <li>Added Ubuntu 22.04 to tested distributions list (I upgraded my desktop OS to this today)</li>
  </ul>
  <li>April 28th 2022</li>
  <ul>
    <li>Fixed a line in fixpermissions.sh that could cause picky shells to complain</li>
  </ul>
  <li>April 24th 2022</li>
  <ul>
    <li>Added dependency package install for libssl1.1 when it's available in apt</li>
    <li>Added fallback installation for libssl1.1 to hopefully fix the installer for Ubuntu 22.04/22.10 and other distros using libssl3</li>
    <li>Fixed a minor 'tail' error message that could occur upon starting the server if no logs were created yet</li>
    <li>Added DEBIAN_NONINTERACTIVE to some apt commands to try to suppress some interactive dialogs (such as running outdated kernel) that were causing the installer to get stuck</li>
    <li>Fixed a mistake in new multicore backup causing it to select the wrong compressor</li>
  </ul>
  <li>April 16th 2022</li>
  <ul>
    <li>Added multiple CPU core support for backups which should speed up backup process</li>
  </ul>
  <li>March 19th 2022</li>
  <ul>
    <li>Removed /sbin qualifier from route command as the PATH variable is now stored at the top of each script by SetupMinecraft.sh (thanks LookedPath, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/120">issue #120</a>)</li>
  </ul>
  <li>March 10th 2022</li>
  <ul>
    <li>Add new allowlist.json to the unzip whitelist (thanks shaman79, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/118">issue #118</a>)</li>
    <li>Added buy a coffe / donation information (thanks vandersonmota, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/117">issue #117</a>)</li>
  </ul>
  <li>November 2nd 2021</li>
  <ul>
    <li>Fixed extra / in front of permissions fix script (thanks MarkBarbieri, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/109">issue #109</a>)</li>
  </ul>
  <li>October 31st 2021</li>
  <ul>
    <li>Fixed missing sudo from fixpermissions line in start.sh (thanks MarkBarbieri, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/109">issue #109</a>)</li>
    <li>Fixed missing -a parameter from /etc/sudoers file addition thanks MarkBarbieri, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/109">issue #109</a>)</li>
  </ul>
  <li>August 1st 2021</li>
  <ul>
    <li>Updated documentation and root path selection prompt to make it more clear that the root directory should be the same for ALL servers</li>
    <li>Don't change unless installing to a different disk, and then use the same root path for ALL servers as they will follow the structure $ROOTPATH/minecraftbe/yourservername</li>
    <li>Choosing a perfect storm of invalid paths has resulted in people's server files being pruned before from being off by one folder sublevel etc.  Please follow instructions carefully here and do not change it and make sure you have backups (saved outside of the main Minecraft backups folder) before ever trying to install an additional server or updating existing scripts.</li>
    <li>Fortunately this person was starting a new server so the pruning didn't get anything serious but I can't stress enough to leave the paths alone unless you're legitimately an expert with a use case like having an entire separate disk for all the Minecraft servers.  Use the same root directory every time (preferably the default)!</li>
  </ul>
  <li>July 27th 2021</li>
  <ul>
    <li>Cleaned up SetupMinecraft.sh and removed redundant code by organizing code into functions</li>
    <li>Scripts now fix all server file permissions on startup</li>
    <li>Added /etc/sudoers.d/minecraftbe file to contain passwordless sudo permission for fixpermissions and sudo systemctl start server</li>
  </ul>
  <li>July 21st 2021</li>
  <ul>
    <li>Updated documentation and restart.sh to document how to enable systemd's service showing as "online" after called by restart.sh (useful for people tracking the servers using the systemd service) by adding a line to the sudoers file to allow passwordless sudo for the sudo systemctl start yourservername command.  Restart.sh now has commented lines at the bottom along with instructions on how to enable if you need this functionality (most people probably won't)</li>
    <li>Added error redirection to crontab line to help diagnose failures during scheduled restarts and removed ExecStartPre from the service as it wasn't doing anything (run ./fixpermissions.sh if you need to fix the permissions) and caused compatibility issues with older systemd versions</li>
  </ul>
  <li>July 17th 2021</li>
  <ul>
    <li>Added in check to ensure start.sh and other scripts are not being ran as root.  If this happens you have to use sudo screen -r to find the screen and the permissions will be wrong since root isn't the owner of the server files</li>
    <li>If you know you ran the script/server as root (which starts creating files owned by root instead of the regular user) and your server won't start/is wonky run the fixpermissions script from your server folder with ./fixpermissions.sh and it will correct them for you!</li>
  </ul>
  <li>July 15th 2021</li>
  <ul>
    <li>Added update.sh convenience script to run SetupMinecraft.sh to update everything to the latest version</li>
    <li>Added validation loop for directory path -- if you are upgrading from an old version you should use the default directory.</li>
    <li>Nothing good can come from changing this and I've never seen or heard of it solving a single problem despite being requested for years (especially if you don't understand relative vs fully qualified Linux paths and other pitfalls -- leave it default!).</li>
    <li>Attempting to solve this problem with safety checks in case this is useful to some people and I just haven't heard about it but it may be removed entirely or turned into a check that you have to download and modify the script to enable if it continues to be a source of strife for people.</li>
    <li>Updated depends.zip for Raspberry Pis</li>
  </ul>
  <li>July 4th 2021</li>
  <ul>
    <li>Added missing sudo line to some prerequistes and removed apt-get install sudo as the script no longer runs as root (install sudo if missing) - thanks Rick Horn</li>
  </ul>
  <li>July 3rd 2021</li>
  <ul>
    <li>Added Accept-Encoding: Identity header to curl as a very small % of users are getting an "Access Denied" error without this header (thanks titiscan, <a href="https://github.com/TheRemote/MinecraftBedrockServer/pull/95">pull request #95</a></li>
    <li>Added default language header to curl as non-english computers were getting an Access Denied error</li>
    <li>Script now checks for gawk being present in start.sh.  If it's not installed (likely due to reusing old SetupMinecraft.sh files) timestamps will be disabled.  This will prevent the server from failing to start.  This is avoided by not running an old copy of SetupMinecraft.sh!</li>
    <li>Removed broken screen -r command at the end of SetupMinecraft.sh as fixing it actually causes lockups -- instead now gives the command (screen -r) to pull up the Minecraft console.  Press Ctrl+A then Ctrl+D to hide the console once you're inside it.</li>
    <li>Added code to prevent SetupMinecraft.sh from being ran as a local file (please use the new method of curl https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/SetupMinecraft.sh | bash)</li>
  </ul>
  <li>July 2nd 2021</li>
  <ul>
    <li>Improved dependency detection and installation</li>
    <li>Removed wget dependency</li>
    <li>Added gawk dependency -- this should not have any impact on most systems but on systems that use mawk by default this will fix server startup issues related to timestamps since mawk doesn't support strftime</li>
    <li>Fixed stop.sh's -t countdown option (thanks da99Beast, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/76">issue #76</a>)</li>
    <li>Fixed a nasty issue where the installation of libcurl3 over the top of libcurl4 was allowed in some configurations (like Ubuntu 18.04) and was clobbering curl (thanks Goretech)</li>
    <li>Fixed an issue where empty folders could be created in the wrong location if start.sh was not ran from the server folder (thanks CobraBitYou, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/93">issue #93</a></li>
  </ul>
  <li>July 1st 2021</li>
  <ul>
    <li>Changed from wget to curl as wget is freezing (but curl works)</li>
    <li>Added randomization to user agent</li>
  </ul>
  <li>June 19th 2021</li>
  <ul>
    <li>Fixed timestamps to display on every line (thanks murkyl)</li>
    <li>Added chmod command after unzip line to make bedrock_server executable for <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/22">issue #22</a> (thanks murkyl)</li>
    <li>Merged <a href="https://github.com/TheRemote/MinecraftBedrockServer/pull/91">pull request #91</a> from starkey-01 to add prompt for an alternate installation directory.  This has been requested for a while so thanks starkey-01!</li>
    <li>Merged <a href="https://github.com/TheRemote/MinecraftBedrockServer/pull/88">pull request #88</a> clarifying instructions to run script as non-root user (thanks sparagi!)</li>
  </ul>
  <li>May 23nd 2021</li>
  <ul>
    <li>The fixpermissions.sh script now displays the last 5 lines from the latest log file to aid in troubleshooting.  If your server won't start this script often will take care of it and the logs can give useful information otherwise!</li>
  </ul>
  <li>May 22nd 2021</li>
  <ul>
    <li>Added setting the path variable to each script to prevent service from failing to start due to not being able to find the right path.</li>
    <li>Please redownload SetupMinecraft.sh for this update.  The script will give you a warning each time you start up that it couldn't set the path variable without the new SetupMinecraft.sh script</li>
    <li>Added user agent to wget string to prevent update check from failing</li>
    <li>Added automatic update to SetupMinecraft.sh if it has not been modified for more than 7 days</li>
    <li>Updated Raspberry Pi dependencies</li>
  </ul>
  <li>April 22nd 2021</li>
  <ul>
    <li>Added a safety check to prevent installing on 32 bit (i386 or i686) operating systems.  The official Bedrock dedicated server has only been released as a 64 bit (x86_64) binary and attempts at emulation on 32 bit have failed to yield any successful results!</li>
    <li>Added chmod +x bedrock_server to start.sh as updates seem to be removing executable permissions sometimes</li>
    <li>Fix removing old backup directory context (thanks murkyl, <a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/76">issue #76</a>)<li>
  </ul>
  <li>April 20th 2021</li>
  <ul>
    <li>Fully qualified route command with /sbin/route to alleviate network check breaking some servers</li>
    <li>Added safety check to prevent using the server label 'minecraftbe' which can break the scripts</li>
    <li>Added libc6 dependency check as several people have reported libns1.so.1 missing</li>
    <li>Added curl and libcurl3 dependency as a fallback for older distros to avoid missing libcurl.so errors</li>
    <li>Added libcrypt1 dependency check</li>
  </ul>
  <li>April 7th 2021</li>
  <ul>
    <li>If you are updating from an old version make sure you remove the old SetupMinecraft.sh and redownload the new version from scratch.  If you are seeing something like userxname in the systemd service you're using an old version of SetupMinecraft.sh and need to download the latest</li>
    <li>Updated fixpermissions.sh -- can fix issues with permissions if you are seeing them!</li>
    <li>Fixed a bug with userxname appearing in start.sh and not being updated to the correct username</li>
    <li>Fixed an issue that could trigger PAM authentication in start.sh</li>
  </ul>
  <li>March 16th 2021</li>
  <ul>
    <li>Fixed a incomplete sudo line in start.sh that was throwing an error (thanks /u/zfa from reddit!)</li>
  </ul>
  <li>February 1st 2021</li>
  <ul>
    <li>Added fixpermissions.sh utility script to take ownership of Minecraft server files manually (the systemd startup service does this automatically for you if you are using it)</li>
  </ul>
  <li>January 31st 2021</li>
  <ul>
    <li>Added .\ in front of the screen -q checks to prevent similar usernames from tripping up window detection</li>
    <li>Server now takes ownership of server files on each start to prevent folks a whole heap of trouble and heartache when restoring backups/moving files/etc.</li>
  </ul>
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