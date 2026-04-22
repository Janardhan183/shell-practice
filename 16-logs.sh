#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
mkdir -p $LOGS_FOLDER
echo "Script started executed at: $(date)"

if [ $USERID -ne 0 ]; then
    echo "Error :: Please run this script with root user"
    exit 1 #failure is other than 0
fi

VALIDATE(){
    if [ $1 -ne 0 ]; then
    echo -e "Installing $2 ... $R FAILURE $N"
    exit 1
else
    echo -e "Installing $2 ... $G is success $N"
fi
}

dnf list installed mysql &>>$LOG_FILE
if [ $? -np 0 ]; then
    dnf install mysql -y &>>$LOG_FILE
    VALIDATE $? "MYSQL"
else
echo "MYSQL already exist... $Y Skipping $N"
fi

dnf list install niginx &>>$LOG_FILE
if [ $? -nq 0 ]; then
    dnf install niginx -y &>>$LOG_FILE
    VALIDATE $? "Nginx"
else
echo -e "niginx already exist... $Y Skipping $N"
fi

dnf list instal python3 &>>$LOG_FILE
if [ $? -nq 0 ]; then
   dnf install python3 -y &>>$LOG_FILE
   VALIDATE $? "python3" 
else
echo -e "python3 already exist... $Y Skipping $N"
fi