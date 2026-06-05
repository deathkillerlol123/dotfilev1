#!/usr/bin/env bash

INPUT="colors.css"
OUTPUT="colors.rasi"

if [[ -z "$INPUT" || -z "$OUTPUT" ]]; then
  echo "Usage: $0 input_file output_file"
  exit 1
fi

{
  echo "* {"
  grep '@define-color' "$INPUT" | while read -r line; do
    name=$(echo "$line" | awk '{print $2}')
    value=$(echo "$line" | awk '{print $3}' | tr -d ';')
    echo "    $name: $value;"
  done
  echo "}"
} >"$OUTPUT"
