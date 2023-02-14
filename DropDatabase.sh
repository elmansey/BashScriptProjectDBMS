#!/bin/bash
# author : Abdelrahman Elmansey 


while [ true ];do
    echo -e "${cyan}Please Enter Your Database Name , You Want to Remove it :${clear}"
    read DatabaseName
    if [[ $DatabaseName =~ ^[a-zA-Z]+[a-zA-Z_0-9]+$ ]];then 
        if [[ -e $DatabaseName ]];then
            while [ true ]; do
                echo -e "${yellow}are you sure you want to remove the database ${clear}${red}($DatabaseName)  :${clear} "
                select choice in "yes" "no"
                do 
                    case $choice in
                    "yes")
                        sudo rm -r $DatabaseName
                        echo -e  "${green}Database deleted successfully${clear}"
                        break
                    ;;
                    "no")
                        echo -e "${magente}good news :)${clear}"
                        break
                    ;;
                    *)
                        echo -e "${red}invaild choice ${clear}"
                    ;;
                    esac
                done
                break
                # if [[ $answer == "y" ]]
                # then 
                #     sudo rm -r $DatabaseName
                #     echo -e  "${green}Database deleted successfully${clear}"
                #     break
                # elif [[ $answer == "n"  ]];then
                #     echo -e "${magente}good news :)${clear}"
                #     break
                # fi
            done
            break
        else 
            echo -e "${red}The Database Name Not Exist${clear}"
        fi
    else 
        echo -e "${red}!! Invalid Name the database Name can't contain the space or special character except dash and can't begin by numbers !!${clear}"
    fi
done
