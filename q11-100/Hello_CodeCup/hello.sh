#!/bin/bash


input="$1"
revinput=$(echo "${input}" | rev)
echo "Hello ${revinput}!" 