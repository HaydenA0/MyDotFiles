# Start Hyprland on tty1 only
if [[ -z "$WAYLAND_DISPLAY" && "$XDG_VTNR" -eq 1 ]]; then
  exec Hyprland
fi

