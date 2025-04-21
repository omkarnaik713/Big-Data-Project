#!/usr/bin/env python3
import sys
from collections import defaultdict

taxi_totals = defaultdict(lambda: [0.0, 0])  # airport: [total_taxi_time, count]

for line in sys.stdin:
    try:
        airport, taxi_time, count = line.strip().split('\t')
        taxi_totals[airport][0] += float(taxi_time)
        taxi_totals[airport][1] += int(count)
    except:
        continue

# Compute average taxi time per airport
avg_taxi_times = [(airport, total / count) for airport, (total, count) in taxi_totals.items() if count > 0]

# Sort to get top 3 longest and shortest average taxi time
avg_taxi_times.sort(key=lambda x: x[1])

print("highest")
for airport, avg in avg_taxi_times[-3:][::-1]:
    print(f"{airport}\t{avg:.2f}")

print("lowest")
for airport, avg in avg_taxi_times[:3]:
    print(f"{airport}\t{avg:.2f}")


