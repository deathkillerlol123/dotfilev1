#!/usr/bin/env bash

# Usage: ./xres_to_rasi.sh input_file output_file
INPUT="colors1.css"
OUTPUT="colors1.rasi"

if [[ -z "$INPUT" || -z "$OUTPUT" ]]; then
  echo "Usage: $0 input_file output_file"
  exit 1
fi

{
  echo "* {"
  # Extract all lines with @define-color, convert to key: value;
  grep '@define-color' "$INPUT" | while read -r line; do
    # Extract color name and value
    name=$(echo "$line" | awk '{print $2}')
    value=$(echo "$line" | awk '{print $3}' | tr -d ';')
    echo "    $name: $value;"
  done
  echo "}"
} >"$OUTPUT"

echo "Converted $INPUT -> $OUTPUT"
