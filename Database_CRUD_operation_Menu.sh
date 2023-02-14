#!/bin/bash
# author : Abdelrahman Elmansey 

#################### Database CRUD operation Menu ###################




############### Show the select option ################
echo " "
PS3="============ Choise Operation ============ : "
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
        cd ../
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
    ;;
    "Exit") exit;;
    *) echo -e "${red}invalid choise try again${clear}" ;;
    esac
done 
