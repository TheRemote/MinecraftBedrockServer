#!/bin/bash
# author James Chambers
# Minecraft 基岩版服务端重启脚本 由HeQuanX汉化

# Check if server is started
if ! screen -list | grep -q "servername"; then
    echo "服务尚未运行"
    exit 1
fi

echo "正在向服务器发送关闭通知..."

# Start countdown notice on server
echo "服务器将在30秒后重启"
screen -Rd servername -X stuff "say §c服务器将在§f30秒§c后重启，请合理安排您的活动 $(printf '\r')"
sleep 23s
screen -Rd servername -X stuff "say §c服务器将在§f7秒§c后重启，请合理安排您的活动 $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "say §c服务器将在§f6秒§c后重启，请合理安排您的活动 $(printf '\r')"
sleep 1s
echo "服务器将在5秒后重启"
screen -Rd servername -X stuff "say §c服务器将在§f5秒§c后重启，请合理安排您的活动 $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "say §c服务器将在§f4秒§c后重启，请合理安排您的活动 $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "say §c服务器将在§f3秒§c后重启，请合理安排您的活动 $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "say §c服务器将在§f2秒§c后重启，请合理安排您的活动 $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "say §c服务器将在§f1秒§c后重启，请合理安排您的活动 $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "say 关闭服务器$(printf '\r')"
screen -Rd servername -X stuff "stop$(printf '\r')"

echo "关闭服务器..."
# Wait up to 30 seconds for server to close
StopChecks=0
while [ $StopChecks -lt 30 ]; do
  if ! screen -list | grep -q "servername"; then
    break
  fi
  sleep 1;
  StopChecks=$((StopChecks+1))
done

if screen -list | grep -q "servername"; then
    # Server still hasn't stopped after 30s, tell Screen to close it
    echo "Minecraft 服务未能在30秒内正常关闭, 已使用 screen 强制关闭"
    screen -S servername -X quit
    sleep 10
fi

# Start server
/bin/bash dirname/minecraftbe/servername/start.sh