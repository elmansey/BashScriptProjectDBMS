#!/bin/bash




######################################### create table ####################################



while [ true ]
do 
    read -p "Enter name of Table : " table_name
    if [[ $table_name =~ ^[a-z_A-Z]+[a-zA-Z_0-9]+$  ]];then
        if [[ ! -e $table_name ]];then

            sudo touch $table_name
            sudo touch "$table_name meta_data.txt"
            sudo chmod 777 "$table_name meta_data.txt"
        
            read -p "Please Enter How Many Columns : " columns_num
            counter=0 

            
            while [ $counter -lt $columns_num ]
            do
                read -p "Enter column $(($counter+1)) name : " col_name

                if [[ $col_name =~ ^[a-z_A-Z]+[a-zA-Z_0-9]+$  ]];then

                    read -p "Seclect Column DataType [int OR string] : " choice

                    case $choice in 
                    "int")
                        if [ $counter -eq 0 ];then
                            constraint_of_col="PK"
                        else
                            constraint_of_col="null"
                        fi

                        record="$col_name:$choice:$constraint_of_col"
                        echo $record >> "$table_name meta_data.txt"
                        echo "Data added Successfully!!!!"
                        echo "$col_name : DataType is $choice and column constraint is $constraint_of_col ."
                        counter=$(($counter+1))
                    ;;
                    "string")
                        if [ $counter -eq 0 ];then
                            constraint_of_col="PK"
                        else
                            constraint_of_col="null"
                        fi

                        record="$col_name:$choice:$constraint_of_col"
                        echo $record >> "$table_name meta_data.txt"
                        echo "$col_name : DataType is $choice and column constraint is $constraint_of_col ."
                        counter=$(($counter+1))
                    ;;
                    *)
                        echo "Sorry!! you must Enter int or string Datatype"
                    ;;
                    esac         
                else
                    echo "You Entered Invalid Column Name !!!"
                    echo "Please Tty Again!!"
                fi 
            done

            if [[ $counter -eq $columns_num ]];then
                break
            fi
        else
            echo "This table is Exsit!, Please enter another table name."
        fi
    else 
        echo "You Enter Invalid Table Name "
        echo "Please Try Again!"
    fi 
done
    
