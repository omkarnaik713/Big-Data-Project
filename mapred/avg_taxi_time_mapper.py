#!/usr/bin/env python3
import sys
import csv

# Use csv reader to handle potential commas inside quotes
reader = csv.reader(sys.stdin)
header = next(reader, None)  # Skip header

for row in reader:
    try:
        origin = row[16]  # Origin airport
        taxi_in = float(row[19]) if row[19] else 0.0
        taxi_out = float(row[20]) if row[20] else 0.0
        total_taxi = taxi_in + taxi_out

        if origin:
            print(f"{origin}\t{total_taxi}\t1")
    except Exception as e:
        continue  # Skip malformed lines
