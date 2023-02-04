#!/bin/bash

while [ true ]
do 
    read -p "Please, Enter Table Name which you want to insert data : " table_name
    if [[ $table_name =~ ^[a-z_A-Z]+[a-zA-Z_.0-9]+$ ]];then
        if [[ -f $table_name ]];then
            sudo chmod 777 $table_name
                
            counter=`wc -l "$table_name meta_data.txt" | cut -d " " -f1`
            #echo $counter

            declare -a col_names # declare an array 
            col_names=($(awk -F':' '{print $1}' "$table_name meta_data.txt"))
            declare -a col_datatypes
            col_datatypes=($(awk -F':' '{print $2}' "$table_name meta_data.txt"))
            #echo "${col_datatypes[1]}"
            declare -a col_constraints
            col_constraints=($(awk -F':' '{print $3}' "$table_name meta_data.txt"))


            i=0
            table_data=()
            while [ $i -lt $counter ]
            do
              #  echo "$table_name contains ${col_names[i   ]} and dataType of this column is  ${col_datatypes[i]} and it's constraints ${col_constraints[i]}"
              
              
                read -p "Enter ${col_names[$i]} Value: " user_entry

                #* Validate  int **
                echo "${col_datatypes[$i]}"

                   
                if [ ${col_datatypes[$i]} = "int" ]
                then

                    while ! [[ $user_entry =~ ^[0-9]+$ ]]
                    do
                        echo "You Entered Invalid value, Please Enter Integer value!!"
                        read -p "Enter ${col_names[i]} Value: " user_entry
                    done

                  #  pks=`sed -n '1,$'p $table_name| cut -f1 -d:`

                   # echo " values in cloumOne is "

                    #echo "${pks[*]}"
                    
                      # for j in $pks 
                      #  do					
                      #      if [[ $j -eq $user_entry ]];then
                      #         echo "cannot redundant primary key"
                      #         read -p "Enter ${col_names[$i]} Value: " user_entry
                      #         while ! [[ $user_entry =~ ^[0-9]+$ ]]
                      #          do
                      #             echo "You Entered Invalid value Please Enter ${col_names[$i]} value!!"
                      #              read -p "Enter ${col_names[$i]} Value: " user_entry
                      #         done
                      #          break
                      #     fi
                                    
                      #  done
                       
                       
                        table_data+=("$user_entry:")
                        i=$(($i+1))
                      

                    #* Validate  Strings **


                elif [ ${col_datatypes[$i]} = "string" ]
                
                then


                    while ! [[ $user_entry =~ ^[A-Z_a-z]+$ ]]
                    do
                            echo "You Entered Invalid value Please Enter ${col_names[$i]} value!!"
                            read -p "Enter ${col_names[$i]}  Value: " user_entry
                    done
                    table_data+=("$user_entry:")
                    i=$(($i+1))
                fi
                
            done

            echo "${table_data[*]}" >> $table_name
            echo " Data Stroed Successfuly"


            break
        else
            echo "This table does't exist !!, Please enter another name."
        fi
    else
        echo "You Enter Invalid Table Name !!!"
        echo "Please Try Again!!"
    fi
done