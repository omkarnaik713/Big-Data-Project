import sys

for line in sys.stdin:
    fields = line.strip().split(",")
    if fields[0] == "Year":
        continue

    carrier = fields[8]
    arr_delay = fields[14]

    # Skip if delay is missing or not a number
    if carrier and arr_delay not in ("", "NA", "null"):
        try:
            delay = float(arr_delay)
            on_time = 1 if delay <= 0 else 0
            print(f"{carrier}\t1,{on_time}")
        except ValueError:
            continue
