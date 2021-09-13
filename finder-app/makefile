#file: makefile for building executable file for native platform or with cross compilation specified at commandline(for eg. using aarch64-none-linux-gnu- toolchain)
#refernce : http://ecee.colorado.edu/~ecen5623/ecen/ex/Linux/sequencer_generic/Makefile
#author : Mehul Patel
#usage for crosscompilation: make CROSS_COMPILE=platform specificaion

INCLUDE_DIRS = 
LIB_DIRS = 
CC=$(CROSS_COMPILE)gcc


CDEFS=
CFLAGS= -g $(INCLUDE_DIRS) $(CDEFS)
LIBS= 

HFILES= 
CFILES= writer.c

SRCS= ${HFILES} ${CFILES}
OBJS= ${CFILES:.c=.o}

all:	writer  

writer: writer.o
	$(CC) $(LDFLAGS) $(CFLAGS) -o $@ $@.o 
	
clean:
	-rm -f *.o
	-rm -f writer

depend:

.c.o:
	$(CC) $(CFLAGS) -c $<
