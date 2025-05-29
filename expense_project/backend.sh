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
        echo -e "$2....$G Success $N"
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

dnf module disable nodejs -y &>>$log_file_name
validate $? "disbale nodejs"

dnf module enable nodejs:20 -y &>>$log_file_name
validate $? "enable nodejs 20"

dnf install nodejs -y &>>$log_file_name
validate $? "installing nodejs"

id expense &>>$log_file_name
if [ $? -ne 0 ]; then
    echo "checking expense id there or not, if not now i'm going to creating"
        useradd expense
        validate $? "expense user created"
else 
    echo -e "expense user already created... $Y Skipp $N"
fi

mkdir -p /app
validate $? "creating app folder"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$log_file_name
validate $? "downloading the source code"



cd /app
rm -rf /app/*

unzip /tmp/backend.zip &>>$log_file_name
validate $? "unzip the backend"

npm install &>>$log_file_name
validate $? "installing dependences"

cp /home/ec2-user/pract_shell/expense_project /etc/systemd/system/backend.service &>>$log_file_name

#scema creating
dnf install mysql -y &>>$log_file_name
validate $? "installing mysql"

mysql -h mysql.myfooddy.fun -uroot -pExpenseApp@1 < /app/schema/backend.sql &>>$log_file_name
validate $? "schema creating"

systemctl daemon-reload &>>$log_file_name
validate $? "reloading"

systemctl enable backend &>>$log_file_name
validate $? "enabling backend"

systemctl restart backend &>>$log_file_name
validate $? "restarting the backend"

