#!/bin/bash
# James Chambers - https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/
# Minecraft Bedrock Server restart script

# Set path variable
USERPATH="pathvariable"
PathLength=${#USERPATH}
if [[ "$PathLength" -gt 12 ]]; then
  PATH="$USERPATH"
else
  echo "Unable to set path variable.  You likely need to download an updated version of SetupMinecraft.sh from GitHub!"
fi

# Check to make sure we aren't running as root
if [[ $(id -u) = 0 ]]; then
  echo "This script is not meant to be run as root. Please run ./restart.sh as a non-root user, without sudo;  Exiting..."
  exit 1
fi

# Check if server is started
if [ viewmanager == screen ]; then
  if ! screen -list | grep -q '\.servername\s'; then
    echo "Server is not currently running!"
    exit 1
  fi
elif [ viewmanager == tmux ]; then
  if ! tmux list-sessions -F "#{session_name} #{window_name} (created #{session_created})" | awk -F " " '{printf "%s: %s (%s)\n", $1, $2, strftime("%Y-%m-%d %H:%M:%S", $4)}' | sed 's/ (created [0-9]*)//' | tr -s ' ' | grep -q "^MinecraftBedrockServer: servername"; then
    echo "Server is not currently running!"
    exit 1
  fi
fi

echo "Sending restart notifications to server..."

# Start countdown notice on server
if [ viewmanager == screen ]; then
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
elif [ viewmanager == tmux ]; then
  tmux attach -d -t MinecraftBedrockServer:0 \; \
  send-keys "echo Server is restarting in 30 seconds!" C-m \; \
  send-keys 'sleep 23s' C-m \; \
  send-keys "echo Server is restarting in 7 seconds!" C-m \; \
  send-keys 'sleep 1s' C-m \; \
  send-keys "echo Server is restarting in 6 seconds!" C-m \; \
  send-keys 'sleep 1s' C-m \; \
  send-keys "echo Server is restarting in 5 seconds!" C-m \; \
  send-keys 'sleep 1s' C-m \; \
  send-keys "echo Server is restarting in 4 seconds!" C-m \; \
  send-keys 'sleep 1s' C-m \; \
  send-keys "echo Server is restarting in 3 seconds!" C-m \; \
  send-keys 'sleep 1s' C-m \; \
  send-keys "echo Server is restarting in 2 seconds!" C-m \; \
  send-keys 'sleep 1s' C-m \; \
  send-keys "echo Server is restarting in 1 second!" C-m \; \
  send-keys 'sleep 1s' C-m \; \
  send-keys "echo Closing server..." C-m \; \
  send-keys 'stop' C-m
if

echo "Closing server..."
# Wait up to 30 seconds for server to close
StopChecks=0
while [[ $StopChecks -lt 30 ]]; do
  if [ viewmanager == screen ]; then
    if ! screen -list | grep -q '\.servername\s'; then
      break
    fi
    sleep 1
    StopChecks=$((StopChecks + 1))
  elif [ viewmanager == tmux ]; then
    if ! tmux list-sessions -F "#{session_name} #{window_name} (created #{session_created})" | awk -F " " '{printf "%s: %s (%s)\n", $1, $2, strftime("%Y-%m-%d %H:%M:%S", $4)}' | sed 's/ (created [0-9]*)//' | tr -s ' ' | grep -q "^MinecraftBedrockServer: servername"; then
      break
    fi
    sleep 1
    StopChecks=$((StopChecks + 1))
  fi
done

if [ viewmanager == screen ]; then
  if screen -list | grep -q '\.servername\s'; then
    # Server still hasn't stopped after 30s, tell Screen to close it
    echo "Minecraft server still hasn't closed after 30 seconds, closing screen manually"
    screen -S servername -X quit
    sleep 10
  fi
elif [ viewmanager 

# Start server (start.sh) - comment out if you want to use systemd and have added a line to your sudoers allowing passwordless sudo for the start command using 'sudo visudo' and insert the example line below with the correct username
#/bin/bash dirname/minecraftbe/servername/start.sh

# EXAMPLE SUDO LINE
# minecraftuser ALL=(ALL) NOPASSWD: /bin/systemctl start yourservername

# If you have added the above example sudo line to your sudoers file with 'sudo visudo' and the correct username uncomment the line below (make sure you comment out the /bin/bash dirname/minecraftbe/servername/start.sh line)
sudo -n systemctl start servername
