#!/bin/bash
# author : Ahmed Gamal 

while [ true ]; do
    echo -e "${cyan}Please, Enter Table Name which you want to insert data :${clear}"
    read table_name
    if [[ $table_name =~ ^[a-z_A-Z]+[a-zA-Z_0-9]+$ ]]; then
        if [[ -f $table_name ]]; then

            #get count of cloumns
            counter=$(wc -l "$table_name meta_data.txt" | cut -d " " -f1)
            col_names=()
            col_names=($(awk -F':' '{print $1}' "$table_name meta_data.txt"))
            col_datatypes=()
            col_datatypes=($(awk -F':' '{print $2}' "$table_name meta_data.txt"))

            i=0
            table_data=""
            pks=() # the primary key 
            while [ $i -lt $counter ]; do
                if [ ${col_datatypes[$i]} = "int" ]; then
                    # flag=true
                    while [[ true ]]; do
                        echo -e "${cyan}Enter ${col_names[$i]} Value:${clear}"
                        read user_entry
                        if [[ $user_entry =~ ^[0-9]+$ ]]; then
                            pks=($(sed -n '1,$'p $table_name | cut -d: -f1))
                            flag2=true
                            for j in ${pks[@]}; do
                                if [ $j -eq $user_entry ]; then
                                    echo -e "${red}cannot redundant primary key :(${clear}"
                                    flag2=false
                                    break
                                fi
                            done
                            if [[ $flag2 == true ]]; then
                                break
                            fi
                        else 
                            echo -e "${red}You Enter Invalid value please enter the integer value${clear}"
                        fi
                    done
                    table_data+="$user_entry:"
                    i=$(($i + 1))

                    ####### string Type #####
                elif [ ${col_datatypes[$i]} = "string" ]; then
                    # flag=true
                    while [[ true ]]; do
                        echo -e "${cyan}Enter ${col_names[$i]} Value:${clear}"
                        read user_entry
                        if [[ $user_entry =~ ^[a-z_A-Z]+$ ]]; then
                            pks=($(sed -n '1,$'p $table_name | cut -d: -f1))
                            flag2=true
                            for j in ${pks[@]}; do
                                if [[ $j == $user_entry ]]; then

                                    echo -e "${red}cannot redundant primary key :(${clear}"
                                    flag2=false
                                    break
                                fi
                            done
                            if [[ $flag2 == true ]]; then
                                break
                            fi
                        else 
                            echo -e "${red}Invalid input please enter the string value ${clear}"
                        fi
                    done
                    table_data+="$user_entry:"
                    i=$(($i + 1))
                fi
            done
            echo "$table_data" >>$table_name
            echo -e "${green}Data Stroed Successfuly${clear}"
            break
        else
            echo -e "${red}This table does't exist !!, Please enter another name.${clear}"
        fi
    else
        echo -e "${red}You Enter Invalid Table Name !!!${clear}"
        echo -e "${red}Please Try Again!!${clear}"
    fi
done
