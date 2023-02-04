#!/bin/bash

#################### Database CRUD operation Menu ###################



############### Show the select option ################

select choise in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "Exit" "Back to Main Menu"
do  
    case $choise in 
    "Create Table")
        source ../../CreateTable.sh
    ;;
    "List Tables")
        source ../../ListTables.sh
    ;;
    "Drop Table")
        source ../../DropTable.sh
    ;;
    "Insert into Table")
        source ../../InsertIntoTable.sh
    ;;
    "Select From Table")
        source ../../SelectFromTable.sh
    ;;
    "Delete From Table")
        source ../../DeleteFromTable.sh
    ;;
    "Update Table")
        source ../../UpdateFromTable.sh
    ;;
    "Back to Main Menu")
        source ../../MainOption.sh
    ;;
    "Exit") exit;;
    *) echo "invalid choise try again " ;;
    esac
done 