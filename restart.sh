#!/bin/bash
# James Chambers - February 15th 2019
# Minecraft Bedrock Server restart script

# Check if server is started
if ! screen -list | grep -q "minecraft"; then
    echo "Server is not currently running!"
    exit 1
fi

# Start countdown notice on server
screen -Rd minecraft -X stuff "say Server is restarting in 30 seconds! $(printf '\r')"
sleep 23s
screen -Rd minecraft -X stuff "say Server is restarting in 7 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Server is restarting in 6 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Server is restarting in 5 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Server is restarting in 4 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Server is restarting in 3 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Server is restarting in 2 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Server is restarting in 1 second! $(printf '\r')"
sleep 1s
screen -Rd minecraft -X stuff "say Closing server...$(printf '\r')"
screen -Rd minecraft -X stuff "stop $(printf '\r')"
sleep 10s

if screen -list | grep -q "minecraft"; then
    # Server still hasn't stopped after 10s, tell Screen to close it
    echo "Minecraft server still hasn't closed after 10 seconds, closing screen manually"
    screen -S minecraft -X quit
fi

# Start server
/bin/bash /home/replace/minecraft/start.sh