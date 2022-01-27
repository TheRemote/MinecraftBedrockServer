#!/bin/bash
if ! sudo screen -list | grep -q "\.servername"; then
    exit 0
fi
sudo screen -Rd servername -X stuff "say サーバーを閉じます...$(printf '\r')"
sleep 10s
sudo screen -Rd servername -X stuff "stop$(printf '\r')"
StopChecks=0
while [[ $StopChecks -lt 10 ]]; do
    if ! sudo screen -list | grep -q "\.servername"; then
        break
    fi
    sleep 1
    StopChecks=$((StopChecks + 1))
done
if sudo screen -list | grep -q "\.servername"; then
    sudo screen -S servername -X quit
fi
