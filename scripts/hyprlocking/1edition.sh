#!/usr/bin/env bash

# Find preferred player (Firefox > Spotify > mpv)
PLAYER=$(playerctl -l | grep -E 'firefox|spotify|mpv' | head -n1)
PLAYER=${PLAYER:-$(playerctl -l | head -n1)} # fallback

# Exit if no player found
if [[ -z "$PLAYER" ]]; then
  echo ""
  exit 1
fi

# Clean player name for --source output
PLAYER_CLEAN=${PLAYER%%.*} # remove everything after first dot

# Get metadata
TITLE=$(playerctl --player="$PLAYER" metadata xesam:title)
ARTIST=$(playerctl --player="$PLAYER" metadata xesam:artist | tr -d '[]')
ART_URL=$(playerctl --player="$PLAYER" metadata mpris:artUrl)

# Handle options
if [[ $# -eq 0 ]]; then
  echo "Usage: $0 [--title] [--artist] [--image] [--source|--player]"
  exit 0
fi

for arg in "$@"; do
  case $arg in
  --title)
    echo "$TITLE"
    ;;
  --artist)
    echo "$ARTIST"
    ;;
  --image)
    if [[ "$ART_URL" == file://* ]]; then
      cp "${ART_URL#file://}" /tmp/current-art.png
      echo "/tmp/current-art.png"
    elif [[ -n "$ART_URL" ]]; then
      curl -s "$ART_URL" -o /tmp/current-art.png
      echo "/tmp/current-art.png"
    else
      echo "No album art found."
    fi
    ;;
  --player | --source)
    echo "$PLAYER_CLEAN"
    ;;
  *)
    echo "Unknown option: $arg"
    exit 1
    ;;
  esac
done
