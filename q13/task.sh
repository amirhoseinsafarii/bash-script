#!/bin/bash



if [[ ! -f 'tasks.txt' ]];then
    touch tasks.txt
fi

command="$1"
for ((i=2; i<=$#; i++)); do
    tasktitle+="${!i} "
done

case "$command" in

add)
    ti="${tasktitle#*\(}"
    ti="${ti%%\)*}"
 
    ti=$(awk -v ti="$ti" 'BEGIN { print tolower(ti) }')
    if [[ "${ti}" == "very important" ]];then
        echo "H ${tasktitle}" >> 'tasks.txt'
        line=$(wc -l < tasks.txt | awk '{print $1}')
        echo "Added task ${line} with priority H"


    elif [[ "${ti}" == "important" ]];then
        echo "M ${tasktitle}" >> 'tasks.txt'
        line=$(wc -l < tasks.txt | awk '{print $1}' )
        echo "Added task ${line} with priority M"

    else
        echo "${tasktitle}" >> 'tasks.txt'
        line=$(wc -l < tasks.txt | awk '{print $1}')
        echo "Added task ${line} with priority L"

    fi

;;

esac