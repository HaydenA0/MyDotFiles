#!/usr/bin/env bash

pacman -Qqen > pacman_packages.txt
pacman -Qqem > aur_packages.txt

git add pacman_packages.txt aur_packages.txt
git commit -m "Update package lists: $(date +'%Y-%m-%d %H:%M')"
git push origin main
