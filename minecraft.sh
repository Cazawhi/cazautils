#!/bin/bash

#============================================About==================================================#
# This script is used to deliver easy-usable commands to start and exit minecraft.
# It automates the Open-Source Launcher "MultiMC", which can be found at
# https://github.com/MultiMC
#============================================Information============================================#
# Author: Cazawhi
# License: GPLv3
# Package: cazautils
#============================================Pre-Init===============================================#

# Path to config file
PATH_CFG="/home/$USER/.config/cazautils.conf"

# Read strings from config file
source "$PATH_CFG"

# Check if Config-File was properly read
if [ -z "$STR_TESTING" ]
  then
    echo -e "Cannot find Config-File! Exiting.."
    exit 1
fi

# Create broadcasts depending on colors
PREFIX_NORMAL="${COLOR_BRACKET}[${COLOR_NORMAL}cazaMC${COLOR_BRACKET}]${COLOR_TEXT}"
PREFIX_CRITICAL="${COLOR_BRACKET}[${COLOR_CRITICAL}cazaMC${COLOR_BRACKET}]${COLOR_TEXT}"
PREFIX_PERFECT="${COLOR_BRACKET}[${COLOR_PERFECT}cazaMC${COLOR_BRACKET}]${COLOR_TEXT}"

#============================================Init===================================================#

# Print Info-Text >MultiMC<
BOO_MULTIMC=`"$PATH_MULTIMC"/MultiMC --version | sed -n '1p' | awk '{print $1}'`

# Check for Print being not >MultiMC<
if [ "$BOO_MULTIMC" != "MultiMC" ]
  then
    echo -e "$PREFIX_CRITICAL Cannot find MultiMC-Binary. Please change the Path in config file. Exiting.."
    exit 1
fi


#============================================Function===============================================#

# Read for parametres
case $1 in
   "start")
     if ! on_ac_power
       then
         # not on ac
         echo -e "$PREFIX_CRITCAL You are currently not on AC power! Minecraft won't start."
         notify-send -t 6000 "You are currently not on AC power! Minecraft won't start."
         exit 1
       else
         # on ac
         nohup "$PATH_MULTIMC"/MultiMC >/dev/null 2>&1 &
         exit 0
     fi;;

   "stop")
     pkill MultiMC
     pkill -f "$PATH_MULTIMC"/bin/jars/
     notify-send -t 6000 "Minecraft closed."
     echo -e "$PREFIX_NORMAL Minecraft closed.";;

   "restart")
     pkill -f "$PATH_MULTIMC"/bin/jars/;;

*) echo -e "$PREFIX_CRITICAL whoops, syntax: start|stop|restart";;

esac

# Should happen everytime
exit 0
