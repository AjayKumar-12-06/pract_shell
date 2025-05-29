#!/bin/bash

USER_ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

check_root(){

if [ $USER_ID -ne 0 ]; then
    echo -e $R "ERROR : You must have the sudo access to execute this $N"
    exit 1
fi
}

check_root

validate() {
    if [ $1 -ne 0 ]; then
        echo -e " $2 ...$R failure $N"
        exit 1
    else
        echo -e "$2 ....$G Success $N"
    fi
}

dnf list installed mysql
    if [ $? -ne 0 ]; then
        echo "Checking mysql is installed or not, if not now i'm going to installing java"
            dnf install mysql -y
            validate $? "installing mysql"
    else
        echo -e "already mysql is installed $Y Skipp $N"
    fi

