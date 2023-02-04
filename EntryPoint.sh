#!/bin/bash

########################## The Project Entry Point ############################
################################### DBMS ######################################


## Check The DBMS Directory 

if [[ -e "DBMS" ]];then 
    cd DBMS
else 
    sudo mkdir DBMS
    # chmod 777 DBMS
    if [[ -d "DBMS" ]];then 
        cd DBMS
    else
        echo "Some Error was happen please try again :("
    fi
fi

############### Show the select option ################
source ../MainOption.sh


