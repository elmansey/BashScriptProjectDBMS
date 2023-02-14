#!/bin/bash

########################## The Project Entry Point ############################
################################### DBMS ######################################


## Check The DBMS Directory 
source colors.sh
if [[ -e "DBMS" ]];then 
    cd DBMS
else 
    sudo mkdir DBMS
    # chmod 777 DBMS
    if [[ -d "DBMS" ]];then 
        cd DBMS
    else
        echo -e "${red}Some Error was happen please try again :(${clear}"
    fi
fi

############### Show the select option ################

source ../MainOption.sh


