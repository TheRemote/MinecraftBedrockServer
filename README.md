# Minecraft Bedrock Server

在Ubuntu / Debian上设置Minecraft Bedrock专用服务器，并提供自动更新，备份和在启动时自动运行的选项。
查看安装说明，网址为：https : //jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/
<h3>功能</ h3>
<ul>
  <li>设置官方的Minecraft基岩服务器（当前正在进行alpha测试）</li>
  <li>几分钟内即可完全运行Minecraft Bedrock版服务器</li>
  <li>支持Ubuntu / Debian发行版</li>
  <li>将Minecraft设置为系统服务，并具有在启动时自动启动的选项</li>
  <li>服务器重新启动时自动备份</li>
  <li>支持多个实例-您可以在同一系统上运行多个Bedrock服务器</li>
  <li>启动服务器后自动更新为最新版本</li>
  <li>使用start.sh，stop.sh和restart.sh脚本轻松控制服务器</li>
  <li>使用cron可选地计划每天重启服务器</li>
</ul>



<b> 2020年12月10日更新-由于Minecraft Bedrock Edition专用服务器打开了不应有的一组端口，当前多个实例已损坏。官方Bug可以在Mojang的官方网站上找到：https：//bugs.mojang.com/browse/BDS-3989。这最终应该会解决，因为它与该脚本无关，但实际上是服务器本身的错误，但现在建议多个实例不起作用。服务器的单个实例仍然可以。</b>
<h3>安装说明</h3>
要运行安装类型：<br>
英文版：
<pre> wget https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/SetupMinecraft.sh && chmod +x SetupMinecraft.sh && ./SetupMinecraft.sh</pre>
中文版：
<pre> wget https://raw.githubusercontent.com/HeQuanX/MinecraftBedrockServer/zh_cn/SetupMinecraft.sh && chmod +x SetupMinecraft.sh && ./SetupMinecraft.sh</pre>
中文版(如果由于网络原因无法正常使用github请使用gitee)：
<pre> wget https://gitee.com/crabapples/MinecraftBedrockServer/raw/zh_cn/SetupMinecraft.sh && chmod +x SetupMinecraft.sh && ./SetupMinecraft.sh</pre>

<h3>测试环境</h3>
<ul>
 <li>Ubuntu / Ubuntu Server 20.04</li>
 <li>Ubuntu / Ubuntu Server 18.04</li>
 <li>Debian Stretch / Buster</li>
</ul>
  
<h3>测试硬件</h3>
<ul>
 <li>All PC X86_64 (正常)</li>
 <li><a href="https://jamesachambers.com/udoo-x86-microboard-breakdown/">Udoo X86 (正常)</a></li>
 <li><a href="https://jamesachambers.com/install-ubuntu-server-18-04-on-intel-compute-stick-guide/">Intel Compute Stick (正常)</a></li>
 <li>其他 X86_64 平台 (测试中)</li>
  <ul>
    <li>ARM 64位 (失败 -- 需要更新虚拟环境和其他二进制文件)</li>
    <ul>
      <li>Raspberry Pi (失败)</li>
      <li>Tinkerboard (失败)</li>
    </ul>
  </ul>
</ul>

<h3>RTX Beta注意事项</h3>
<p>RTX已发布到正常的Minecraft中。如果您拥有RTX beta版，则需要将Minecraft降级为“正常”版本，以使专用服务器正常工作。进入“ Xbox Insider”应用程序，并更改回Minecraft的普通版本，然后卸载Beta版并安装普通版本。</p>

<h3>安装资源包/ RTX支持</h3>
<p>对于有关如何安装资源包的说明（包括可选的RTX支持），请查看<a href="https://jamesachambers.com/minecraft-bedrock-server-resource-pack-guide/" target="_blank" rel="noopener"> Minecraft Bedrock Dedicated Server Resource Packs / Optional RTX guide</a>.</p>

