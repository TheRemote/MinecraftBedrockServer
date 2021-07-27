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
if ! screen -list | grep -q "\.servername"; then
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
while [[ $StopChecks -lt 30 ]]; do
  if ! screen -list | grep -q "\.servername"; then
    break
  fi
  sleep 1;
  StopChecks=$((StopChecks+1))
done

if screen -list | grep -q "\.servername"; then
    # Server still hasn't stopped after 30s, tell Screen to close it
    echo "Minecraft server still hasn't closed after 30 seconds, closing screen manually"
    screen -S servername -X quit
    sleep 10
fi

# Start server (start.sh) - comment out if you want to use systemd and have added a line to your sudoers allowing passwordless sudo for the start command using 'sudo visudo' and insert the example line below with the correct username
#/bin/bash dirname/minecraftbe/servername/start.sh

# EXAMPLE SUDO LINE
# minecraftuser ALL=(ALL) NOPASSWD: /bin/systemctl start yourservername

# If you have added the above example sudo line to your sudoers file with 'sudo visudo' and the correct username uncomment the line below (make sure you comment out the /bin/bash dirname/minecraftbe/servername/start.sh line)
sudo -n systemctl start servername