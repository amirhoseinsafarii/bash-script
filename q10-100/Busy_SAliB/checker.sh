#!/bin/bash

timing=()


while true;do
    read -p "" input
    set -- $input

    command="$1"
    start="$2"
    end="$3"

    case "$command" in
    add)
        timing+=("${start} ${end}")
        echo "A meeting from ${start} to ${end} added to your day!"
    ;;

    check)
        found=false
        for i in "${timing[@]}";do
            s=$(echo "${i}" | awk '{print $1}')
            e=$(echo "${i}" | awk '{print $2}')
            if [[ $start -lt $e && $end -gt $s ]]; then
                found=true
                break 
            fi
        done
        if [[ "$found" == true ]];then
            echo "You can't have a meeting from ${start} to ${end}!"
        else
            echo "You can add a meeting from ${start} to ${end}!"
        fi
    ;;

    free)
        new_timing=()
        for i in "${!timing[@]}";do
            s=$(echo "${timing[$i]}" | awk '{print $1}')
            e=$(echo "${timing[$i]}" | awk '{print $2}')

            if [[ $end -le $s || $start -ge $e ]]; then
                new_timing+=("$s $e")


            elif [[ $start -le $s && $end -lt $e ]]; then
                new_timing+=("$end $e")
        
                

            elif [[ $start -gt $s && $end -ge $e ]]; then
                new_timing+=("$s $start")
               
            
            elif [[ $start -gt $s && $end -lt $e ]]; then
                new_timing+=("$s $start")
                new_timing+=("$end $e")
               
         
            fi
        done
        timing=("${new_timing[@]}")
        echo "You're now free from ${start} to ${end}!"

    ;;

    exit)
        echo "Bye Bye!"
        break
    ;;

    *)
        echo "Command not found."
    ;;
    esac
done
