#!/bin/bash

#============================================About==================================================#
# This script is part of the cazautils package.
# It is used to connect via ssh to all servers you want it to and push a script there. (can be locally too!)
# The script will be executed automatically and removed after execution.
# Mostly it is good for doing an update everyhwere.
#============================================Information============================================#
# Author: Cazawhi
# License: GPLv3
# Package: cazautils
#============================================Pre-Init===============================================#

# Get cfg-File path
PATH_CFG="/home/$USER/.config/cazautils.conf"

# Read strings from config file
source "$PATH_CFG"

# Check if Config-File was properly read
if [ -z "$STR_TESTING" ]
  then
    echo -e "Cannot find Config-File! Please change the string in the first few lines of cazacore. Exiting.."
    exit 1
fi

# Counter
INT_COUNTER=0

# Create broadcasts depending on colors 
PREFIX_NORMAL="${COLOR_BRACKET}[${COLOR_NORMAL}cazacore${COLOR_BRACKET}]${COLOR_TEXT}"
PREFIX_CRITICAL="${COLOR_BRACKET}[${COLOR_CRITICAL}cazacore${COLOR_BRACKET}]${COLOR_TEXT}"
PREFIX_PERFECT="${COLOR_BRACKET}[${COLOR_PERFECT}cazacore${COLOR_BRACKET}]${COLOR_TEXT}"

#==========================================Copying==================================================#

echo -e "$PREFIX_NORMAL Starting Cazawhi's distributed script execution "$STR_VERSION".."
echo -e "$PREFIX_NORMAL Starting script-copy.."

# Srv 1
if [ ! $STR_SRV1 == "EMPTY" ]
  then
    echo -e "$PREFIX_NORMAL 1 Server $STR_SRV1 found in config. Trying copy..."
    scp "$PATH_SCRIPT" $STR_SRV1:/home/$STR_SRV1USER/cazadse.sh
    if (( $? > 0 ))
      then
        echo -e "$PREFIX_CRITICAL Couldn't copy script to server.. Fatal!"
        exit 1
      else
        echo -e "$PREFIX_PERFECT Copied script to server."
    fi
  else
    echo -e "$PREFIX_CRITICAL No servers entered in config file... Exiting.."
    exit 1
fi

# Srv 2
if [ ! $STR_SRV2 == "EMPTY" ]
  then
    echo -e "$PREFIX_NORMAL 2 Server $STR_SRV2 found in config. Trying copy..."
    scp "$PATH_SCRIPT" $STR_SRV2:/home/$STR_SRV2USER/cazadse.sh
    if (( $? > 0 ))
      then
        echo -e "$PREFIX_CRITICAL Couldn't copy script to server.. Fatal!"
        exit 1
      else
        echo -e "$PREFIX_PERFECT Copied script to server."
    fi
fi

# Srv 3
if [ ! $STR_SRV3 == "EMPTY" ]
  then
    echo -e "$PREFIX_NORMAL 3 Server $STR_SRV3 found in config. Trying copy..."
    scp "$PATH_SCRIPT" $STR_SRV3:/home/$STR_SRV3USER/cazadse.sh
    if (( $? > 0 ))
      then
        echo -e "$PREFIX_CRITICAL Couldn't copy script to server.. Fatal!"
        exit 1
      else
        echo -e "$PREFIX_PERFECT Copied script to server."
    fi
fi

# Srv 4
if [ ! $STR_SRV4 == "EMPTY" ]
  then
    echo -e "$PREFIX_NORMAL 4 Server $STR_SRV4 found in config. Trying copy..."
    scp "$PATH_SCRIPT" $STR_SRV4:/home/$STR_SRV4USER/cazadse.sh
    if (( $? > 0 ))
      then
        echo -e "$PREFIX_CRITICAL Couldn't copy script to server.. Fatal!"
        exit 1
      else
        echo -e "$PREFIX_PERFECT Copied script to server."
    fi
fi

# Srv 5
if [ ! $STR_SRV5 == "EMPTY" ]
  then
    echo -e "$PREFIX_NORMAL 5 Server $STR_SRV5 found in config. Trying copy..."
    scp "$PATH_SCRIPT" $STR_SRV5:/home/$STR_SRV5USER/cazadse.sh
    if (( $? > 0 ))
      then
        echo -e "$PREFIX_CRITICAL Couldn't copy script to server.. Fatal!"
        exit 1
      else
        echo -e "$PREFIX_PERFECT Copied script to server."
    fi
fi

echo -e "$PREFIX_PERFECT Copying finished."

#==========================================Executing==================================================#

echo -e "$PREFIX_NORMAL Starting shells in 5 seconds. Change your Desktop if you want."
sleep 5

# Srv 1
if [ ! $STR_SRV1 == "EMPTY" ]
  then 
    nohup $STR_TERMINAL -hold -e "ssh $STR_SRV1 'bash cazadse.sh'" >/dev/null 2>&1 &
fi

# Srv 2
if [ ! $STR_SRV2 == "EMPTY" ]
  then
    nohup $STR_TERMINAL -hold -e "ssh $STR_SRV2 'bash cazadse.sh'" >/dev/null 2>&1 &
fi

# Srv 3
if [ ! $STR_SRV3 == "EMPTY" ]
  then
    nohup $STR_TERMINAL -e "ssh $STR_SRV3 'bash cazadse.sh'" >/dev/null 2>&1 &
fi

# Srv 4
if [ ! $STR_SRV4 == "EMPTY" ]
  then
    nohup $STR_TERMINAL -e "ssh $STR_SRV4 'bash cazadse.sh'" >/dev/null 2>&1 &
fi

# Srv 5
if [ ! $STR_SRV5 == "EMPTY" ]
  then
    nohup $STR_TERMINAL -e "ssh $STR_SRV5 'bash cazadse.sh'" >/dev/null 2>&1 &
fi

echo -e "$PREFIX_PERFECT Done."
exit 0
