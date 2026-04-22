#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "Error :: Please runth script with root user"
    exit 1 #failure is otherthan 0
fi

dnf install mysql -y

if [ $? -ne 0 ]; then
    echo "error :: Installing mysql failed"
    exit 1
else
    echo "Installing my sql is success"
fi