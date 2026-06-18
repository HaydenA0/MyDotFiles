#!/bin/bash

# Ensure required dependencies exist
for cmd in jq swaymsg stdbuf pgrep; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "ERROR: Required command '$cmd' is not installed. Please install it." >&2
        exit 1
    fi
done

# Function to dynamically find and set the active Sway socket
find_swaysock() {
    local uid
    uid=$(id -u)

    # 1. Test if the currently set SWAYSOCK environment variable is valid
    if [ -n "$SWAYSOCK" ] && [ -S "$SWAYSOCK" ] && swaymsg -t get_version >/dev/null 2>&1; then
        return 0
    fi

    # 2. Try to find the socket using the running Sway process ID
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
    echo "DEBUG: Cleanup triggered (SIGINT/SIGTERM). Cleaning up all marks..." >&2
    
    # Try to find a socket for cleanup commands
    if find_swaysock; then
        swaymsg '[con_id="*"] unmark _movement' 2>&1 | sed 's/^/  [swaymsg-cleanup1] /' >&2
        swaymsg '[con_id="*"] unmark _restore_fs' 2>&1 | sed 's/^/  [swaymsg-cleanup2] /' >&2
    else
        echo "WARNING: Could not clean up marks because no active Sway socket was found." >&2
    fi
    
    echo "DEBUG: Cleanup complete. Exiting." >&2
    exit 0
}
trap cleanup SIGINT SIGTERM

echo "DEBUG: Daemon started. PID: $$" >&2
echo "DEBUG: Listening for Sway window events. Try moving a fullscreen window now..." >&2

while true; do
    echo "DEBUG: Attempting to connect to Sway..." >&2
    
    # Detect the correct socket path
    if ! find_swaysock; then
        echo "ERROR: Unable to detect a running Sway socket. Retrying in 2 seconds..." >&2
        sleep 2
        continue
    fi
    
    echo "DEBUG: Connected successfully using socket: $SWAYSOCK" >&2
    
    # We pipe directly from swaymsg using line-buffering
    stdbuf -oL swaymsg -m -t subscribe '["window"]' 2>/dev/null | while read -r event; do
        
        # Validate that we received valid JSON
        if ! echo "$event" | jq -e . >/dev/null 2>&1; then
            echo "DEBUG: Received non-JSON or invalid line: $event" >&2
            continue
        fi

        # Parse basic fields
        change=$(echo "$event" | jq -r '.change // empty')
        container_id=$(echo "$event" | jq -r '.container.id // empty')
        container_name=$(echo "$event" | jq -r '.container.name // empty')
        
        echo "DEBUG: [Event Received] -> change: '$change' | container: '$container_name' (ID: $container_id)" >&2

        # -----------------------------------------------
        # Case A: Fullscreen state changed
        # -----------------------------------------------
        if [ "$change" = "fullscreen_mode" ]; then
            fullscreen_mode=$(echo "$event" | jq -r '.container.fullscreen_mode')
            marks=$(echo "$event" | jq -c '.container.marks')
            echo "DEBUG:   -> [fullscreen_mode] Mode is now '$fullscreen_mode' | Marks on window: $marks" >&2

            if [ "$fullscreen_mode" = "0" ]; then
                echo "DEBUG:   -> [fullscreen_mode] Window has exited fullscreen." >&2
                
                # Check if it has '_movement' mark
                if echo "$event" | jq -e '.container.marks | index("_movement")' >/dev/null 2>&1; then
                    echo "DEBUG:   -> [fullscreen_mode] '_movement' mark DETECTED! Preparing to tag with '_restore_fs'." >&2
                    
                    # Add '_restore_fs' mark
                    res_add=$(swaymsg "[con_id=$container_id] mark --add _restore_fs" 2>&1)
                    echo "DEBUG:     swaymsg add '_restore_fs' result: $res_add" >&2
                    
                    # Remove '_movement' mark
                    res_rem=$(swaymsg "[con_id=$container_id] unmark _movement" 2>&1)
                    echo "DEBUG:     swaymsg remove '_movement' result: $res_rem" >&2
                else
                    echo "DEBUG:   -> [fullscreen_mode] '_movement' mark NOT present. Ignoring." >&2
                fi
            fi

        # -----------------------------------------------
        # Case B: Focus changed
        # -----------------------------------------------
        elif [ "$change" = "focus" ]; then
            marks=$(echo "$event" | jq -c '.container.marks')
            echo "DEBUG:   -> [focus] Container focused | Marks on window: $marks" >&2

            if echo "$event" | jq -e '.container.marks | index("_restore_fs")' >/dev/null 2>&1; then
                echo "DEBUG:   -> [focus] '_restore_fs' mark DETECTED! Restoring fullscreen status..." >&2
                
                # Remove '_restore_fs' mark
                res_rem=$(swaymsg "[con_id=$container_id] unmark _restore_fs" 2>&1)
                echo "DEBUG:     swaymsg remove '_restore_fs' result: $res_rem" >&2
                
                # Enable fullscreen
                res_fs=$(swaymsg "[con_id=$container_id] fullscreen enable" 2>&1)
                echo "DEBUG:     swaymsg fullscreen enable result: $res_fs" >&2
            else
                echo "DEBUG:   -> [focus] Window doesn't have '_restore_fs' mark. Ignoring." >&2
            fi
        fi
    done
    
    echo "WARNING: Event subscription pipe broke. Reconnecting in 1 second..." >&2
    sleep 1
done
