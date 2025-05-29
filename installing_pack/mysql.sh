#!/bin/bash

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
    echo "You have sudo access to access to execute this"
    exit 1
fi

dnf list installed mysql 
if [ $? -ne 0 ]; then
    echo "checking mysql isntalled or not if not installed now going to installing"
        dnf install mysql -y
            if [ $? -ne 0 ]; then
                echo "mysql installing failure"
            else 
                echo "mysql installing success"
            fi 
else
    echo "mysql already installed"
fi