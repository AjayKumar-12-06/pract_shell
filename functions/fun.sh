#!/bin/bash

USER_ID=$(id -u)

check_root(){
    if [ $USER_ID -ne 0 ]; then
        echo "you have sudo accesses to execute this"
        exit 1
    fi
    
}

check_root

validate(){
    if [ $1 -ne 0 ]; then
                echo "$2 installing failure"
                exit 1
            else
                echo "$2 installing success"
            fi 
}

dnf list installed tree 
if [ $? -ne 0 ]; then
    echo "if tree is not available, now going to installing tree"
        dnf install tree -y
            validate $? "installing tree"
else
    echo "tree is already available."
fi