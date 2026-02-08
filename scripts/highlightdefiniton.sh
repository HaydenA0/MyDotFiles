word=$(wl-paste --primary)
notify-send -t 0 "$(python ~/dev/projects/definition/main.py "$word")"


