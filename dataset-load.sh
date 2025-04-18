#!/bin/bash

set -e

echo "===> Checking for required tools..."

REQUIRED_TOOLS=("curl" "unzip" "hdfs")

for tool in "${REQUIRED_TOOLS[@]}"; do
  if ! command -v "$tool" &> /dev/null; then
    echo "Error: '$tool' is not installed. Please install it and re-run the script."
    exit 1
  fi
done

echo "All required tools are available."

# Base URL from Dataverse (update FILE_IDs if needed)
BASE_URL="https://dataverse.harvard.edu/api/access/datafile"

declare -A FILE_IDS=(
  ["1987"]="4399535"
  ["1988"]="4399536"
  ["1989"]="4399537"
  ["1990"]="4399538"
  ["1991"]="4399539"
  ["1992"]="4399540"
  ["1993"]="4399541"
  ["1994"]="4399542"
  ["1995"]="4399543"
  ["1996"]="4399544"
  ["1997"]="4399545"
  ["1998"]="4399546"
  ["1999"]="4399547"
  ["2000"]="4399548"
  ["2001"]="4399549"
  ["2002"]="4399550"
  ["2003"]="4399551"
  ["2004"]="4399552"
  ["2005"]="4399553"
  ["2006"]="4399554"
  ["2007"]="4399555"
  ["2008"]="4399556"
)

WORKDIR="airline_data"

echo "===> Creating working directory: $WORKDIR"
mkdir -p "$WORKDIR"

echo "===> Creating HDFS directory: /user/airline_data"
sudo -u hdfs hdfs dfs -mkdir -p /user/airline_data

# Download and upload loop
for year in $(seq 1987 2008); do
  echo -e "\n===> Processing year: $year"

  FILE_ID=${FILE_IDS[$year]}
  ZIP_PATH="$WORKDIR/${year}.zip"
  CSV_NAME="${year}.csv"
  EXTRACT_DIR="$WORKDIR/extracted_$year"

  echo "Downloading ZIP..."
  curl -L -o "$ZIP_PATH" "$BASE_URL/$FILE_ID"

  echo "Extracting ZIP..."
  mkdir -p "$EXTRACT_DIR"
  unzip -o "$ZIP_PATH" -d "$EXTRACT_DIR"

  # Find CSV and rename
  CSV_SOURCE=$(find "$EXTRACT_DIR" -type f -name "*.csv" | head -n 1)
  if [[ -f "$CSV_SOURCE" ]]; then
    mv "$CSV_SOURCE" "$WORKDIR/$CSV_NAME"
  else
    echo "Error: No CSV file found in ZIP for $year."
    exit 1
  fi

  echo "Uploading $CSV_NAME to HDFS..."
  sudo -u hdfs hdfs dfs -put -f "$WORKDIR/$CSV_NAME" /user/airline_data/

done

echo -e "\n===> Cleaning up local files..."
rm -rf "$WORKDIR"

echo -e "\n✅ All years processed and uploaded to HDFS successfully."
