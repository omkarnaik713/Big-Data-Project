#!/bin/bash

set -e

ZIP_FILE="dataverse_files.zip"
DEST_DIR="airline_csvs"

echo "===> Checking for required tools..."
REQUIRED_TOOLS=("unzip" "bzip2")

for tool in "${REQUIRED_TOOLS[@]}"; do
  if ! command -v "$tool" &> /dev/null; then
    echo "Error: '$tool' is not installed. Please install it and re-run the script."
    exit 1
  fi
done

echo "===> Creating output directory: $DEST_DIR"
mkdir -p "$DEST_DIR"

echo "===> Extracting .bz2 files from $ZIP_FILE..."
unzip -j "$ZIP_FILE" "*.bz2" -d "$DEST_DIR"

echo "===> Decompressing .bz2 files to .csv..."
cd "$DEST_DIR"

for file in *.bz2; do
  if [[ -f "$file" ]]; then
    echo "Decompressing $file..."
    bzip2 -dk "$file"  # -d: decompress, -k: keep original .bz2
  fi
done

echo "===> Cleanup: removing .bz2 files..."
rm -f *.bz2

echo "✅ All .bz2 files extracted and decompressed to .csv in '$DEST_DIR'."
