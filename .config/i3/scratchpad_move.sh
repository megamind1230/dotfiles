#!/bin/sh
WS="$1"
SCRATCH=$(i3-msg -t get_tree | jq '[.. | objects | select(.scratchpad_state != "none" and .focused == true and .window != null)] | length')

if [ "$SCRATCH" -gt 0 ]; then
    i3-msg "scratchpad show; move container to workspace \"$WS\"; workspace \"$WS\"; floating disable"
else
    i3-msg "move container to workspace \"$WS\"; workspace \"$WS\""
fi
