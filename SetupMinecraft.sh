#!/bin/bash
# Minecraft Server Installation Script - James A. Chambers - https://jamesachambers.com
#
# Instructions: https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/
# To run the setup script use:
# wget https://raw.githubusercontent.com/TheRemote/MinecraftBedrockServer/master/SetupMinecraft.sh
# chmod +x SetupMinecraft.sh
# ./SetupMinecraft.sh
#
#
# 如果你在国内受到GFW或其他原因的影响无法正常使用GitHub 请使用以下作为替代
# wget https://gitee.com/crabapples/MinecraftBedrockServer/raw/zh_cn/SetupMinecraft.sh
# chmod +x SetupMinecraft.sh
# ./SetupMinecraft.sh
#
# GitHub Repository: https://github.com/TheRemote/MinecraftBedrockServer
# GitHub Repository(zh_cn): https://github.com/HeQuanX/MinecraftBedrockServer
# Gitee Repository(zh_cn): https://gitee.com/crabapples/MinecraftBedrockServer

echo "Minecraft 基岩版服务端安装脚本 作者:James Chambers "
echo "Minecraft 基岩版服务端安装脚本 汉化:HeQuanX"
echo "最新版本请访问 https://github.com/TheRemote/MinecraftBedrockServer"
echo "最新汉化版本请访问 https://github.com/HeQuanX/MinecraftBedrockServer"
echo "最新汉化版本镜像(如github链接失败时)请访问 https://gitee.com/crabapples/MinecraftBedrockServer"
echo "请在防火墙控制中打开对应端口! 默认端口号为 19132"

# Function to read input from user with a prompt
function read_with_prompt {
  variable_name="$1"
  prompt="$2"
  default="${3-}"
  unset $variable_name
  while [[ ! -n ${!variable_name} ]]; do
    read -p "$prompt: " $variable_name < /dev/tty
    if [ ! -n "`which xargs`" ]; then
      declare -g $variable_name=$(echo "${!variable_name}" | xargs)
    fi
    declare -g $variable_name=$(echo "${!variable_name}" | head -n1 | awk '{print $1;}')
    if [[ -z ${!variable_name} ]] && [[ -n "$default" ]] ; then
      declare -g $variable_name=$default
    fi
    echo -n "$prompt : ${!variable_name} -- 确定要使用吗 (y/n)?"
    read answer < /dev/tty
    if [ "$answer" == "${answer#[Yy]}" ]; then
      unset $variable_name
    else
      echo "$prompt: ${!variable_name}"
    fi
  done
}

# Check to make sure we aren't being ran as root
if [ $(id -u) = 0 ]; then
   echo "检测到脚本正在使用 root 或 sudo运行。请使用普通用户运行 ./SetupMinecraft.sh。(如果你知道你在干什么，并且确认要这样做，请自行修改 SetupMinecraft.sh中的检测脚本) 安装脚本即将终止..."
   exit 1
fi

# Install dependencies required to run Minecraft server in the background
echo "Installing screen, unzip, sudo, net-tools, wget.."
if [ ! -n "`which sudo`" ]; then
  apt-get update && apt-get install sudo -y
fi
sudo apt-get update
sudo apt-get install screen unzip wget -y
sudo apt-get install net-tools -y
sudo apt-get install libcurl4 -y
sudo apt-get install openssl -y

# Check to see if Minecraft server main directory already exists
cd ~
if [ ! -d "minecraftbe" ]; then
  echo "if"
  mkdir minecraftbe
  cd minecraftbe
else
  echo "else"
  cd minecraftbe
  if [ -f "bedrock_server" ]; then
    echo "迁移旧的基岩服务器至 minecraftbe/old"
    cd ~
    mv minecraftbe old
    mkdir minecraftbe
    mv old minecraftbe/old
    cd minecraftbe
    echo "迁移完成，旧的服务器位置为 minecraftbe/old"
  fi
fi

