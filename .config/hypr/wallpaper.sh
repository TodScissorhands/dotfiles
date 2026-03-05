#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
INTERVAL=300
STATE_FILE="/tmp/wallpaper_index"

# Get sorted list of wallpapers
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | sort)
TOTAL=${#WALLPAPERS[@]}

if [ "$1" = "next" ]; then
    # Read current index
    INDEX=$(cat "$STATE_FILE" 2>/dev/null || echo 0)
    INDEX=$(( (INDEX + 1) % TOTAL ))
    echo "$INDEX" > "$STATE_FILE"
    swww img "${WALLPAPERS[$INDEX]}" --transition-type fade
    exit 0
fi

FIRST=true
INDEX=0

while true; do
    if $FIRST; then
        swww img "${WALLPAPERS[$INDEX]}" --transition-type none
        FIRST=false
    else
        INDEX=$(( (INDEX + 1) % TOTAL ))
        echo "$INDEX" > "$STATE_FILE"
        swww img "${WALLPAPERS[$INDEX]}" --transition-type fade
    fi
    sleep $INTERVAL
done