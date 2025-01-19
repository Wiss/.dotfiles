#!/usr/bin/env python3
import matplotlib.pyplot as plt
import numpy as np
import re
import sys

debug = 1

if debug:
    # Debug: Print command-line arguments
    print(f"Arguments: {sys.argv}")

# Read input file and output file paths
input_file = sys.argv[1]
output_file = sys.argv[2]

# Extract meaningful rows from the Org table
labels = []
sizes = []

data_start_at = 2  # Skip the header rows
current_parent = None
has_children = False
parent_time = 0
label_row = 0
parent_time_row = 1
child_time_row = 2
fig_len = 10

def calculate_dhm(time):
    if 'd' in time:
        days_hm = re.split(r'[\s]', time)
        days = int(days_hm[0].split('d')[0])
        hours, minutes = map(int, (days_hm[1].split(':')))
    else:
        days = 0
        hours, minutes = map(int, time.split(':'))
    return days, hours, minutes

# Read data from input file
with open(input_file, "r") as f:
    data = [line.strip().split("\t") for line in f.readlines()]
print("data", data)

for row in data[data_start_at:]:
    if row[label_row].startswith(r'\_'):  # Child task
        has_children = True  # Mark that the parent has children
        child_label = row[label_row].strip()
        parent_label = current_parent
        full_label = f"{parent_label}{child_label}"  # Combine parent and child
        labels.append(full_label)

        # Process time for the child (column 3)
        time = row[child_time_row].strip()
        if time:
            days, hours, minutes = calculate_dhm(time)
            total_minutes = days * 24 * 60 + hours * 60 + minutes
            sizes.append(total_minutes)

    else:  # Parent task
        if current_parent and not has_children:
            # If the previous parent has no children, use its total time
            labels.append(current_parent)
            sizes.append(parent_time)

        # Update current parent
        current_parent = row[label_row].strip()
        has_children = False  # Reset the child tracker

        # Process time for the parent
        time = row[parent_time_row].strip()
        if time:
            days, hours, minutes = calculate_dhm(time)
            parent_time = days * 24 * 60 + hours * 60 + minutes

# Handle the last parent (if it has no children)
if current_parent and not has_children:
    labels.append(current_parent)
    sizes.append(parent_time)

if not labels or not sizes:
    print("Error: No data to plot")
    sys.exit(1)

cumsum_minutes = np.cumsum(sizes)
total_minutes = cumsum_minutes[-1]
total_hours = total_minutes / 60
print(f'total time in minutes: {total_minutes}')
print(f'total time in hours: {total_hours:.2f}')

# Plot the pie chart
plt.figure(figsize=(fig_len, fig_len))
plt.pie(sizes, labels=labels, autopct='%1.1f%%', startangle=140)
plt.title(f"Time distribution. Total hours: {total_hours:.2f}")
plt.savefig(output_file)
