import sys

current_reason = None
count = 0

common_reason = None
max_count = 0

for line in sys.stdin:
    reason, val = line.strip().split("\t")
    val = int(val)

    if current_reason == reason:
        count += val
    else:
        if current_reason:
            if count > max_count:
                max_count = count
                common_reason = current_reason
        current_reason = reason
        count = val

# Check the last reason
if current_reason:
    if count > max_count:
        max_count = count
        common_reason = current_reason

# Output the most common cancellation reason
if common_reason:
    print(f"{common_reason}\t{max_count}")
