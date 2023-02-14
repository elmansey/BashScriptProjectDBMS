#!/bin/bash

######################################### create table ####################################

while [ true ]
do 
    echo -e "${cyan}Enter name of Table :${clear}" 
    read table_name
    if [[ $table_name =~ ^[a-z_A-Z]+[a-zA-Z0-9]+$  ]];then
        if [[ ! -e $table_name ]];then

            sudo touch $table_name
            sudo touch "$table_name meta_data.txt"
            sudo chmod 777 "$table_name"
            sudo chmod 777 "$table_name meta_data.txt"
        
            #check for cloumns_num
            while [ true ];do
                echo -e  "${cyan}Please Enter How Many Columns you want : ${clear}"
                read columns_num
                if [[ $columns_num =~ ^[0-9]+$  ]]; then
                    break
                else
                    echo -e "${red}inavlid num${clear}"
                fi
            done
            counter=0 

            if ! [[ -z  $columns_num ]];then 
                while [ $counter -lt $columns_num ]
                do
                    echo -e "${cyan}Enter column $(($counter+1)) name :${clear}"
                    read  col_name

                    if [[ $col_name =~ ^[a-z_A-Z]+[a-zA-Z_0-9]+$  ]];then
                    
                    echo -e "${cyan}Seclect the $col_name DataType  :${clear}"
                    select choice in "int" "string"
                    do 

                        case $choice in 
                        "int")
                            if [ $counter -eq 0 ];then
                                constraint_of_col="PK"
                            else
                                constraint_of_col="null"
                            fi

                            record="$col_name:$choice:$constraint_of_col"
                            echo $record >> "$table_name meta_data.txt"
                            echo -e "${green}Data added Successfully!!!!${clear}"
                            echo -e "${magenta}$col_name : DataType is $choice and column constraint is $constraint_of_col .${clear}"
                            counter=$(($counter+1))
                            break
                        ;;
                        "string")
                            if [ $counter -eq 0 ];then
                                constraint_of_col="PK"
                            else
                                constraint_of_col="null"
                            fi
                            record="$col_name:$choice:$constraint_of_col"
                            echo $record >> "$table_name meta_data.txt"
                            echo -e "${green}Data added Successfully!!!!${clear}"
                            echo -e "${magents}$col_name : DataType is $choice and column constraint is $constraint_of_col .${clear}"
                            counter=$(($counter+1))
                            break
                        ;;
                        *)
                            echo -e "${red}Sorry!! you must Enter 1 or 2 Datatype${clear}"
                        ;;
                        esac  
                    done       
                    else
                        echo -e "${red}You Entered Invalid Column Name !!!${clear}"
                        echo -e "${red}Please Tty Again!!${clear}"
                    fi 
                done
            else 
                echo -e "${red}Please enter the value for columns num ${clear}"
            fi 
            # this is the outer while stopping 
            if [[ $counter -eq $columns_num ]];then
                break
            fi
        else
            echo -e "${red}This table is already Exist !, Please enter another table name.${clear}"
        fi
    else 
        echo -e "${red}You Enter Invalid Table Name${clear}"
        echo -e "${red}Please Try Again!${clear}"
    fi 
done
    