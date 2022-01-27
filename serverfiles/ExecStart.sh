#!/bin/bash
if sudo screen -ls | grep -q "\.servername"; then
    exit 0
fi
sudo screen -L -Logfile /home/username/servername/$(date "+%Y%m%d%H%M").log -dmS servername /bin/bash -c 'serverstartcommand'
sleep 1s
sudo screen -Rd servername -X stuff "say サーバーを開始します$(printf '\r')"
python3 -u /home/username/servername/minecord.py
