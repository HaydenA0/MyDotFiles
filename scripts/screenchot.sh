#!/bin/zsh

# Select a region
region=$(slurp)

if [[ -z "$region" ]]; then
    echo "No region selected."
    exit 1
fi

# Save temporary screenshot
tmpfile=$(mktemp --suffix=.png)
grim -g "$region" "$tmpfile"

# Open in Swappy for annotation
swappy -f "$tmpfile"

