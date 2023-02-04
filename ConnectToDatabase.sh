#!/bin/bash

######################## Connect To Database ########################## 

while [ true ];do
    read -p "Enter the name of the Database you want to connect to :" DatabaseName
    if [[ $DatabaseName =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]];then 
        if [[ -e $DatabaseName ]];then
            cd $DatabaseName  
            echo " "
            echo "=======================================("Conected by "$DatabaseName)======================================="
            echo " "
            source ../../Database_CRUD_operation_Menu.sh
            break
        else 
            echo "The Database Name Not Exist"
        fi
    else 
        echo "!! Invalid Name the database Name can't contain the space or special character except dash and can't begin by numbers !!"
    fi
done
