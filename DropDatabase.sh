#!/bin/bash


while [ true ];do
    read -p "Please Enter Your Database Name , You Want to Remove it : " DatabaseName
    if [[ $DatabaseName =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]];then 
        if [[ -e $DatabaseName ]];then
            read -p "are you sure you want to remove the database ($DatabaseName)  yes - no : " answer
            if [[ $answer =~ ^y(es)$ ]]
            then 
                sudo rm -r $DatabaseName
                echo "Database deleted successfully"
                break
            else
                break
            fi
        else 
            echo "The Database Name Not Exist"
        fi
    else 
        echo "!! Invalid Name the database Name can't contain the space or special character except dash and can't begin by numbers !!"
    fi
done
