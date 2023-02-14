#!/bin/bash
# author : Abdelrahman Elmansey 

# get the table name and check if exist #
while [ true ]; do
    echo -e "${cyan}Enter Table Name you want to update them :${clear}"
    read table_name
    if [[ $table_name =~ ^[a-z_A-Z]+[a-zA-Z_0-9]+$ ]]; then
        if [ -f $table_name ]; then
            break
        else
            echo -e "${red}The table name not found please try again${clear}"
        fi
    fi
done

# get the condition column  where column ===> value #
while [ true ]; do
    echo -e "${cyan}Enter the name for column you want to use it in update condition (WHERE CONDITION => WHERE [column] ) : ${clear}"
    read condition_column
    if [[ $condition_column =~ ^[a-z_A-Z]+[a-zA-Z_0-9]+$ ]]; then
        checkIfExist=$(awk -F':' -v condition_column=$condition_column '{if($1==condition_column){print $1}}' "$table_name meta_data.txt")
        if ! [ -z "$checkIfExist" ]; then
            DataType=$(awk -F':' -v condition_column=$condition_column '{if($1==condition_column){print $2}}' "$table_name meta_data.txt")
            getConditionColumnPosition=$(awk -F':' -v condition_column=$condition_column '{if($1==condition_column){print NR}}' "$table_name meta_data.txt")
            while [ true ]; do
                # if the data type is int
                if [[ $DataType == "int" ]]; then
                    while [ true ]; do
                        echo -e "${cyan}Enter the value for this column in (WHERE CONDITION => WHERE $condition_column = [value]) :${clear}"
                        read  condition_column_value
                        if [[ "$condition_column_value" =~ ^[0-9]+$ ]]; then
                            break
                        else
                            echo -e "${red}Please Enter The INTEGER value Because the data type for [$condition_column] is int !${clear}"
                        fi
                    done
                # if the data type is string
                elif [[ $DataType == "string" ]]; then
                    while [ true ]; do
                        echo -e "${cyan}Enter the value for this column in (WHERE CONDITION => WHERE $condition_column = [value]) :${clear} "
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
    else
        echo -e "${red}Invalid Input !${clear}"
    fi
done

updateAnotherRow=true
while [[ $updateAnotherRow == true ]]; do
    # get name and value for column want to update it #
    while [ true ]; do
        echo -e "${cyan}Enter the name for column you want to update it : ${clear}"
        read updateColumn
        if [[ $updateColumn =~ ^[a-z_A-Z]+[a-zA-Z_0-9]+$ ]]; then
            checkIfExist=$(awk -F':' -v updateColumn=$updateColumn '{if($1==updateColumn){print $1}}' "$table_name meta_data.txt")
            if ! [ -z "$checkIfExist" ]; then
                getTheDataType=$(awk -F':' -v updateColumn=$updateColumn '{if($1==updateColumn){print $2}}' "$table_name meta_data.txt")
                getConstraint=$(awk -F':' -v updateColumn=$updateColumn '{if($1==updateColumn){print $3}}' "$table_name meta_data.txt")
                getUpdateColumnPosition=$(awk -F':' -v updateColumn=$updateColumn '{if($1==updateColumn){print NR}}' "$table_name meta_data.txt")
                dataTypeFlag=true
                PK_ConstraintFlag=true
                # get and check new value data type
                while [[ $dataTypeFlag == true || $PK_ConstraintFlag == true ]]; do
                    echo -e "${cyan}Enter the new value to set for column [$updateColumn]  : ${clear}"
                    read  newValue
                    # if the column data type is int
                    if [[ $getTheDataType == "int" ]]; then
                        if [[ $newValue =~ ^[0-9]+$ ]]; then
                            dataTypeFlag=false
                        else
                            echo -e "${red}Please Enter The INTEGER value Because the data type for [$updateColumn] is int !${clear}"
                        fi
                    fi
                    # if the column data type is string
                    if [[ $getTheDataType == "string" ]]; then
                        if [[ $newValue =~ ^[a-z_A-Z]+$ ]]; then
                            dataTypeFlag=false
                        else
                            echo -e "${red}Please Enter The String value Because the data type for [$updateColumn] is string !${clear}"
                        fi
                    fi

                    # check value is unique or not if the column hase the PK constraint #
                    if [[ $getConstraint == "PK" ]]; then
                        checkIfUnique=$(cut -d: -f${getUpdateColumnPosition} $table_name | awk -F' ' -v newValue=$newValue '{if($1==newValue){print "true"}}')
                        if [[ $checkIfUnique == "true" ]]; then
                            echo -e "${red}This value already exists and this [$updateColumn] column is of type PK and must be unique:(${clear}"
                        else
                            PK_ConstraintFlag=false
                        fi
                    elif [[ $getConstraint == "null" ]]; then
                        PK_ConstraintFlag=false
                    fi
                done

                # update the row #
                RowNumber=()
                typeset -i rowUpdatedNumber=0
                RowNumber+=($(awk -F':' -v getConditionColumnPosition=$getConditionColumnPosition -v condition_column_value=$condition_column_value '{if($getConditionColumnPosition==condition_column_value){print NR}}' $table_name))
                len=${#RowNumber[@]}
                if [[ $len == 0 ]]; then
                    echo -e "${red}Your condition did not match any row , 0 row affected :(${clear}"
                else
                    if [[ $len > 1 && $getConstraint == "PK" ]]; then
                        echo -e "${red}Sorry PK cannot be modified by the same value in more than one row (This given condition will be affected more than row)${clear}"
                    else
                        for i in "${RowNumber[@]}"; do
                            oldRow=($(awk -v RowNumber=$i 'BEGIN{FS=":"}{if(NR==RowNumber){print $0}}' $table_name))
                            newRow=($(awk -v RowNumber=$i -v getUpdateColumnPosition=$getUpdateColumnPosition -v newValue=$newValue 'BEGIN{FS=":";OFS=":"}{if(NR==RowNumber){$getUpdateColumnPosition=newValue;print $0}}' $table_name))
                            sudo sed -i 's/'$oldRow'/'$newRow'/g' $table_name 2>/dev/null
                            ((rowUpdatedNumber += 1))
                        done
                        # updated successflly #
                        echo -e "${green}Updated Successfully :)${clear}"
                        echo -e "${green}Query OK, "$rowUpdatedNumber" row affected${clear}"
                    fi
                fi

                break
            else
                echo -e "${red}Column Not found !${clear}"
            fi
        else
            echo -e "${red}Invalid Input !${clear}"
        fi
    done
    echo -e "${yellow}Are you want to update new column by the same condition in the same table  (y => to update another row  | or any another btn to cancel ) :${clear}"
    read  answer 
    if [[ $answer == "y" ]];then 
        updateAnotherRow=true
    else
        updateAnotherRow=false
        break
    fi
done
