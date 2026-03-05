#!/bin/bash

# Step 1: Run pipes.sh for 4 seconds
pipes.sh -p 4 -t 1 -c 6 -r 99999 -s 50 &
PIPES_PID=$!
sleep 4
kill $PIPES_PID 2>/dev/null
clear

# Step 2: Change wallpaper
IMG=$(find "$HOME/Pictures/wallpapers" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)
swww img "$IMG" --transition-type fade &

# Step 3: Run tron intro
~/.config/hypr/tron-intro.sh