#!/usr/bin/bash
set -e

sudo pacman -Syu --noconfirm

sudo pacman -S --needed --noconfirm base-devel git

if ! command -v yay &> /dev/null; then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
    cd /tmp/yay-bin
    makepkg -si --noconfirm
    cd -
fi

if [ -f pacman_packages.txt ]; then
    echo "Installing official packages..."
    sudo pacman -S --needed --noconfirm - < pacman_packages.txt
fi

if [ -f aur_packages.txt ]; then
    echo "Installing AUR packages..."
    yay -S --needed --noconfirm - < aur_packages.txt
fi

echo "Installation complete!"
