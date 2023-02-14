#!/bin/bash

######################## Connect To Database ########################## 

while [ true ];do
    echo -e "${cyan}Enter the name of the Database you want to connect to :${clear}"
    read  DatabaseName
    if [[ $DatabaseName =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]];then 
        if [[ -e $DatabaseName ]];then
            cd $DatabaseName  
            echo " "
            echo -e "${magenta}=======================================(${cyan}Conected by${clear} ${red}$DatabaseName${clear})${magenta}=======================================${clear}"
            echo " "
            source ../../Database_CRUD_operation_Menu.sh
            break
        else 
            echo -e "${red}The Database Name Not Exist${clear}"
        fi
    else 
        echo -e "${red}!! Invalid Name the database Name can't contain the space or special character except dash and can't begin by numbers !!${clear}"
    fi
done
