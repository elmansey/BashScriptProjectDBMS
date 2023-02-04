#!/bin/bash

while [ true ]
do
    read -p "Please Enter Your Database Name :" DatabaseName
    if [[ -e $DatabaseName ]];then
        echo "The Database is already exist :D"
    else 
        if [[ $DatabaseName =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]];then
            sudo mkdir $DatabaseName
            echo "The Database Created Successfully :)"
            break
        else
            echo "!! Invalid Name the database Name can't contain the space or special character except dash and can't begin by numbers !!" 
        fi
    fi
done



