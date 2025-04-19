#!/bin/bash

set -e

echo "===> Checking for required tools..."

REQUIRED_TOOLS=("curl" "hdfs" "unzip" "bzip2")

for tool in "${REQUIRED_TOOLS[@]}"; do
  if ! command -v "$tool" &> /dev/null; then
    echo "Error: '$tool' is not installed. Please install it and re-run the script."
    exit 1
  fi
done

echo "✅ All required tools are available."

echo "===> Extracting and decompressing dataset"
./extract-decompress.sh

EXTRACT_DIR="airline_csvs"

echo "===> Creating HDFS directory: /user/airline_data"
sudo -u hdfs hdfs dfs -mkdir -p /user/airline_data

echo "===> Uploading CSV files to HDFS..."
for csv_file in "$EXTRACT_DIR"/*.csv; do
  if [[ -f "$csv_file" ]]; then
    echo "Uploading $(basename "$csv_file") to HDFS..."
    sudo -u hdfs hdfs dfs -put -f "$csv_file" /user/airline_data/
  fi
done

echo -e "\n===> Cleaning up local files..."
rm -rf "$EXTRACT_DIR"

echo -e "\n✅ All CSV files successfully uploaded to HDFS at /user/airline_data."
