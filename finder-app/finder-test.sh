#!/bin/sh
# Tester script for assignment 1 and assignment 2
# Author: Siddhant Jajoo
# comments added by Mehul Patel

set -e
set -u

NUMFILES=10			 	#Default numfiles 10 
WRITESTR=AELD_IS_FUN 			#Default writestr “AELD_IS_FUN” 
WRITEDIR=/tmp/aeld-data 		#Default directory /tmp/aeld-data
username=$(cat conf/username.txt) 	#get username name from configuration file 

#check if number of file and string to be written is not entered then use default parameters 
if [ $# -lt 2 ]
then
	echo "Using default value ${WRITESTR} for string to write"
	if [ $# -lt 1 ]
	then
		echo "Using default value ${NUMFILES} for number of files to write"
	else
		NUMFILES=$1
	fi	
else #else take user arguments 
	NUMFILES=$1
	WRITESTR=$2
fi


MATCHSTR="The number of files are ${NUMFILES} and the number of matching lines are ${NUMFILES}"

echo "Writing ${NUMFILES} files containing string ${WRITESTR} to ${WRITEDIR}"

#remove old directory and create new directory 
# - p flag - if parent directory not present the create new parent as well 
rm -rf "${WRITEDIR}"
mkdir -p "$WRITEDIR"

#The WRITEDIR is in quotes because if the directory path consists of spaces, then variable substitution will consider it as multiple argument.
#The quotes signify that the entire string in WRITEDIR is a single string.
#This issue can also be resolved by using double square brackets i.e [[ ]] instead of using quotes.
if [ -d "$WRITEDIR" ]
then
	echo "$WRITEDIR created"
else
	exit 1
fi

#create NUMFILES number of files with username_1 to username_NUMFILES  and with WRITESTR data in each file
#using writer script within for loop 1 to NUMFILES

#echo "Removing the old writer utility and compiling as a native application"
#make clean
#make

for i in $( seq 1 $NUMFILES)
do
	#./writer.sh "$WRITEDIR/${username}$i.txt" "$WRITESTR"
	./writer "$WRITEDIR/${username}$i.txt" "$WRITESTR"
done

#now using finder script to find number of files and number of matching matching lines with WRITESTR at WRITEDIR directory  
OUTPUTSTRING=$(./finder.sh "$WRITEDIR" "$WRITESTR")

set +e
echo ${OUTPUTSTRING} | grep "${MATCHSTR}"
if [ $? -eq 0 ]; then
	echo "success"
	exit 0
else
	echo error
	echo "failed: expected  ${MATCHSTR} in ${OUTPUTSTRING} but instead found"
	exit 1
fi
