#!/bin/bash

############################# List Tables ############################


# append indicator with the file (*) and with the directory (/) =>  (one of */=>@|) 

echo " "
echo -e "${magenta}=======================================${clear}(${cyan}List ${clear}${red}Databases${clear})${magenta}=======================================${clear}"
echo " " 
ls -F | grep "*" |cut -d " " -f1|grep "[^*]$" # grep to files [^*]$ == NOT ended with * 
echo " "
count=$(ls -F | grep "*" |cut -d " " -f1|grep "[^*]$"|wc -l)
echo -e "${yellow}The Total tables Count :${clear}" $count
