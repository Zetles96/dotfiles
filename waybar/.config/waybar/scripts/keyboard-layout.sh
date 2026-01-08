#!/bin/bash
exec 2>/dev/null

while true; do
    layout=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap' | cut -c1-2 | tr 'a-z' 'A-Z')
    echo "{\"text\": \"$layout\", \"tooltip\": \"Keyboard Layout\"}"
    sleep 0.5
done
