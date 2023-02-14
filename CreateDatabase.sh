#!/bin/bash
# author : Abdelrahman Elmansey 

while [ true ]
do
    echo -e "${cyan}Please Enter Your Database Name :${clear}"
    read  DatabaseName
    if [[ -e $DatabaseName ]];then
        echo -e "${red}The Database is already exist :D ${clear}"
    else 
        if [[ $DatabaseName =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]];then
            sudo mkdir $DatabaseName
            echo -e "${green}The Database Created Successfully :)${clear}"
            break
        else
            echo -e "${red}!! Invalid Name the database Name can't contain the space or special character except dash and can't begin by numbers !!${clear}" 
        fi
    fi
done



