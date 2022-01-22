#!/bin/bash
if sudo screen -list | grep -q "\.servername"; then
    exit 0
fi
sudo screen -L -Logfile /home/username/servername/$(date "+%Y%m%d%H%M").log -dmS servername /bin/bash -c 'serverstartcommand'
