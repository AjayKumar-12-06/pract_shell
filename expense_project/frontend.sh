#!/bin/bash

#!/bin/bash

# check the root access or not
USER_ID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

log_file="/var/log/expense.log"
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

dnf install nginx -y &>>$log_file_name
validate $? "installing nginx"

systemctl enable nginx &>>$log_file_name
validate $? "enables  nginx"

systemctl start nginx &>>$log_file_name
validate $? "started nginx"

rm -rf /usr/share/nginx/html/* &>>$log_file_name
validate $? "remove the existing code"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$log_file_name
validate $? "download the code"

cd /usr/share/nginx/html &>>$log_file_name
validate $? "moving to html"

unzip /tmp/frontend.zip &>>$log_file_name
validate $? "Unzip the code"

cp /home/ec2-user/pract_shell/expense_project/expense.conf /etc/nginx/default.d/expense.conf &>>$log_file_name
validate $? "copied expense conf"

systemctl restart nginx &>>$log_file_name
validate $? "restarted nginx"