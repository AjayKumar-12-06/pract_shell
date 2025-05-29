#!/bin/bash

USER_ID=$(id -u)

check_root (){
    if [ $? -ne 0 ]; then
        echo "you have sudo accesses to execute this"
        exit 1
    fi
    
}

check_root

validate (){
    if [ $1 -ne 0 ]; then
                echo "$2 installing failure"
                exit 1
            else
                echo "$2 installing success"
            fi 
}

dnf list installed git 
if [ $? -ne 0 ]; then
    echo "if git is not available, now going to installing git"
        dnf install git -y
            validate $? "installing git"
else
    echo "git is already available."
fi