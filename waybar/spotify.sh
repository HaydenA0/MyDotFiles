#!/bin/bash

TEMP_IMG="/tmp/spotify_cover.jpg"
TEMP_URL="/tmp/spotify_url_cache"
CSS_FILE="$HOME/.config/waybar/spotify_art.css"

if playerctl -p spotify status > /dev/null 2>&1; then
    URL=$(playerctl -p spotify metadata mpris:artUrl)
    if [[ ! -f "$TEMP_URL" ]] || [[ "$URL" != "$(cat "$TEMP_URL")" ]]; then
        curl -s -o "$TEMP_IMG" "$URL"
        echo "$URL" > "$TEMP_URL"
        echo "#custom-spotify tooltip { background-image: url('$TEMP_IMG'); }" > "$CSS_FILE"
        pkill -SIGUSR2 waybar
    fi
    playerctl -p spotify metadata --format "{{ xesam:album }} - {{ xesam:title }}"
else

    EMPTY_RULE="#custom-spotify tooltip { background-image: none; }"
    CURRENT_CONTENT=""
    if [[ -f "$CSS_FILE" ]]; then
        CURRENT_CONTENT=$(cat "$CSS_FILE")
    fi
    if [[ "$CURRENT_CONTENT" != "$EMPTY_RULE" ]]; then
         echo "$EMPTY_RULE" > "$CSS_FILE"
         rm -f "$TEMP_URL" 
         pkill -SIGUSR2 waybar
    fi
    echo "None"
fi