# Server name configuration
echo "请输入你的服务器名称(新建或使用已经存在的地图):"
echo "这将会作为服务器使用的目录名..."

read_with_prompt ServerName "服务器名称"

echo "请输入 IPV4 端口号 (默认 19132，如无特殊情况建议不要修改): "
read_with_prompt PortIPV4 "IPV4 端口号" 19132

echo "请输入 IPV6 端口号 (默认 19133，如无特殊情况建议不要修改): "
read_with_prompt PortIPV6 "IPV6 端口号" 19133

if [ -d "$ServerName" ]; then
  echo "目录 minecraftbe/$ServerName 已经存在! 正在更新脚本和配置中..."

  # Get Home directory path and username
  DirName=$(readlink -e ~)
  UserName=$(whoami)
  cd ~
  cd minecraftbe
  cd $ServerName
  echo "服务器路径为: $DirName/minecraftbe/$ServerName"

  # Remove existing scripts
  rm start.sh stop.sh restart.sh

  # Download start.sh from repository
  echo "正在从仓库获取启动脚本 start.sh ..."
  wget -O start.sh https://gitee.com/crabapples/MinecraftBedrockServer/raw/zh_cn/start.sh
  chmod +x start.sh
  sed -i "s:dirname:$DirName:g" start.sh
  sed -i "s:servername:$ServerName:g" start.sh

  # Download stop.sh from repository
  echo "正在从仓库获取停止脚本 stop.sh ..."
  wget -O stop.sh https://gitee.com/crabapples/MinecraftBedrockServer/raw/zh_cn/stop.sh
  chmod +x stop.sh
  sed -i "s:dirname:$DirName:g" stop.sh
  sed -i "s:servername:$ServerName:g" stop.sh

  # Download restart.sh from repository
  echo "正在从仓库获取重启脚本 restart.sh ..."
  wget -O restart.sh https://gitee.com/crabapples/MinecraftBedrockServer/raw/zh_cn/restart.sh
  chmod +x restart.sh
  sed -i "s:dirname:$DirName:g" restart.sh
  sed -i "s:servername:$ServerName:g" restart.sh

  # Update minecraft server service
  echo "配置服务器: $ServerName 中..."
  sudo wget -O /etc/systemd/system/$ServerName.service https://gitee.com/crabapples/MinecraftBedrockServer/raw/zh_cn/minecraftbe.service
  sudo chmod +x /etc/systemd/system/$ServerName.service
  sudo sed -i "s/replace/$UserName/g" /etc/systemd/system/$ServerName.service
  sudo sed -i "s:dirname:$DirName:g" /etc/systemd/system/$ServerName.service
  sudo sed -i "s:servername:$ServerName:g" /etc/systemd/system/$ServerName.service
  sed -i "/server-port=/c\server-port=$PortIPV4" server.properties
  sed -i "/server-portv6=/c\server-portv6=$PortIPV6" server.properties
  sudo systemctl daemon-reload
  echo -n "是否设置 Minecraft 服务器开机自动启动 (y/n)?"
  read answer < /dev/tty
  if [ "$answer" != "${answer#[Yy]}" ]; then
    sudo systemctl enable $ServerName.service

    # Automatic reboot at 4am configuration
    echo -n "是否需要在每天 4:00 自动备份数据并重启服务器 (y/n)?"
    read answer < /dev/tty
    if [ "$answer" != "${answer#[Yy]}" ]; then
      croncmd="$DirName/minecraftbe/$ServerName/restart.sh"
      cronjob="0 4 * * * $croncmd"
      ( crontab -l | grep -v -F "$croncmd" ; echo "$cronjob" ) | crontab -
      echo "自动备份配置完成， 如果需要修改时间或关闭自动备份请使用 crontab -e 自行修改"
    fi
  fi

  # Setup completed
  echo "安装已经完成.  正在启动服务器 Minecraft $ServerName ..."
  sudo systemctl start $ServerName.service

  # Sleep for 4 seconds to give the server time to start
  sleep 4s

  screen -r $ServerName

  exit 0
