#!/bin/bash


free=$(df -h / | awk 'NR>1 {print $4}')

total=$(df -h / | awk 'NR>1 {print $2}')

percentage=$(df -h / | awk 'NR>1 {print $5}')
percentage=${percentage%\%*}


echo "Free/Total memory: ${free} / ${total}"
echo "Percentage: ${percentage}"