#!/usr/bin/env python3
import sys
from collections import defaultdict

counts = defaultdict(lambda: [0, 0])  # [total flights, on-time flights]

for line in sys.stdin:
    carrier, value = line.strip().split("\t")
    total, on_time = map(int, value.split(","))
    counts[carrier][0] += total
    counts[carrier][1] += on_time

results = []
for carrier, (total, on_time) in counts.items():
    prob = on_time / total
    results.append((carrier, prob))

results.sort(key=lambda x: x[1])
print('highest')
for carrier, prob in results[-3:]:
    print(f"{carrier}\t{prob:.3f}")

print('lowest')
for carrier, prob in results[:3]:
    print(f"{carrier}\t{prob:.3f}")

