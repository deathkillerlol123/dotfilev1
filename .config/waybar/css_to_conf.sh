#!/bin/bash

input_file="colors2.css"    # your file with @define-color lines
output_file="colors2.conf"

# remove '@define-color ' and trailing semicolon
sed 's/@define-color //; s/;$//' "$input_file" > "$output_file"

echo "Cleaned colors written to $output_file"

