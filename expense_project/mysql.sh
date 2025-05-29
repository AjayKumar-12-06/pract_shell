#!/bin/bash

# check the root access or not
USER_ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

log_file="var/log/expense.log"
log_folder=$(echo $0 | cut -d "." -f1)
Timestamp=$(date +%y-%m-%d-%H-%M-%S)
log_file_name=$log_file/$log_folder-$Timestamp

validate() {
    if [ $1 -ne 0 ]; then
        echo -e "$2.... $R failure $N"
        exit 1
    else
        echo "$2....$G Success $N"
    fi
}

echo "Script started executing at: $Timestamp" &>>$log_file_name

check_root() {
    if [ $USER_ID -ne 0 ];then
        echo -e " $R ERROR : You must have the sudo access to execute this $N"
        exit 1
    fi
}



check_root

dnf install mysql-server -y &>>$log_file_name
validate $? "installing mysql server"

systemctl enable mysqld &>>$log_file_name
validate $? "enabling mysql"

systemctl start mysqld &>>$log_file_name
validate $? "started mysql"

mysql_secure_installation --set-root-pass ExpenseApp@1 -e "show databases;" &>>$log_file_name
if [ $? -ne 0 ]; then
    echo "If the password is not set, now we are going to seeting the password"
        mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$log_file_name
        validate $? "setting password"
else
    echo "already password setted"
fi




