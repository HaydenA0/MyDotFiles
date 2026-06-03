#!/bin/bash


CURRENT_DIR=$(pwd)
WALLPAPER_DIR="$CURRENT_DIR/wallpapersproper"


if [ ! -d "$WALLPAPER_DIR" ]; then
    echo "Directory not found: $WALLPAPER_DIR"
    exit 1
fi


SELECTED=$(fd . "$WALLPAPER_DIR" | vicinae dmenu)


if [ -n "$SELECTED" ]; then
    FULL_PATH="$WALLPAPER_DIR/$SELECTED"
    echo "Selected: $FULL_PATH"
    
    awww img "$FULL_PATH" 
fi
