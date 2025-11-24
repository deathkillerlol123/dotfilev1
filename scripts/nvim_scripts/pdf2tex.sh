#!/bin/bash
# Usage: ./pdf2tex.sh input.pdf
# Converts input.pdf → input.tex

if [ $# -ne 1 ]; then
  echo "Usage: $0 input.pdf"
  exit 1
fi

INPUT="$1"
BASENAME="${INPUT%.pdf}" # remove .pdf extension
OUTPUT="${BASENAME}.tex" # add .tex extension

# Step 1: Convert PDF → Markdown
TMP_MD=$(mktemp /tmp/pdf2tex.XXXX.md)
pandoc "$INPUT" -o "$TMP_MD"

# Step 2: Convert Markdown → LaTeX
pandoc "$TMP_MD" -o "$OUTPUT"

# Step 3: Clean up temporary file
rm "$TMP_MD"

echo "Converted $INPUT → $OUTPUT (manual cleanup may be needed)"
