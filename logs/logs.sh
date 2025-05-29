#!/bin/bash

USER_ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

log_folder="/var/log/script.log"
log_file=$(echo $0 | cut -d "." -f1)
Timestamp=$(date +%y-%m-%d-%H-%M-%S)
log_file_name=$log_folder/$log_file-$Timestamp

mkdir -p /var/log/script.log

validate() {
    if [ $1 -ne 0 ]; then
        echo -e " $2 ...$R failure $N"
        exit 1
    else
        echo -e "$2 ....$G Success $N"
    fi
}


echo "Script started executing at: $Timestamp" &>>$log_file_name
check_root(){

if [ $USER_ID -ne 0 ]; then
    echo -e $R "ERROR : You must have the sudo access to execute this $N" 
    exit 1
fi
}

check_root

dnf list installed mysql &>>$log_file_name
    if [ $? -ne 0 ]; then
        echo "Checking mysql is installed or not, if not now i'm going to installing java"
            dnf install mysql -y &>>$log_file_name
            validate $? "installing mysql"
    else
        echo -e "already mysql is installed $Y Skipp $N"
    fi

