#!/bin/bash
# James Chambers - March 2nd 2019
# Minecraft Bedrock Server restart script

# Check if server is started
if ! screen -list | grep -q "minecraftbe"; then
    echo "Server is not currently running!"
    exit 1
fi

echo "Sending restart notifications to server..."

# Start countdown notice on server
screen -Rd minecraftbe -X stuff "say Server is restarting in 30 seconds! $(printf '\r')"
sleep 23s
screen -Rd minecraftbe -X stuff "say Server is restarting in 7 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraftbe -X stuff "say Server is restarting in 6 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraftbe -X stuff "say Server is restarting in 5 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraftbe -X stuff "say Server is restarting in 4 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraftbe -X stuff "say Server is restarting in 3 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraftbe -X stuff "say Server is restarting in 2 seconds! $(printf '\r')"
sleep 1s
screen -Rd minecraftbe -X stuff "say Server is restarting in 1 second! $(printf '\r')"
sleep 1s
screen -Rd minecraftbe -X stuff "say Closing server...$(printf '\r')"
screen -Rd minecraftbe -X stuff "stop $(printf '\r')"

echo "Closing server..."
# Wait up to 30 seconds for server to close
StopChecks=0
while [ $StopChecks -lt 30 ]; do
  if ! /usr/bin/screen -list | /bin/grep -q "minecraftbe"; then
    break
  fi
  /bin/sleep 1;
  ((StopChecks++))
done

if screen -list | grep -q "minecraftbe"; then
    # Server still hasn't stopped after 30s, tell Screen to close it
    echo "Minecraft server still hasn't closed after 30 seconds, closing screen manually"
    screen -S minecraftbe -X quit
fi

# Start server
/bin/bash dirname/minecraftbe/start.sh