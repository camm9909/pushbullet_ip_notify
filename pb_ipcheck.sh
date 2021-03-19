#!/bin/bash

ipcon="ip.txt"                              # Path place to store IP
pubip="ifconfig.me"                         # WAN IP resolve host
pbapi="123456789ABCDEFGHIJKLMNOPQRSTUVWXY"  # PushBullet token
title="New IP:"                             # Title of PushBullet Msg

#Check if IP store exists
if [ -f "$ipcon" ]; then
    echo "file exists!"
else
    echo "" > "$ipcon"
    echo "file doesn't exist, creating"
fi

# Check hosts are reachable
ping -q -c 1 $pubip >/dev/null 2>&1; ping1=$?

if [[ $ping1 ]] ; then
    curip=$(curl -f -s "$pubip")
    stoip=$(cat "$ipcon")

    # IP Regex check
    if [[ $curip =~ ^[0-9]+(\.[0-9]+){3}$ ]] ; then
        if [ "$curip" != "$stoip" ]; then
            echo "updating IP..."
            echo "${curip}" > "$ipcon"
            curl -s -u $pbapi: -X POST https://api.pushbullet.com/v2/pushes \
                --header 'Content-Type: application/json' \
                --data-binary '{"type": "note", "title": "'"$title"'", "body": "'"$curip"'"}' \
                >/dev/null 2>&1
        else
            echo "no change in IP"
        fi
    else
        echo "No valid IP to parse"
    fi
else
    # Either machine or resolver is offline
    echo "Cannot resolve WAN IP"
fi
exit 0
