#!/bin/bash
# James Chambers - February 3rd 2019
# Minecraft Server stop script - primarily called by minecraft service but can be ran manually
screen -Rd minecraft -X stuff "say Closing server (stop.sh called)...$(printf '\r')"
screen -Rd minecraft -X stuff "save $(printf '\r')"
sleep 3s
screen -Rd minecraft -X stuff "stop $(printf '\r')"
sleep 10s

if screen -list | grep -q "minecraft"; then
  # Server hasn't closed after 10s, wait 10 more seconds
  sleep 10s

  # Server still hasn't stopped after 20s, tell Screen to close it
  if screen -list | grep -q "minecraft"; then
    echo "Minecraft server still hasn't closed after 20 seconds, closing screen manually"
    screen -S minecraft -X quit
  fi
fi