fi

# Create server directory
echo "正在创建服务器工作目录 (~/minecraftbe/$ServerName)..."
cd ~
cd minecraftbe
mkdir $ServerName
cd $ServerName
mkdir downloads
mkdir backups
mkdir logs

# Check CPU archtecture to see if we need to do anything special for the platform the server is running on
echo "正在获取CPU信息..."
CPUArch=$(uname -m)
echo "系统架构为: $CPUArch"

# Check for ARM architecture
if [[ "$CPUArch" == *"aarch"* || "$CPUArch" == *"arm"* ]]; then
  # ARM architecture detected -- download QEMU and dependency libraries
  echo "检测到CPU为ARM架构，正在安装所需依赖文件..."
  # Check if latest available QEMU version is at least 3.0 or higher
  QEMUVer=$(apt-cache show qemu-user-static | grep Version | awk 'NR==1{ print $2 }' | cut -c3-3)
  if [[ "$QEMUVer" -lt "3" ]]; then
    echo "当前QEMU 版本 不支持模拟x86_64. 请更新 QEMU 的版本后重试."
    exit
  else
    sudo apt-get install qemu-user-static binfmt-support -y
  fi

  if [ -n "`which qemu-x86_64-static`" ]; then
    echo "QEMU-x86_64-static 安装成功"
  else
    echo "QEMU-x86_64-static 安装失败 ，上述为相关错误信息."
    exit 1
  fi
  
  # Retrieve depends.zip from GitHub repository
  wget -O depends.zip https://gitee.com/crabapples/MinecraftBedrockServer/raw/zh_cn/depends.zip
  unzip depends.zip
  sudo mkdir /lib64
  # Create soft link ld-linux-x86-64.so.2 mapped to ld-2.31.so
  sudo ln -s ~/minecraftbe/$ServerName/ld-2.31.so /lib64/ld-linux-x86-64.so.2
fi

# Check for x86 (32 bit) architecture
if [[ "$CPUArch" == *"i386"* || "$CPUArch" == *"i686"* ]]; then
  # ARM architecture detected -- download QEMU and dependency libraries
  echo "检测到CPU为32位，正在安装所需依赖文件..."
  # Check if latest available QEMU version is at least 3.0 or higher
  QEMUVer=$(apt-cache show qemu-user-static | grep Version | awk 'NR==1{ print $2 }' | cut -c3-3)
  if [[ "$QEMUVer" -lt "3" ]]; then
    echo "当前QEMU 版本 不支持模拟x86_64. 请更新 QEMU 的版本后重试."
    exit
  else
    sudo apt-get install qemu-user-static binfmt-support -y
  fi

  if [ -n "`which qemu-x86_64-static`" ]; then
    echo "QEMU-x86_64-static 安装成功"
  else
    echo "QEMU-x86_64-static 安装失败 ，上述为相关错误信息."
    exit 1
  fi
  
  # Retrieve depends.zip from GitHub repository
  wget -O depends.zip https://gitee.com/crabapples/MinecraftBedrockServer/raw/zh_cn/depends.zip
  unzip depends.zip
  sudo mkdir /lib64
  # Create soft link ld-linux-x86-64.so.2 mapped to ld-2.31.so
  sudo ln -s ~/minecraftbe/$ServerName/ld-2.31.so /lib64/ld-linux-x86-64.so.2
fi

# Retrieve latest version of Minecraft Bedrock dedicated server
echo "正在检查 Minecraft 基岩版服务器是否有更新..."
wget -O downloads/version.html https://minecraft.net/en-us/download/server/bedrock/
DownloadURL=$(grep -o 'https://minecraft.azureedge.net/bin-linux/[^"]*' downloads/version.html)
DownloadFile=$(echo "$DownloadURL" | sed 's#.*/##')
echo "$DownloadURL"
echo "$DownloadFile"

