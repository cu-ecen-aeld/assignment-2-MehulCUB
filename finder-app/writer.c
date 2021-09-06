/*
File: writer.c
function: to write given string in the file with given path 
	error checking 
		for number of arugmnets 
		for file path valid or not

Author : Mehul Patel 
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <syslog.h>
#include <libgen.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <errno.h>
 
#define SLEN 500	//length for file path- name 

int main(int argc, char* argv[])
{
	int fd;
	openlog(NULL,0,LOG_USER);
	
	//if wrong number of arguments then display error 
	if(argc!=3)
	{
		syslog(LOG_ERR, "!Error: Invalid Total number of arguments\n");
		syslog(LOG_ERR, "Usage: ./writer [1st arg] [2nd arg]\n");
		syslog(LOG_ERR, "[1st arg] : full path to file including filename\n");
		syslog(LOG_ERR, "[2nd arg] : text string to be written\n");
		
		printf("See LOG_ERR\n"); 
		exit(1);
	}
	
	char* writefile = argv[1];		// arg 1 - full path to file including filename 
	char* writestr = argv[2];		// arg 2 - text string to be written in this file
	
	printf("writefile %s\n", writefile);
	printf("writestr  %s\n", writestr);
	
	char filepath[SLEN]; 
	strcpy(filepath,writefile); 
	
	fd = open(filepath, O_CREAT | O_RDWR |O_TRUNC,0644);	//open/create file for write
															//permission : read write :  user,  group and other : only read
															//if file exist already - truncate length to 0 for write
	if(fd == -1)
	{	
		//if directory if not present create the directory including parent directory 
		if(errno == ENOENT)	//directory in pathname does not exist 
		{
			char filename[SLEN];
			strcpy(filename,basename(writefile));	// get file name
			 
			char dir_path[SLEN];
			strcpy(dir_path,dirname(writefile));	// get directory path 
			  
			char cmd[SLEN+10];
			sprintf(cmd, "mkdir -p %s", dir_path);  //create directory including parent directory 
			system(cmd); 
	
			fd = open(filepath,  O_CREAT | O_RDWR , 0644);	//create file in created directory 
			if(fd == -1)
			{
				syslog(LOG_ERR, "File open error: %s\n", strerror(errno));
				exit(1);
			}			
		}
		else
		{
			syslog(LOG_ERR,"!Error: Could not open file at %s",writefile);
			syslog(LOG_ERR,"File open error : %s\n",strerror(errno));
			printf("See LOG_ERR\n");
			exit(1);
		}		
	}
	 
	syslog(LOG_DEBUG,"File opened succesfully\n");

	int rc = write(fd, writestr, strlen(writestr)); //Write writestr string  to file 
	if(rc<0)   //check if writestr succesfully written or not
	{
		syslog(LOG_ERR, "File write error: %s\n", strerror(errno));
		printf("See LOG_ERR\n");
		exit(1);
	}
	 
	syslog(LOG_DEBUG,"Writing %s to %s\n", writestr, writefile);
	close(fd); //if file close succesfully written or not
	closelog();
	
	return 0;
}

