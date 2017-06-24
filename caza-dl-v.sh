#!/bin/bash

#============================================About==================================================#
# This is a complete rework of the cazamusic script.
# It downloads youtube videos.
# No need to execute as root.
#============================================Information============================================#
# Author: Cazawhi
# License: GPLv3
# Package: cazautils
#============================================Pre-Init===============================================#

# Path to config file
PATH_CFG="/home/$USER/cazautils.conf"

# Read strings from config file
source "$PATH_CFG"

# Check if Config-File was properly read
if [ -z "$STR_TESTING" ]
  then
    echo -e "Cannot find Config-File! Please change the string in the first few lines of cazacore. Exiting.."
    exit 1
fi

# Create broadcasts depending on colors 
PREFIX_NORMAL="${COLOR_BRACKET}[${COLOR_NORMAL}caza-dl${COLOR_BRACKET}]${COLOR_TEXT}"
PREFIX_CRITICAL="${COLOR_BRACKET}[${COLOR_CRITICAL}caza-dl${COLOR_BRACKET}]${COLOR_TEXT}"
PREFIX_PERFECT="${COLOR_BRACKET}[${COLOR_PERFECT}caza-dl${COLOR_BRACKET}]${COLOR_TEXT}"

# VRAM for cazacore
PATH_VRAM="$PATH_RVRAM"/"caza-dl video edition"


#============================================Init===================================================#

# Printout Init-Message
echo -e "$PREFIX_NORMAL Initializing caza-dl video editon $VERSION."; 

# Check if destination overwrites cache
if [ "$2" == "$PATH_VRAM" ]
  then
    sleep 2
    echo -e "$PREFIX_CRITICAL Initialization failed!";
    echo -e "$PREFIX_CRITICAL The destination overwrites the cache.";
    echo -e "$PREFIX_NORMAL It's over.";
    exit 1
fi

# Quit if no destination is given
if [ -z "$2" ]
  then
    # Closedown
    echo -e "$PREFIX_CRITICAL Initialization failed!"
    echo -e "$PREFIX_CRITICAL You have not given a destination for the files."
    echo -e "$PREFIX_NORMAL It's over."
    exit 1
fi

# Quit if no link is given
if [ -z "$1" ]
  then
    # Closedown
    sleep 2
    echo -e "$PREFIX_CRITICAL Initialization failed!"
    echo -e "$PREFIX_CRITICAL You have not given a link to download."
    echo -e "$PREFIX_NORMAL It's over."
    exit 1
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

# Link availability
BOO_ISREACHABLE=`curl --silent --head --location --output /dev/null --write-out '%{http_code}' "$1" | grep '^2'`

# Quit if no link is given
if [ -z "$BOO_ISREACHABLE" ]
  then
    # Closedown
    echo -e "$PREFIX_CRITICAL Initialization failed!"
    echo -e "$PREFIX_CRITICAL Given link is not available."
    echo -e "$PREFIX_NORMAL It's over."
    exit 1
fi

# Update youtube-dl silently
nohup "$PATH_YTDL" -U >/dev/null 2>&1 &

# Create VRAM-Directory and cd into it to workaround non-working download-paths
mkdir "$PATH_VRAM"
cd "$PATH_VRAM"

# Quit Init-Part
echo -e "$PREFIX_NORMAL Initialization finished.";

#============================================Downloading============================================#

# If Playlist is wanted ask for start/end and download silently
if [ -z $3 ]
  then
    echo -e "$PREFIX_NORMAL Starting the download.";
    "$PATH_YTDL" -i --socket-timeout 30 --console-title --no-playlist "$1" > "$PATH_LOGFILE" 2>&1
  else  
    if [ $3 == "playlist" ]
      then
        echo -e "$PREFIX_NORMAL Define playlist start video:";
        read READ_PLS
        echo -e "$PREFIX_NORMAL Define playlist end video:";
        read READ_PLE
        
        # Strings must contain only numbers
        if [[ $READ_PLS =~ [^[:digit:]] ]] && [[ $READ_PLS =~ [^[:digit:]] ]]
          then
            echo -e "$PREFIX_CRITCAL Given Strings are invalid.";
            cd
            rm -rf "$PATH_VRAM"
            echo -e "$PREFIX_NORMAL It's over.";
            exit 1
          else
            NEW_PLE=`echo "$(($READ_PLE+1))"`
            echo -e "$PREFIX_NORMAL Starting playlist download.";
            "$PATH_YTDL" -i --console-title --yes-playlist --playlist-start "$READ_PLS" --playlist-end "$NEW_PLE" "$1" > "$PATH_LOGFILE" 2>&1
        fi
      else
        "$PATH_YTDL" -i --socket-timeout 30 --console-title --no-playlist "$1" > "$PATH_LOGFILE" 2>&1
    fi
fi


#===========================================Finalization============================================#

# Download ending message
echo -e "$PREFIX_PERFECT Downloading finished.";
echo -e "$PREFIX_NORMAL Finalizing now.";

# Find dead files and kill'em
if [[ $(ls -A | grep .part) ]]
  then
    echo -e "$PREFIX_CRITICAL The following files couldn't be downloaded properly and will be deleted:";
    find . -type f -name '*.part' -print -delete
fi

# Check if VRAM is empty (Handled Error: Download Failure)
if [ ! -n "$(ls -A "$PATH_VRAM")" ]
  then
    echo -e "$PREFIX_CRITICAL No files were downloaded!"
    echo -e "$PREFIX_NORMAL Cleaning up VRAM..";
    rm -rf "$PATH_VRAM"
    cd
    echo -e "$PREFIX_NORMAL It's over.";
    exit 1
fi

# Remove last 16 chars of files and add ending .mp4
rename 's/.{16}$//' *
sleep 3
for f in *; do mv "$f" "$f.mp4"; done

# Create Destination Folder if not existing
if [ ! -d "$2" ]
  then
    mkdir "$2"
fi

# Move files if folder is available - remain in VRAM if not
if [ -d "$2" ]
  then
    mv "$PATH_VRAM"/* "$2"
    cd
    rm -rf "$PATH_VRAM"
    echo -e "$PREFIX_PERFECT All files have been moved, the task is finished. Leaving!";
    exit 0
  else
    echo -e "$PREFIX_CRITICAL Can't reach the target directory! The files will remain in VRAM. Clean VRAM before using caza-dl again.";
    echo -e "$PREFIX_NORMAL It's over.";
    cd
    exit 1
fi

exit 0
