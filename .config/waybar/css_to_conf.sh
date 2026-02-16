#!/bin/bash

input_file="colors2.css" # your file with @define-color lines
output_file="colors2.conf"

sed 's/@define-color //; s/;$//' "$input_file" >"$output_file"

sed 's/#/0x/g' colors2.conf >mangocol.conf
