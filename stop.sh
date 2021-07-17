#!/bin/bash
# James Chambers - https://jamesachambers.com/minecraft-bedrock-edition-ubuntu-dedicated-server-guide/
# Minecraft Server stop script - primarily called by minecraft service but can be ran manually

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
   echo "This script is not meant to be run as root. Please run ./stop.sh as a non-root user, without sudo;  Exiting..."
   exit 1
fi

# Check if server is running
if ! screen -list | grep -q "\.servername"; then
  echo "Server is not currently running!"
  exit 1
fi

# Get an optional custom countdown time (in minutes)
CountdownTime=0
while getopts ":t:" opt; do
  case $opt in
    t)
      case $OPTARG in
        ''|*[!0-9]*)
          echo "Countdown time must be a whole number in minutes."
          exit 1
          ;;
        *)
          CountdownTime=$OPTARG >&2
          ;;
      esac
      ;;
    \?)
      echo "Invalid option: -$OPTARG; countdown time must be a whole number in minutes." >&2
      ;;
  esac
done

# Stop the server
while [[ $CountdownTime -gt 0 ]]; do
  if [[ $CountdownTime -eq 1 ]]; then
    screen -Rd servername -X stuff "say Stopping server in 60 seconds...$(printf '\r')"
    echo "Stopping server in 60 seconds..."
    sleep 30;
    screen -Rd servername -X stuff "say Stopping server in 30 seconds...$(printf '\r')"
    echo "Stopping server in 30 seconds..."
    sleep 20;
    screen -Rd servername -X stuff "say Stopping server in 10 seconds...$(printf '\r')"
    echo "Stopping server in 10 seconds..."
    sleep 10;
    CountdownTime=$((CountdownTime-1))
  else
    screen -Rd servername -X stuff "say Stopping server in $CountdownTime minutes...$(printf '\r')"
    echo "Stopping server in $CountdownTime minutes...$(printf '\r')"
    sleep 60;
    CountdownTime=$((CountdownTime-1))
  fi
  echo "Waiting for $CountdownTime more minutes ..."
done
echo "Stopping Minecraft server ..."
screen -Rd servername -X stuff "say Stopping server (stop.sh called)...$(printf '\r')"
screen -Rd servername -X stuff "stop$(printf '\r')"

# Wait up to 20 seconds for server to close
StopChecks=0
while [[ $StopChecks -lt 20 ]]; do
  if ! screen -list | grep -q "\.servername"; then
    break
  fi
  sleep 1;
  StopChecks=$((StopChecks+1))
done

# Force quit if server is still open
if screen -list | grep -q "\.servername"; then
  echo "Minecraft server still hasn't stopped after 20 seconds, closing screen manually"
  screen -S servername -X quit
fi

echo "Minecraft server servername stopped."
