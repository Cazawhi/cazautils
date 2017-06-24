#!/bin/bash

#============================================About==================================================#
# This script is the core of the cazautils package.
# It is used to link all other scripts to bin, so executing becomes much easier.
# Execute it from the cazautils directory after cloning.
#============================================Information============================================#
# Author: Cazawhi
# License: GPLv3
# Package: cazautils
#============================================Pre-Init===============================================#

# Get current directory
PATH_SOURCE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Get cfg-File path
PATH_CFG="$PATH_SOURCE"/cazautils.conf

# Read strings from config file
source "$PATH_CFG"

# Check if Config-File was properly read
if [ -z "$STR_TESTING" ]
  then
    echo -e "Cannot find Config-File! Please change the string in the first few lines of cazacore. Exiting.."
    exit 1
fi

# Path where config file will be linked in
PATH_LNCONF="/home/$STR_USER/.config/cazautils.conf"

# Create broadcasts depending on colors
PREFIX_NORMAL="${COLOR_BRACKET}[${COLOR_NORMAL}cazacore${COLOR_BRACKET}]${COLOR_TEXT}"
PREFIX_CRITICAL="${COLOR_BRACKET}[${COLOR_CRITICAL}cazacore${COLOR_BRACKET}]${COLOR_TEXT}"
PREFIX_PERFECT="${COLOR_BRACKET}[${COLOR_PERFECT}cazacore${COLOR_BRACKET}]${COLOR_TEXT}"

# VRAM for cazacore
PATH_VRAM="$PATH_RVRAM"/cazacore


#============================================Init===================================================#

# Print welcome message
echo -e "$PREFIX_NORMAL Initializing cazautils corescript $STR_VERSION.";

# Handle RVRAM
if [ ! -d "$PATH_RVRAM" ]
  then
    # Create RVRAM
    echo -e "$PREFIX_NORMAL Workdirectory does not exist. Creating.."
    mkdir "$PATH_RVRAM"
    if [ ! -d "$PATH_RVRAM" ]
      then
        echo -e "$PREFIX_CRITICAL Couln't create Workdirectory. Exiting."
        exit 1
    fi
fi

# Quit on VRAM-Dir existance
if [ -d "$PATH_VRAM" ]
  then
    # Closedown
    echo -e "$PREFIX_CRITICAL Initialization failed!"
    echo -e "$PREFIX_CRITICAL The chosen VRAM-Directory already exists."
    echo -e "$PREFIX_NORMAL It's over."
    exit 1
fi

# Create cazacore-VRAM
mkdir "$PATH_VRAM"

# Quit if cannot be created
if [ ! -d "$PATH_RVRAM"/cazacore ]
  then
    # Closedown
    echo -e "$PREFIX_CRITICAL Initialization failed!"
    echo -e "$PREFIX_CRITICAL Couldn't create VRAM-Directory."
    echo -e "$PREFIX_NORMAL It's over."
    exit 1
fi

# Print finish message
echo -e "$PREFIX_PERFECT Initialization finished.";


#============================================Function===============================================#

# Change the Path to the config file in the other scripts
if [ ! -L "$PATH_LNCONF" ]
  then
    ln -s "$PATH_CFG" "$PATH_LNCONF"
fi

# Link all files to VRAM
ln -s "$PATH_SOURCE"/*.sh "$PATH_VRAM"
cd "$PATH_VRAM"

# Remove file endings
rename 's/.{3}$//' *

# Set executable-bit to all scripts
chmod +x *

# Move files in bin
mv "$PATH_VRAM"/* /home/$STR_USER/bin

# Check if mv worked
if [ "$(ls -A $PATH_VRAM)" ]; then
     echo -e "$PREFIX_CRITICAL Couldn't move files properly! Exiting.";
     rm -r "$PATH_VRAM"
     exit 1
fi

# Info
echo -e "$PREFIX_PERFECT Finished core function."


#============================================Fin===================================================#

# Delete VRAM
rm -r "$PATH_VRAM"

# Info
echo -e "$PREFIX_PERFECT Done."

# the end.
exit 0
