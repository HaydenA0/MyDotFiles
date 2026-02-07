#!/bin/bash

WALLPAPER=$(fd . /home/anasr/.config/colorSwitcher/wallpapers --absolute-path | vicinae dmenu -p 'Pick a wallpaper...')

swww img $WALLPAPER

wal -i $WALLPAPER --saturate 0.3

fastfetch

