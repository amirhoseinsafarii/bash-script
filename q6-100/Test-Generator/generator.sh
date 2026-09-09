#!/bin/bash


mkdir -p out
for i in $(seq 1 "$1");do
    echo "$i"
    input_file="input${i}.txt"
    python3 main.py < "in/${input_file}" > "out/output${i}.txt"
done