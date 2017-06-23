#!/bin/bash

#============================================About==================================================#
# This is a script to monitor device activity on remote ssh server.
# It pings hostnames and sends push messages if devices are online.
# Should be executed as root.
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
    echo -e "Cannot find Config-File! Please execute cazacore once before using the other scripts. Exiting.."
    exit 1
fi

# Color codes
COLOR_RED='\033[0;31m'
COLOR_NC='\033[0m'
COLOR_GREEN='\033[0;32m'
COLOR_DGRAY='\033[1;30m'

# Create broadcasts depending on colors 
PREFIX_NORMAL="${COLOR_BRACKET}[${COLOR_NORMAL}caza-dl${COLOR_BRACKET}]${COLOR_TEXT}"
PREFIX_CRITICAL="${COLOR_BRACKET}[${COLOR_CRITICAL}caza-dl${COLOR_BRACKET}]${COLOR_TEXT}"
PREFIX_PERFECT="${COLOR_BRACKET}[${COLOR_PERFECT}caza-dl${COLOR_BRACKET}]${COLOR_TEXT}"

#============================================Collecting information=================================#

echo -e "$PREFIX_NORMAL Initializing Cazawhi's Client Status Monitoring "$STR_VERSION"."

# Host 1
if [ ! $STR_HOST1 == "EMPTY" ]
  then
    if ssh $STR_CSMSRV "ping -c 1 $STR_HOST1" > /dev/null
      then
        notify-send -t 10 --urgency=low "Host $STR_HOST1 in network $STR_CSMSRV is online!"
    fi
fi

# Host 2
if [ ! $STR_HOST2 == "EMPTY" ]
  then
    if ssh $STR_CSMSRV "ping -c 1 $STR_HOST2" > /dev/null
      then
        notify-send -t 10 --urgency=low "Host $STR_HOST2 in network $STR_CSMSRV is online!"
    fi
fi

# Host 1
if [ ! $STR_HOST3 == "EMPTY" ]
  then
    if ssh $STR_CSMSRV "ping -c 1 $STR_HOST3" > /dev/null
      then
        notify-send -t 10 --urgency=low "Host $STR_HOST3 in network $STR_CSMSRV is online!"
    fi
fi

# Host 1
if [ ! $STR_HOST4 == "EMPTY" ]
  then
    if ssh $STR_CSMSRV "ping -c 1 $STR_HOST4" > /dev/null
      then
        notify-send -t 10 --urgency=low "Host $STR_HOST4 in network $STR_CSMSRV is online!"
    fi
fi

# Host 1
if [ ! $STR_HOST5 == "EMPTY" ]
  then
    if ssh $STR_CSMSRV "ping -c 1 $STR_HOST5" > /dev/null
      then
        notify-send -t 10 --urgency=low "Host $STR_HOST5 in network $STR_CSMSRV is online!"
    fi
fi

# Host 1
if [ ! $STR_HOST6 == "EMPTY" ]
  then
    if ssh $STR_CSMSRV "ping -c 1 $STR_HOST6" > /dev/null
      then
        notify-send -t 10 --urgency=low "Host $STR_HOST6 in network $STR_CSMSRV is online!"
    fi
fi

# Host 1
if [ ! $STR_HOST7 == "EMPTY" ]
  then
    if ssh $STR_CSMSRV "ping -c 1 $STR_HOST7" > /dev/null
      then
        notify-send -t 10 --urgency=low "Host $STR_HOST7 in network $STR_CSMSRV is online!"
    fi
fi

# Host 1
if [ ! $STR_HOST8 == "EMPTY" ]
  then
    if ssh $STR_CSMSRV "ping -c 1 $STR_HOST8" > /dev/null
      then
        notify-send -t 10 --urgency=low "Host $STR_HOST8 in network $STR_CSMSRV is online!"
    fi
fi

# Host 1
if [ ! $STR_HOST9 == "EMPTY" ]
  then
    if ssh $STR_CSMSRV "ping -c 1 $STR_HOST9" > /dev/null
      then
        notify-send -t 10 --urgency=low "Host $STR_HOST9 in network $STR_CSMSRV is online!"
    fi
fi

# Host 1
if [ ! $STR_HOST10 == "EMPTY" ]
  then
    if ssh $STR_CSMSRV "ping -c 1 $STR_HOST10" > /dev/null
      then
        notify-send -t 10 --urgency=low "Host $STR_HOST10 in network $STR_CSMSRV is online!"
    fi
fi

# Host 1
if [ ! $STR_HOST11 == "EMPTY" ]
  then
    if ssh $STR_CSMSRV "ping -c 1 $STR_HOST11" > /dev/null
      then
        notify-send -t 10 --urgency=low "Host $STR_HOST11 in network $STR_CSMSRV is online!"
    fi
fi

# Host 1
if [ ! $STR_HOST12 == "EMPTY" ]
  then
    if ssh $STR_CSMSRV "ping -c 1 $STR_HOST12" > /dev/null
      then
        notify-send -t 10 --urgency=low "Host $STR_HOST12 in network $STR_CSMSRV is online!"
    fi
fi

exit 0
