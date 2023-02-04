#!/bin/bash

############################# List Databases ############################

# append indicator with the file (*) and with the directory (/) =>  (one of */=>@|) 

echo " "
echo "=======================================(List Databases)======================================="
echo " "
ls -F | grep /
echo " "
count=$(ls -F | grep / | wc -l)
echo "The Total Databases Count : " $count
echo " "