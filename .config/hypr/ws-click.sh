#!/usr/bin/env bash
echo "$@" >> /tmp/waybar-ws-click.log
hyprctl dispatch "hl.dsp.focus({ workspace = \"$1\" })"
