#!/usr/bin/env bash
f=$(find /mnt/hdd/Favorites -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) | shuf -n 1)
printf 'wallpaper {\n  monitor =\n  path = %s\n  fit_mode = cover\n}\n' "$f" > "$HOME/.config/hypr/hyprpaper.conf"
killall hyprpaper 2>/dev/null
exec hyprpaper
