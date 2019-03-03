#!/bin/bash
# James Chambers - March 2nd 2019
# Minecraft Server stop script - primarily called by minecraft service but can be ran manually

# Check if server is running
if ! screen -list | grep -q "minecraftbe"; then
  echo "Server is not currently running!"
  exit 1
fi

# Stop the server
echo "Stopping Minecraft server ..."
screen -Rd minecraftbe -X stuff "say Closing server (stop.sh called)...$(printf '\r')"
screen -Rd minecraftbe -X stuff "stop$(printf '\r')"

# Wait up to 20 seconds for server to close
StopChecks=0
while [ $StopChecks -lt 20 ]; do
  if ! screen -list | grep -q "minecraftbe"; then
    break
  fi
  sleep 1;
  ((StopChecks++))
done

# Force quit if server is still open
if screen -list | grep -q "minecraftbe"; then
  echo "Minecraft server still hasn't closed after 20 seconds, closing screen manually"
  screen -S minecraftbe -X quit
fi

echo "Minecraft server stopped."