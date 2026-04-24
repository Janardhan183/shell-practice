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
echo "Script started executed at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]; then
    echo "Error :: Please run this script with root user"
    exit 1 #failure is other than 0
fi

VALIDATE(){
    if [ $1 -ne 0 ]; then
    echo -e "Installing $2 ... $R FAILURE $N" | tee -a $LOG_FILE
    exit 1
else
    echo -e "Installing $2 ... $G is success $N" | tee -a $LOG_FILE
fi
}

for package in $@
do
  # Check package is already install or not
  dnf list install package &>>$LOG_FILE

  #if exist status is 0 is already install or if exit status not equal to 0 need to install
  if [$? -ne 0]; then
     dnf install $package -y &>>$LOG_FILE
     VALIDATE $? "$package"

  else
    echo -e "$package already installed .....$Y SKIPPING $N"
done