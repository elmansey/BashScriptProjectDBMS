#!/bin/bash
echo -e "${cyan}Please, Enter Table Name which you want to select data ${clear}"
read table_name
if [[ $table_name =~ ^[a-z_A-Z]+[a-zA-Z_0-9]+$ ]]; then
    if [[ -f $table_name ]]; then
        select choice in "SelectAll" "SelectSpecificRow" "SelectCloumns" "Back to table menu"; do
            case $choice in
            "SelectAll")
                cat $table_name
            ;;
            "SelectSpecificRow")
                continueFlag=true
                while [[ $continueFlag == true ]]; do
                    col_names=()
                    col_names=($(awk -F':' '{print $1}' "$table_name meta_data.txt"))
                    echo -e "${cyan}please select the cloumn ${clear}"
                    res=()
                    select cname in ${col_names[@]}; do
                        ColumnPosition=$(awk -F':' -v column=$cname '{if($1==column){print NR}}' "$table_name meta_data.txt")
                        while [ true ]; do
                            # check if the column not in select choises
                            if ! [[ -z $ColumnPosition ]]; then
                                echo -e "${cyan}Enter $cname value to select Row by it:${clear}"
                                read value
                                res=($(awk -F':' -v ColumnPos=$ColumnPosition -v val=$value '{if($ColumnPos==val){print $0}}' "$table_name"))
                                len=${#res[@]}
                                if [[ $len == 0 ]]; then
                                    echo -e "${red}your condition not matched any rows :(${clear}"
                                else
                                    for i in ${res[@]}; do
                                        echo $i
                                    done
                                fi
                                break
                            else
                                echo -e "${red}invaild input this column not exist !${clear}"
                                break # this break for to go select again 
                            fi
                        done
                        break # if write choise go out from select 
                    done
                    echo -e "${yellow}are you want to select another rows y - or any ather  btn to cancel : "
                    read answer

                    if [[ $answer == "y" ]]; then
                        continueFlag=true
                    else
                        break
                    fi
                done
                ;;
            "SelectCloumns")
                col_names=()
                col_names=($(awk -F':' '{print $1}' "$table_name meta_data.txt"))
                echo -e "${cyan}please select the column ${clear}"
                select cname in ${col_names[@]}; do
                    ColumnPosition=$(awk -F':' -v column=$cname '{if($1==column){print NR}}' "$table_name meta_data.txt")
                    if ! [[ -z $ColumnPosition ]];then 
                        awk -F':' -v column=$ColumnPosition '{print $column}' "$table_name"
                        break # to break from select 
                    else 
                        echo -e "${red}invaild input this column not exist !${clear}"
                    fi
                done
            ;;
            "Back to table menu")
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
            ;;
            esac
        done
    else
        echo -e "${red}Table not exist ! ${clear}"
    fi
else
    echo -e "${red}Invalid input ${clear}"
fi
