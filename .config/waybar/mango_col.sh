#!/bin/bash

# Usage: ./convert_rgba.sh input_file output_file

input="mangocol.conf"
output="mangocol1.conf"

if [[ -z "$input" || -z "$output" ]]; then
  echo "Usage: $0 input_file output_file"
  exit 1
fi

# Process each line
while IFS= read -r line; do
  # Skip empty lines
  [[ -z "$line" ]] && continue

  # Split variable name and hex value
  var=$(echo "$line" | cut -d' ' -f1)
  hex=$(echo "$line" | cut -d' ' -f2)

  # Remove leading '#' if present
  hex=${hex#"#"}

  # Append 'FF' for full opacity
  rgba="0x${hex}FF"

  # Output converted line
  echo "$var = $rgba"
done <"$input" >"$output"

echo "Conversion complete. Saved to $output"
