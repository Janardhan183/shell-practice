#!/bin/bash

#everything in shell is considerd as string
NUMBER1=100
NUMBER2=200
NAME=Deveops

SUM=$(($NUMBER1+$NUMBER2+$NAME))

echo "SUM is : ${SUM}"