#!/bin/sh

detect_display_server() {
  if [ -n "$WAYLAND_DISPLAY" ]; then
    echo "wayland"
  elif [ -n "$DISPLAY" ]; then
    echo "x11"
  else
    echo "unknown"
  fi
}

detect_compositor() {
  case "$(detect_display_server)" in
    wayland)
      if command -v hyprctl >/dev/null 2>&1 && hyprctl monitors >/dev/null 2>&1; then
        echo "hyprland"
      elif command -v swaymsg >/dev/null 2>&1 && swaymsg -t get_tree >/dev/null 2>&1; then
        echo "sway"
      else
        echo "wayland"
      fi
      ;;
    x11)
      if command -v i3-msg >/dev/null 2>&1 && i3-msg -t get_tree >/dev/null 2>&1; then
        echo "i3"
      else
        echo "x11"
      fi
      ;;
    *) echo "unknown" ;;
  esac
}

get_monitor_dimensions() {
  case "$(detect_compositor)" in
    hyprland)
      hyprctl monitors -j | jq -r '.[0] | "\(.width) \(.height)"'
      ;;
    sway)
      swaymsg -t get_outputs -j | jq -r '[.[] | select(.active)][0] | "\(.current_mode.width) \(.current_mode.height)"'
      ;;
    i3|x11)
      xdotool getdisplaygeometry 2>/dev/null | awk '{print $1, $2}'
      ;;
    *) echo "1920 1080" ;;
  esac
}

get_window_dimensions() {
  case "$(detect_compositor)" in
    hyprland)
      hyprctl activewindow -j | jq -r '"\(.size[0]) \(.size[1])"'
      ;;
    sway)
      swaymsg -t get_tree -j | jq -r '.. | select(.focused?) | "\(.rect.width) \(.rect.height)"'
      ;;
    i3)
      i3-msg -t get_tree -j | jq -r '.. | select(.focused?) | "\(.rect.width) \(.rect.height)"'
      ;;
    x11)
      eval "$(xdotool getactivewindow getwindowgeometry --shell 2>/dev/null)"
      echo "$WIDTH $HEIGHT"
      ;;
    *) echo "0 0" ;;
  esac
}

get_recordings_dir() {
  echo "${SCREENCAST_DIR:-$HOME/Videos/Screencast}"
}

get_audio_sink_monitor() {
  if [ -n "$SCREENREC_AUDIO_SINK" ]; then
    echo "$SCREENREC_AUDIO_SINK"
    return
  fi
  pactl get-default-sink 2>/dev/null | sed 's/$/.monitor/'
}

get_audio_source() {
  if [ -n "$SCREENREC_AUDIO_SOURCE" ]; then
    echo "$SCREENREC_AUDIO_SOURCE"
    return
  fi
  pactl get-default-source 2>/dev/null
}

copy_to_clipboard() {
  case "$(detect_display_server)" in
    wayland)
      wl-copy "$1"
      ;;
    x11)
      if command -v xclip >/dev/null 2>&1; then
        printf "%s" "$1" | xclip -selection clipboard
      elif command -v xsel >/dev/null 2>&1; then
        printf "%s" "$1" | xsel -ib
      else
        echo "No clipboard tool (install xclip or xsel)" >&2
        return 1
      fi
      ;;
  esac
}
