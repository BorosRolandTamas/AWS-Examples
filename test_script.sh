#!/usr/bin/env bash

#Where will store this files
OUTPUT_DIR="/tmp"

#Lets create the folder
mkdir -p $OUTPUT_DIR

#generate random number
#Determine how many files to create
NUM_FILES=$((RANDOM % 6 + 5))

for ((i=1; i<=NUM_FILES; i++)); do
#Generate random file name
       FILENAME="$OUTPUT_DIR/file_$i.txt"

#Generate random data and write to file
 dd if=/dev/urandom of="$FILENAME" bs=1024 count=$((RANDOM % 1024 + 1)) 2>/dev/null
done

tree $OUTPUT_DIR
