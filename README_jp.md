# マインクラフト 統合版(bedrock edition)サーバー構築ツール

※ 統合版とbedrock editionの２つの呼び方がありますがここではbedrock editionに統一しています。

このツールは Ubuntu / Debian サーバー上でマインクラフトサーバーを構築し、マインクラフトの自動アップデート、自動バックアップ、自動起動が設定できます。<br>
詳しいインストール方法はこちら: https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/

<h3>ツールの特徴</h3>
<ul>
  <li>公式のマインクラフト bedrock edition サーバー(アルファテスト中)を構築します</li>
  <li>マインクラフト bedrock edition サーバーの完全インストールが数分で完了</li>
  <li>Ubuntu / Debian ディストリビューション下の動作がサポートされています</li>
  <li>マインクラフトをOSのシステムサービスに登録し、OS起動時にマインクラフトが自動起動するように設定可能</li>
  <li>サーバー再起動時、自動バックアップ</li>
  <li>マルチインスタンスに対応 -- 同一システム上で複数の Bedrock サーバー が起動できます。</li>
  <li>サーバー起動時に最新版への自動アップデート</li>
  <li>start.sh, stop.sh and restart.sh ,これらのスクリプトで簡単操作</li>
  <li>"logs" ディレクトリへタイムスタンプのログが可能</li>
  <li>cron を利用して、毎日の再起動が設定可能</li>
</ul>

<h3>インストール方法（簡易版）</h3>
インストールのコマンド:<br>
<pre>curl https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/SetupMinecraft.sh | bash</pre>

<h3>インストールガイド</h3>
<a href="https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/">Minecraft Bedrock Dedicated Server Script Installation / Configuration Guide</a>

<h3>RTX用リソースパックのインストール</h3>
<p>リソースパック(RTXサポート)のインストール方法→<a href="https://jamesachambers.com/minecraft-bedrock-server-resource-pack-guide/" target="_blank" rel="noopener">step by step Minecraft Bedrock Dedicated Server Resource Packs / Optional RTX guide here</a>.</p>

<h3>テストが完了しているディストリビューション</h3>
<ul>
 <li>Ubuntu / Ubuntu Server 20.04</li>
 <li>Ubuntu / Ubuntu Server 18.04</li>
 <li>Debian Stretch / Buster</li>
</ul>
  
<h3>テストが完了しているハードウェア環境</h3>
<ul>
 <li>All PC X86_64 (稼働中)</li>
 <li><a href="https://jamesachambers.com/udoo-x86-microboard-breakdown/">Udoo X86 (稼働中)</a></li>
 <li><a href="https://jamesachambers.com/install-ubuntu-server-18-04-on-intel-compute-stick-guide/">Intel Compute Stick (稼働中)</a></li>
 <li>Other X86_64 platforms (稼働中)</li>
  <ul><li>ARM 64bit (稼働中 -- 仮想化のために、リンカと他のバイナリをアップデートする必要があります)</li>
    <ul>
      <li>Raspberry Pi (稼働中, 動作は遅いです, OSはUbuntu , セグメンテーション違反が起きるため、Pi OS 64 bitでは動きません)</li>
      <li>Tinkerboard (稼働中, 動作は遅いです)</li>
    </ul>
  </ul>
</ul>

<h3>マルチサーバーとインストールパスについて</h3>
<p>複数ワールドの. SetupMinecraft.sh を再度実行する際は、初回起動時と同じディレクトリパスで実行してください。 ディレクトリパスの構成は $ROOTPATH/minecraftbe/yourservername です。そのため、SetupMinecraft.sh がアクセスするディレクトリパスは常に同じにしなければならないです。</p>
<p>マイクラサーバーのフォルダ名は "server name" として入力した名前になります. スクリプ上で存在していればマインクラフトのアップデートは機能します。  もしも、新しいフォルダーでサーバーを作成した場合のパスは $ROOTPATH/minecraftbe/newservername. となります。</p>
<p>すべてのワールドのサーバーのインストールは同じパスにしてください。同一にすることでワールドを管理します</p>

<h3>systemd権限を追加(オプション)</h3>
<p>マインクラフトをsystemdサービスとして追跡しているユーザーについて、毎日の自動再起動機能を使用している場合。restart.sh はrootとして起動せず、systemd サービスとして再起動しません、よって、サービスは"online"と表示しません。</p>
<p>これを修正するには sudoers ファイル (sudo visudo) に下記コードを加えてください:</p>
<pre>yourusername ALL=(ALL) NOPASSWD: /bin/systemctl start yourservername</pre>
<p>This will give you

<h3>アップデート履歴</h3>
<ul>
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
