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

dnf list installed pyhton &>>$log_file_name
    if [ $? -ne 0 ]; then
        echo "Checking python is installed or not, if not now i'm going to installing java" &>>$log_file_name
            dnf install python -y &>>$log_file_name
            validate $? "installing python"
    else
        echo -e "already python is installed $Y Skipp $N"
    fi

