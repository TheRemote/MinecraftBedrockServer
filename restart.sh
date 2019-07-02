#!/bin/bash
# James Chambers
# Minecraft Bedrock Server restart script

# Check if server is started
if ! screen -list | grep -q "servername"; then
    echo "Server is not currently running!"
    exit 1
fi

echo "Sending restart notifications to server..."

# Start countdown notice on server
screen -Rd servername -X stuff "say Server is restarting in 30 seconds! $(printf '\r')"
sleep 23s
screen -Rd servername -X stuff "say Server is restarting in 7 seconds! $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "say Server is restarting in 6 seconds! $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "say Server is restarting in 5 seconds! $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "say Server is restarting in 4 seconds! $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "say Server is restarting in 3 seconds! $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "say Server is restarting in 2 seconds! $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "say Server is restarting in 1 second! $(printf '\r')"
sleep 1s
screen -Rd servername -X stuff "say Closing server...$(printf '\r')"
screen -Rd servername -X stuff "stop$(printf '\r')"

echo "Closing server..."
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
    echo "Minecraft server still hasn't closed after 30 seconds, closing screen manually"
    screen -S servername -X quit
    sleep 10
fi

# Start server
/bin/bash dirname/minecraftbe/servername/start.sh