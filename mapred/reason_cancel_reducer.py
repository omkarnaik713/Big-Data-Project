#!/usr/bin/env python3
import sys

current_reason = None
count = 0

for line in sys.stdin:
    reason, val = line.strip().split("\t")
    val = int(val)

    if current_reason == reason:
        count += val
    else:
        if current_reason:
            print(f"{current_reason}\t{count}")
        current_reason = reason
        count = val

if current_reason:
    print(f"{current_reason}\t{count}")
