#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "Error :: Please runth script with root user"
    exit 1 #failure is otherthan 0
fi

VALIDATE(){
    if [ $1 -ne 0 ]; then
    echo "error :: Installing $2 failure"
    exit 1
else
    echo "Installing my $2 is success"
fi
}

dnf install mysql -y
VALIDATE $? "MYSQL"

dnf install niginx -y
VALIDATE $? "Nginx"

dnf install mongodb-mongosh -y
VALIDATE $? "mongosh"