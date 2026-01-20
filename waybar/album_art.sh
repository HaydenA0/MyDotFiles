#!/bin/bash

# 1. Define the specific player (Fixes the WhatsApp issue)
PLAYER="spotify"

# 2. Path to save the temporary cover art
COVER="/tmp/spotify_cover_big.jpg"

# 3. Check if Spotify is actually running
STATUS=$(playerctl -p $PLAYER status 2>/dev/null)

if [ "$STATUS" = "Playing" ] || [ "$STATUS" = "Paused" ]; then
    
    # Get the Art URL specifically from Spotify
    URL=$(playerctl -p $PLAYER metadata mpris:artUrl)
    
    # If the URL is valid
    if [[ -n "$URL" ]]; then
        # Download the image (silently)
        curl -s -o "$COVER" "$URL"
        
        # 4. KILL any existing art window (so they don't pile up)
        pkill imv
        
        # 5. Open the image "Waaaaaay Bigger"
        # We start imv in the background
        imv "$COVER" &
    else
        notify-send "Spotify" "No album art found."
    fi
else
    notify-send "Spotify" "Not playing."
fi
