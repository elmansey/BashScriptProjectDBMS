#!/bin/bash
# author : Abdelrahman Elmansey 

############################# List Databases ############################

# append indicator with the file (*) and with the directory (/) =>  (one of */=>@|) 

echo " "
echo -e "${magenta}=======================================${clear}(${cyan}List ${clear}${red}Databases${clear})${magenta}=======================================${clear}"
echo " "
echo -e "${cyan}"
ls -F | grep /
echo " "
count=$(ls -F | grep / | wc -l)
echo -e "${yellow}The Total Databases Count :${clear}" $count
echo " "
echo -e "${clear}"
