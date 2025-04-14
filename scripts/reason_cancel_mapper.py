import sys

for line in sys.stdin:
    fields = line.strip().split(",")
    if fields[0] == "Year":
        continue

    cancel_code = fields[22]

    if cancel_code and cancel_code not in ("", "NA", "null"):
        print(f"{cancel_code}\t1")
