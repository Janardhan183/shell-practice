#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "Error :: Please runth script with root user"
fi

dnf install mysql -y

if [ $? -ne 0 ]; then
    echo "error :: Installing mysql failed"
else
    echo "Installing my sql is success"
fi