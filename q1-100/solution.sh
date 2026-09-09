#!/bin/bash


while IFS= read -r line || [[ -n $line ]];do

    if [[ -z $line ]];then
        echo "${line}" >> .env
        continue
    fi

    if [[ $line = \#* ]];then
        echo "${line}" >> .env
    else
        key="${line%%=*}"
        value="${line#*=}"
        if [[ -n $value ]];then
            echo "${line}" >> .env
        elif [[ -n "${!key}" ]];then
            value="${!key}"
            echo "${key}=${value}" >> .env 
        else 
            echo "${key}=TODO_${key}" >> .env
        fi
    fi
    
done < .env.example
