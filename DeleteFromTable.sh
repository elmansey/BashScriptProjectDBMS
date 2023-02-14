#!/bin/bash

while [ true ]; do
    echo -e "${cyan}Enter Table Name you want to delete row from them : ${clear}"
    read table_name
    if [[ $table_name =~ ^[a-z_A-Z]+[a-zA-Z_0-9]+$ ]]; then
        if [ -f $table_name ]; then
            break
        else
            echo -e "${red}The table name not found please try again ${clear}"
        fi
    fi
done

# get the condition column  where column ===> value #
while [ true ]; do
    echo -e "${cyan}Enter the name for column you want to use it in delete condition (WHERE CONDITION => WHERE [column] ) :${clear}"
    read  condition_column
    if [[ $condition_column =~ ^[a-z_A-Z]+[a-zA-Z_0-9]+$ ]]; then
        checkIfExist=$(awk -F':' -v condition_column=$condition_column '{if($1==condition_column){print $1}}' "$table_name meta_data.txt")
        DataType=$(awk -F':' -v condition_column=$condition_column '{if($1==condition_column){print $2}}' "$table_name meta_data.txt")
        if ! [ -z "$checkIfExist" ]; then
            while [ true ]; do
                # if the data type is int
                if [[ $DataType == "int" ]]; then
                    while [ true ]; do
                        echo -e "${cyan}Enter the value for column [$condition_column] to delete any row Fulfill this condition (WHERE CONDITION => WHERE [$condition_column] = [value]  ) :${clear} "
                        read condition_column_value
                        if [[ "$condition_column_value" =~ ^[0-9]+$ ]]; then
                            break
                        else
                            echo -e "${red}Please Enter The INTEGER value Because the data type for [$condition_column] is int !${clear}"
                        fi
                    done
                # if the data type is string
                elif [[ $DataType == "string" ]]; then
                    while [ true ]; do
                        echo -e "${cyan}Enter the value for column [$condition_column] to delete any row Fulfill this condition (WHERE CONDITION => WHERE [$condition_column] = [value] ) : ${clear}"
                        read condition_column_value
                        if [[ "$condition_column_value" =~ ^[a-z_A-Z]+$ ]]; then
                            break
                        else
                            echo -e "${red}Please Enter The String value Because the data type for [$condition_column] is string !${clear}"
                        fi
                    done
                fi
                break
            done
            break
        else
            echo -e "${red}Column Not found !${clear}"
        fi
    fi
done

# delete the row Fulfill this condition #
getConditionColumnPosition=$(awk -F':' -v condition_column=$condition_column '{if($1==condition_column){print NR}}' "$table_name meta_data.txt")
RowIndexes=()
typeset -i rowDeletedNumber=0
# get the row index for any row Fulfill this condition
RowIndexes+=($(awk -F':' -v getConditionColumnPosition=$getConditionColumnPosition -v condition_column_value=$condition_column_value '{if($getConditionColumnPosition==condition_column_value){print NR}}' $table_name))
len=${#RowIndexes[@]}
if [[ $len == 0 ]]; then
    echo -e "${yellow}Your condition did not match any row , 0 row affected :(${clear}"
else
    if [[ $len > 1 ]];then
        for i in "${RowIndexes[@]}"; do
            echo $i
            row=$(($i - $rowDeletedNumber))
            sudo sed -i "$row d" $table_name 2>/dev/null
            ((rowDeletedNumber += 1))
        done
    else 
        for i in "${RowIndexes[@]}"; do
            sudo sed -i "$i d" $table_name 2>/dev/null
            ((rowDeletedNumber += 1))
        done
    fi
   
    # deleted successflly #
    echo -e "${green}deleted Successfully :)${clear}"
    echo -e "${green}Query OK, "$rowDeletedNumber" row affected${clear}"
fi


