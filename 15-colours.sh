#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]; then
    echo "Error :: Please runth script with root user"
    exit 1 #failure is otherthan 0
fi

VALIDATE(){
    if [ $1 -ne 0 ]; then
    echo -e "Installing $2 ... $R FAILURE $N"
    exit 1
else
    echo -e "Installing my $2... $G is success $N"
fi
}

dnf list install mysql
if [ $? -nq 0 ]; then
    dnf install mysql -y
    VALIDATE $? "MYSQL"
else
echo "MYSQL already exist... $Y Skipping %N"
fi

dnf list install mysql
if [ $? -nq 0 ]; then
    dnf install niginx -y
    VALIDATE $? "Nginx"
else
echo -e "niginx already exist... $Y Skipping %N"
fi

dnf list instal python3
if [ $? -nq 0 ]; then
   dnf install python3 -y
   VALIDATE $? "python3"
else
echo -e "python3 already exist... $Y Skipping %N"
fi