# Download latest version of Minecraft Bedrock dedicated server
echo "正在下载 Minecraft 基岩版最新服务器..."
UserName=$(whoami)
DirName=$(readlink -e ~)
wget -O "downloads/$DownloadFile" "$DownloadURL"
unzip -o "downloads/$DownloadFile"

# Download start.sh from repository
echo "正在从仓库获取启动脚本 start.sh ..."
wget -O start.sh https://gitee.com/crabapples/MinecraftBedrockServer/raw/zh_cn/start.sh
chmod +x start.sh
sed -i "s:dirname:$DirName:g" start.sh
sed -i "s:servername:$ServerName:g" start.sh

# Download stop.sh from repository
echo "正在从仓库获取停止脚本 stop.sh..."
wget -O stop.sh https://gitee.com/crabapples/MinecraftBedrockServer/raw/zh_cn/stop.sh
chmod +x stop.sh
sed -i "s:dirname:$DirName:g" stop.sh
sed -i "s:servername:$ServerName:g" stop.sh

# Download restart.sh from repository
echo "正在从仓库获取重启脚本 restart.sh..."
wget -O restart.sh https://gitee.com/crabapples/MinecraftBedrockServer/raw/zh_cn/restart.sh
chmod +x restart.sh
sed -i "s:dirname:$DirName:g" restart.sh
sed -i "s:servername:$ServerName:g" restart.sh

# Service configuration
echo "Configuring Minecraft $ServerName service..."
sudo wget -O /etc/systemd/system/$ServerName.service https://gitee.com/crabapples/MinecraftBedrockServer/raw/zh_cn/minecraftbe.service
sudo chmod +x /etc/systemd/system/$ServerName.service
sudo sed -i "s/replace/$UserName/g" /etc/systemd/system/$ServerName.service
sudo sed -i "s:dirname:$DirName:g" /etc/systemd/system/$ServerName.service
sudo sed -i "s:servername:$ServerName:g" /etc/systemd/system/$ServerName.service
sed -i "/server-port=/c\server-port=$PortIPV4" server.properties
sed -i "/server-portv6=/c\server-portv6=$PortIPV6" server.properties
sudo systemctl daemon-reload

echo -n "是否设置 Minecraft 服务器开机自动启动 (y/n)?"
read answer < /dev/tty
if [ "$answer" != "${answer#[Yy]}" ]; then
  sudo systemctl enable $ServerName.service

  # Automatic reboot at 4am configuration
  TimeZone=$(cat /etc/timezone)
  CurrentTime=$(date)
  echo "你当前的时区为 $TimeZone.  当前系统时间为: $CurrentTime"
  echo "您可以使用 crontab -e 或再次运行setupmincraft .sh来调整或者删除所设置的重启时间。"
  echo -n "是否需要在每天 4:00 自动备份数据并重启服务器 (y/n)?"
  read answer < /dev/tty
  if [ "$answer" != "${answer#[Yy]}" ]; then    
    croncmd="$DirName/minecraftbe/$ServerName/restart.sh"
    cronjob="0 4 * * * $croncmd"
    ( crontab -l | grep -v -F "$croncmd" ; echo "$cronjob" ) | crontab -
    echo "自动备份配置完成， 如果需要修改时间或关闭自动备份请使用 crontab -e 自行修改"
  fi
fi

# Finished!
echo "安装已经完成.  正在启动服务器 Minecraft $ServerName ..."
sudo systemctl start $ServerName.service

# Wait up to 20 seconds for server to start
StartChecks=0
while [ $StartChecks -lt 20 ]; do
  if screen -list | grep -q "$ServerName"; then
    break
  fi
  sleep 1;
  StartChecks=$((StartChecks+1))
done

# Force quit if server is still open
if ! screen -list | grep -q "$ServerName"; then
  echo "Minecraft 未能在20秒内启动成功."
else
  echo "服务器已经成功启动.  你可以使用 screen -r $ServerName 来查看正在运行的服务"
fi

# Attach to screen
screen -r $ServerName
