#!/bin/bash
# Wrapper for notify-send to force unique IDs
TITLE="$1"
MESSAGE="$2"
ICON="${3:-dialog-information}"
URGENCY="${4:-normal}"

# Generate a random ID to prevent replacement
ID=$RANDOM

# Send notification
notify-send "$TITLE" "$MESSAGE" -u "$URGENCY" -i "$ICON" -r $ID

