#!/bin/bash

DIRECTION=$1


JSON=$(niri msg -j windows)




read -r CURRENT MIN MAX <<< $(echo "$JSON" | jq -r '
    (map(select(.is_focused)) | .[0]) as $focused |
    if $focused == null or $focused.layout.pos_in_scrolling_layout == null then
        "null null null"
    else
        (map(select(.workspace_id == $focused.workspace_id and .layout.pos_in_scrolling_layout != null)) 
        | map(.layout.pos_in_scrolling_layout[0])) as $cols |
        "\($focused.layout.pos_in_scrolling_layout[0]) \($cols | min) \($cols | max)"
    end
')


if [ "$CURRENT" == "null" ]; then
    if [ "$DIRECTION" == "right" ]; then
        niri msg action focus-column-right
    elif [ "$DIRECTION" == "left" ]; then
        niri msg action focus-column-left
    fi
    exit 0
fi


if [ "$DIRECTION" == "right" ]; then

    if [ "$CURRENT" -ge "$MAX" ]; then
        niri msg action focus-column-first
    else
        niri msg action focus-column-right
    fi

elif [ "$DIRECTION" == "left" ]; then

    if [ "$CURRENT" -le "$MIN" ]; then
        niri msg action focus-column-last
    else
        niri msg action focus-column-left
    fi
fi