<h3>Update History</h3>
<ul>
  <li>2020年12月20日</li>
  <ul>
    <li>添加了对32位（i386，i686）的实验性QEMU支持，类似于ARM支持的工作原理</li>
  </ul>
  <li> 2020年12月18日</li>
  <ul>
    <li>添加了安全检查，以防止脚本以root或sudo身份运行。这将导致脚本被安装到/root目录下</li>
    <li>如果您知道自己在做什么，并且想要覆盖，只需编辑SetupMinecraft.sh中的检测，否则只需以./SetupMinecraft身份运行即可。</li>
    <li>修复了可能导致start.sh和stop.sh崩溃的讨厌的错误（感谢Paul和James）。这与修剪日志有关，没有硬路径。如果您在过去三天的更新中下载了SetupMinecraft脚本，然后在此处重试，将会被设置！</li>
  </ul>
  <li> 2020年12月15日</li>
  <ul>
    <li>资源包（包括可选启用RTX支持的程序）</li>
    <li>地址为 <a href="https://jamesachambers.com/minecraft-bedrock-server-resource-pack-guide/" target="_blank" rel="noopener">https://jamesachambers.com/minecraft-bedrock-server-resource-pack-guide/</a></li>
    <li>增加了自动备份循环功能-服务器保留了最后10个备份-感谢aghadjip<a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/33">Issue 33</a></li>
    <li>添加了valid_known_packs来解压缩白名单，以防止资源包被覆盖-感谢kmpoppe <a href="https://github.com/TheRemote/MinecraftBedrockServer/pull/53">Pull Request 53</a></li>
    <li>如果不存在则创建日志目录-谢谢omkhar-<a href="https://github.com/TheRemote/MinecraftBedrockServer/pull/39">Pull Request 39</a></li>
  </ul>
  <li>2020年12月13日</li> 
  <ul>
    <li>现在，只要您不再处于“测试版”频道，就可以获得更新。从RTX beta版降级为普通Minecraft。Minecraft已支持在RTX中正常使用。</li>
    <li>修复了对Raspberry Pi，Tinkerboard等产品的ARM支持。但是请注意，在ARM架构上，它仍然非常慢！</li>
    <li>更新了 depends.zip</li>
  </ul>
  <li> 2020年12月10日</li>
  <ul>
    <li>清理文档</li>
    <li>添加了有关Minecraft专用服务器的RTX beta版尚未发布的通知!</li>
    <li>添加了内部测试版的通知<a href="https://github.com/TheRemote/MinecraftBedrockServer/issues/34">issue 34</a></li>
  </ul>
  <li> 2020年11月17日</li> 
  <ul> 
    <li>已修复服务器在start.sh中自动更新的问题</li> 
    <li> Minecraft.net已更改了 “--spider” 参数的位置返回503-删除此错误以修复自动更新</li> 
  </ul> 
  <li> 2019年7月24日</li> 
  <ul> 
    <li>已修复Raspberry Pi支持</li> 
  </ul> 
  <li> 2019年7月10日</li> 
  <ul> 
    <li>修复了1.12中的OpenSSL错误（感谢obviator！）</li> 
    <li>如果未输入任何内容，则修复了端口未选择defaultS的问题（感谢sweavo！）</li> 
  </ul> 
  <li>2019年7月2日</li> 
  <ul>
    <li>在安装程序脚本中添加了libcurl4的安装，以防止服务器启动失败</li> 
  </ul> 
  <li> 2019年7月1日</li>
  <ul>
    <li>增加了对多台服务器的支持</ li>
    <li>在SetupMinecraft.sh中选择服务器的文件夹名称和端口（每个服务器实例必须唯一）</ li>
  </ul>
  <li> 2019年5月23日</li>
  <ul>
    <li>修复了restart.sh中的错误，该命令在stop命令后存在空格，导致服务器无法正常关闭</li>
    <li>在强制关闭后增加了10秒钟的睡眠，以使服务器有时间在调用start.sh之前完全关闭。</li>
    <li>固定的服务器在计划的每晚重新启动后不重新启动（与restart.sh错误有关）</li>
    <li>删除了一些直接损害跨平台兼容性的绝对路径（例如/bin/sleep）</li>
  </ul>
    <li> 2019年4月26日</li>
  <ul>
    <li>测试了新的Bedrock专用服务器1.11.1.2 </li>
    <li>为服务器添加了启动计数器，而不是等待固定的4s来减少不必要的等待</li>
    <li>永久支持ARM架构（需要64位）</li>
  </ul>
  <li> 2019年4月18日</li>
  <ul>
    <li>将StopChecks ++更改为StopChecks = $（（（StopChecks + 1））以提高可移植性（感谢Jason B）</li>
    <li>在服务器上添加了TimeoutStartSec = 600，以防止在花费比平时更长的时间下载服务器时被终止</li>
  </ul>
  <li> 2019年3月7日</li>
  <ul>
    <li>添加了Armbian支持</li>
    <li>经过Tinkerboard测试</li>
    <li>Fixed portability issue with route vs /sbin/route</li>
  </ul>
  <li> 2019年3月2日</li>
  <ul>
    <li>已经安装后运行SetupMinecraft.sh脚本现在将更新所有脚本并重新配置minecraftbe服务</li>
    <li>脚本现在可以在任何基于Debian的发行版（Ubuntu，Debian，Raspbian等）上运行<br>
    <li>为x86_64 QEMU仿真的 (Raspberry Pi)树莓派 等ARM平台添加了“非常慢”的支持</li>
    <li>将服务重命名为minecraft，以避免与Java版MC混淆</li>
  </ul>
  <li> 2019年2月15日</li>
  <ul>
    <li>现在备份压缩为.tar.gz格式（保存在备份文件夹中）</li>
    <li>启动服务最多等待20秒才能建立互联网连接，以便有时间让DHCP检索IP地址</li>
    <li>删除了stop.sh脚本上不必要的等待时间，以便在Minecraft服务器关闭后立即返回</li>
  </ul>
  <li> 2019年2月8日</li>
  <ul>
    <li>初始化</li>
  </ul>
</ul>
