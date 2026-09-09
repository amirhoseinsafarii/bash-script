#!/bin/bash

if [[ "$#" -lt 2 ]]; then
    echo "not enough arguments"
    exit 1
fi

command="$1"
file="$2"

if [[ "$command" != "block" && "$command" != "unblock" ]]; then
    echo "invalid command"
    exit 1
fi

if [[ ! -f "$file" ]]; then
    echo "ip list file not found"
    exit 1
fi

while IFS= read -r ip; do
    [[ -z "$ip" ]] && continue

    if [[ "$command" == "block" ]]; then

        if sudo iptables -C INPUT -s "$ip" -j ACCEPT 2>/dev/null; then
            sudo iptables -D INPUT -s "$ip" -j ACCEPT
        fi

        if ! sudo iptables -C INPUT -s "$ip" -j DROP 2>/dev/null; then
            sudo iptables -A INPUT -s "$ip" -j DROP
        fi

    elif [[ "$command" == "unblock" ]]; then

        if sudo iptables -C INPUT -s "$ip" -j DROP 2>/dev/null; then
            sudo iptables -D INPUT -s "$ip" -j DROP
        fi

        if ! sudo iptables -C INPUT -s "$ip" -j ACCEPT 2>/dev/null; then
            sudo iptables -A INPUT -s "$ip" -j ACCEPT
        fi

    fi
done < "$file"