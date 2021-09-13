#!/bin/sh
# Script : finder.sh
# find number of files and number of matching lines with given string withing particular direcoty nad its sub-direcoty 
# check if number of arguments are valid, if input is invalid then exit with error code 1
# Author : Mehul Patel

if [ $# -ne 2 ]
then
    echo !Error: Invalid Total number of arguments
    echo Usage: ./finder.sh [1st arg] [2nd arg]
    echo [1st arg] : path to directory 
	echo [2nd arg] : text string to be searched
    exit 1	
fi

# arg 1 - path to directory
FILESDIR=$1

# arg 2 - text string to be searched
SEARCHSTR=$2

# check if directory exists, if direcoty does not exist then exit with error code 1  
if [ ! -d $FILESDIR ]
then
    echo !Error:No such directory
    echo Please enter valid directory path
    exit 1
fi

#if number of files with matching strings at given path
# find: find number of files in given directory or sub-directories at given path,  wc - l for count
x=$(grep -rcl "${SEARCHSTR}" "${FILESDIR}"| wc -l)

# find total matching lines
# grep : check if matching pattern/string, flag -r recurssive search  
y=$(grep -r "${SEARCHSTR}" "${FILESDIR}" | wc -l)

echo The number of files are ${x} and the number of matching lines are ${y}

exit 0 



