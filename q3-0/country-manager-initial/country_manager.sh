#!/bin/bash

if ! command -v iptables >/dev/null 2>&1; then

    apt-get update
    apt-get install -y iptables
fi

if [[ "$#" -lt 2 ]]; then
    echo "not enough arguments"
    exit
fi



command="$1"
file="$2"

if [[ "$command" != "block" && "$command" != "unblock" ]]; then
    echo "invalid command"
    exit
fi

if [[ ! -f "$file" ]]; then
    echo "ip list file not found"
    exit
fi

while IFS= read -r ip; do
    [[ -z "$ip" ]] && continue

    if [[ "$command" == "block" ]]; then

        if iptables -C INPUT -s "$ip" -j ACCEPT 2>/dev/null; then
            iptables -D INPUT -s "$ip" -j ACCEPT
        fi

        if ! iptables -C INPUT -s "$ip" -j DROP 2>/dev/null; then
            iptables -A INPUT -s "$ip" -j DROP
        fi

    elif [[ "$command" == "unblock" ]]; then

        if iptables -C INPUT -s "$ip" -j DROP 2>/dev/null; then
            iptables -D INPUT -s "$ip" -j DROP
        fi

        if ! iptables -C INPUT -s "$ip" -j ACCEPT 2>/dev/null; then
            iptables -A INPUT -s "$ip" -j ACCEPT
        fi

    fi
done < "$file"