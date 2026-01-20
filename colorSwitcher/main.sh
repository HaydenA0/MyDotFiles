#!/bin/bash

WALLPAPER=$(fd . ./wallpapers --absolute-path | vicinae dmenu -p 'Pick a wallpaper...')

swww img $WALLPAPER

wal -i $WALLPAPER --saturate 0.1

fastfetch

