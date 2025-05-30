#!/bin/bash

port=$(netstat -lntp | grep -i tcp | grep -i -w nginx | awk -F " " '{print $4}' | cut -d ":" -f2)

if [ $port -eq 80 ]; then
    echo "nginx is running"
else
    echo "nginx is not running"
    systemctl start runing
fi