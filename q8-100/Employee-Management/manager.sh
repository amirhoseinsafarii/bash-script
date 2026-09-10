#!/bin/bash


command="$1"

if [[ "${command}" != "bonus" && "${command}" != "city" ]];then
    echo "command not found"
fi



if [[ "${command}" == "bonus" ]];then
    id="$2"
    awk -F ',' -v id="$id" '{
        if($1 == id) {
            cost=(5 * int($5))/100
            print $3 " will get $"cost " bonus"
        } 
    }' employee.csv
fi


if [[ "${command}" == "city" ]];then
    city="$2"
    awk -F ',' -v city="$city" '{
        if($2 == city) {
            print "Customer Name: " $3
            print "Mobile No: " $4
        }
    
    }
  
    ' employee.csv
fi