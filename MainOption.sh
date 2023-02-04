#!/bin/bash

echo " "
echo "=======================================(Welcome In DBMS)======================================="
echo " "

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
    "Exit") exit;;
    *) echo "invalid choise try again " ;;
    esac
done 