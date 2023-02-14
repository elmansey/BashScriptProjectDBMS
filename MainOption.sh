#!/bin/bash
# author : Ahmed Gamal 

echo " "
echo -e "${magenta}=======================================${clear}(${cyan}Welcome In ${clear}${red}DBMS${clear})${magenta}=======================================${clear}"
echo " "
echo " "
PS3="============ Choise Operation ============ : "
select choise in "Create Database" "List Databases" "Connect To Databases" "Drop Database" "Exit"
do 
    case $choise in 
    "Create Database") 
        source ../CreateDatabase.sh
    ;;
    "List Databases")
        source ../ListDatabase.sh 
    ;;
    "Connect To Databases")
        source ../ConnectToDatabase.sh  
    ;;
    "Drop Database") 
        source ../DropDatabase.sh  
    ;;
    "Exit") 
        exit;;
    *) 
        echo -e "${red}invalid choise try again${clear}" ;;
    esac
done 


