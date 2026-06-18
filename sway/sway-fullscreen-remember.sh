#!/bin/bash

# Ensure required dependencies exist
for cmd in jq swaymsg stdbuf pgrep; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        exit 1
    fi
done

# Function to dynamically find and set the active Sway socket
find_swaysock() {
    local uid
    uid=$(id -u)

    # 1. Test if the currently set SWAYSOCK is valid
    if [ -n "$SWAYSOCK" ] && [ -S "$SWAYSOCK" ] && swaymsg -t get_version >/dev/null 2>&1; then
        return 0
    fi

    # 2. Try the running Sway process ID
    local sway_pid
    sway_pid=$(pgrep -x sway | head -n 1)
    if [ -n "$sway_pid" ]; then
        local socket_path="/run/user/$uid/sway-ipc.$uid.$sway_pid.sock"
        if [ -S "$socket_path" ]; then
            export SWAYSOCK="$socket_path"
            return 0
        fi
    fi

    # 3. Fallback: Find the newest sway-ipc socket file in /run/user/UID
    local newest_socket
    newest_socket=$(ls -t /run/user/"$uid"/sway-ipc.*.sock 2>/dev/null | head -n 1)
    if [ -n "$newest_socket" ] && [ -S "$newest_socket" ]; then
        export SWAYSOCK="$newest_socket"
        return 0
    fi

    return 1
}

cleanup() {
    if find_swaysock; then
        swaymsg '[con_mark="_movement"] unmark _movement' >/dev/null 2>&1
        swaymsg '[con_mark="_restore_fs"] unmark _restore_fs' >/dev/null 2>&1
    fi
    exit 0
}
trap cleanup SIGINT SIGTERM

while true; do
    if ! find_swaysock; then
        sleep 2
        continue
    fi
    
    stdbuf -oL swaymsg -m -t subscribe '["window"]' 2>/dev/null | \
      stdbuf -oL jq --unbuffered -c 'select(.change == "fullscreen_mode" or .change == "focus")' 2>/dev/null | \
      while read -r event; do
        
        change=$(echo "$event" | jq -r '.change // empty')
        container_id=$(echo "$event" | jq -r '.container.id // empty')

        if [ "$change" = "fullscreen_mode" ]; then
            fullscreen_mode=$(echo "$event" | jq -r '.container.fullscreen_mode')
            if [ "$fullscreen_mode" = "0" ] && \
               echo "$event" | jq -e '.container.marks | index("_movement")' >/dev/null 2>&1; then
                swaymsg "[con_id=$container_id] mark --add _restore_fs" >/dev/null 2>&1
                swaymsg "[con_id=$container_id] unmark _movement" >/dev/null 2>&1
            fi
        elif [ "$change" = "focus" ]; then
            if echo "$event" | jq -e '.container.marks | index("_restore_fs")' >/dev/null 2>&1; then
                swaymsg "[con_id=$container_id] unmark _restore_fs" >/dev/null 2>&1
                swaymsg "[con_id=$container_id] fullscreen enable" >/dev/null 2>&1
            fi
        fi
    done
    sleep 1
done
