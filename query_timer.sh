#!/bin/bash

# Check that required arguments are provided
if [ $# -ne 5 ]; then
    echo "Usage: $0 label num_reps query db_file csv_file"
    exit 1
fi

# Parse arguments
label=$1
num_reps=$2
query=$3
db_file=$4
csv_file=$5

# Get start time in seconds
start_time=$(date +%s)

# Run the query num_reps times
i=0
while [ $i -lt "$num_reps" ]; do
    duckdb "$db_file" -c "$query" > /dev/null 2>&1
    i=$((i + 1))
done

# Get end time in seconds
end_time=$(date +%s)

# Compute elapsed time in seconds (integer)
elapsed=$((end_time - start_time))

# Compute average time per query in seconds using awk (float)
average=$(echo "$elapsed $num_reps" | awk '{printf "%.6f", $1 / $2}')

echo "CSV file: $csv_file"
echo "Label: $label"
echo "Average: $average"

# Append result to CSV file
echo "${label},${num_reps},${average}" >> "$csv_file"
