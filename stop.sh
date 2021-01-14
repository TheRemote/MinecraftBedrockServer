#!/bin/bash
# James Chambers
# Minecraft Server stop script - primarily called by minecraft service but can be ran manually
# Minecraft 基岩版服务端停止脚本 由HeQuanX汉化

# Check if server is running
if ! screen -list | grep -q "servername"; then
  echo "服务器当前未运行!"
  exit 1
fi

# Get an optional custom countdown time (in minutes)
CountdownTime=0
while getopts ":t:" opt; do
  case $opt in
    t)
      case $OPTARG in
        ''|*[!0-9]*) 
          echo "倒计时(分钟)请输入整数."
          exit 1
          ;;
    *) 
          CountdownTime=$OPTARG >&2 
          ;;
      esac
      ;;
    \?)
      echo " 无效的参数: -$OPTARG; 倒计时必须是数字." >&2
      ;;
  esac
done

# Stop the server
while [ $CountdownTime -gt 0 ]; do
  if [ $CountdownTime -eq 1 ]; then
    screen -Rd servername -X stuff "say §c服务器将在§f60秒§c后关闭，请合理安排您的活动...$(printf '\r')"
    sleep 30;
    screen -Rd servername -X stuff "say §c服务器将在§f30秒§c后关闭，请合理安排您的活动...$(printf '\r')"
    sleep 20;
    screen -Rd servername -X stuff "say §c服务器将在§f10秒§c后关闭，请合理安排您的活动...$(printf '\r')"
    sleep 10;
  else
    screen -Rd servername -X stuff "say §c服务器将在§f$CountdownTime 分钟§c后关闭，请合理安排您的活动...$(printf '\r')"
    sleep 60;
    CountdownTime=$(( $CountdownTime - 1 ))
  fi
  echo "服务器将于 $CountdownTime 分钟后关闭..."
done
echo "停止 Minecraft 服务中 ..."
screen -Rd servername -X stuff "say 关闭服务器 (stop.sh called)...$(printf '\r')"
screen -Rd servername -X stuff "stop$(printf '\r')"

# Wait up to 20 seconds for server to close
StopChecks=0
while [ $StopChecks -lt 20 ]; do
  if ! screen -list | grep -q "servername"; then
    break
  fi
  sleep 1;
  StopChecks=$((StopChecks+1))
done

# Force quit if server is still open
if screen -list | grep -q "servername"; then
  echo "Minecraft服务器 servername 未能在20秒内正常关闭, 已使用 screen 强制终止"
  screen -S servername -X quit
fi

echo "Minecraft 服务器 servername 已经关闭"