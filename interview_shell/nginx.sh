#!/bin/bash

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
    echo "ERROR : User must have the sudo access to execute this"
    exit 1
fi

status=$(systemctl status nginx)

if [ $status -ne 0 ];then
    echo "Nginx is not runnig"
    exit 1
else    
    echo "Nginx is running"
    systemctl start nginx
fi

