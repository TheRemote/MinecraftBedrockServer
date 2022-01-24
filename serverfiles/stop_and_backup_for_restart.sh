#!/bin/bash
if sudo screen -list | grep -q "\.servername"; then
    sudo screen -Rd servername -X stuff "say バックアップのため、25秒後にサーバーを閉じます。$(printf '\r')"
    sleep 25s
    sudo screen -Rd servername -X stuff "say サーバーを7秒後に閉じます$(printf '\r')"
    sleep 1s
    sudo screen -Rd servername -X stuff "say サーバーを6秒後に閉じます$(printf '\r')"
    sleep 1s
    sudo screen -Rd servername -X stuff "say サーバーを5秒後に閉じます$(printf '\r')"
    sleep 1s
    sudo screen -Rd servername -X stuff "say サーバーを4秒後に閉じます$(printf '\r')"
    sleep 1s
    sudo screen -Rd servername -X stuff "say サーバーを3秒後に閉じます$(printf '\r')"
    sleep 1s
    sudo screen -Rd servername -X stuff "say サーバーを2秒後に閉じます$(printf '\r')"
    sleep 1s
    sudo screen -Rd servername -X stuff "say サーバーを1秒後に閉じます$(printf '\r')"
    sleep 1s
fi
sudo systemctl stop servername
tar -Jcf /home/username/servername$(date '+%Y%m%d%H%M').tar.xz -C /home/username/ servername
rm /home/username/servername/*.log
