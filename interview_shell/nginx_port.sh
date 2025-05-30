#!/bin/bash

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
    echo "ERROR : User must have the sudo access to execute this"
    exit 1
fi

port=$(netstat -lntp | grep -i tcp | grep -i -w nginx | awk -F " " '{print $4}' | cut -d ":" -f2)

if [ "${port}" == "80" ]; then
    echo "nginx is running"
else
    echo "nginx is not running"
    systemctl start runing
fi