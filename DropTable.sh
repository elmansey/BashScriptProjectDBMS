#!/bin/bash

while [ true ];do
    read  -p "Please Enter Your table Name , You Want to Remove it : " tableName
    if [[ $tableName =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]];then 
        if [[ -e $tableName ]];then
               echo "Are you sure you want to remove the table : "
                select choice in "Yes" "No"
                do
                case $choice in
                "Yes")  
                    sudo rm  "$tableName"
                    sudo rm  "$tableName meta_data.txt"
                    echo  -e "${green}$tableName deleted successfully${clear}"
                    break
                    ;;
                "No")
                    echo "good news"
                    break
                ;;
                *)
                    echo -e "${red}invalid input please try again${clear}"
                ;;
                esac
                done
            
            break
        else 
            echo -e "${red}tableName Name Not Exist${clear}"
        fi
    else 
        echo -e "${red}Invalid Name the tableName Name can't contain the space or special character except dash and can't begin by numbers${clear}"
    fi
done