CROSS_COMPILE := arm-linux-gnueabi-

CC	:= $(CROSS_COMPILE)gcc

CFLAGS	:= -Wall -std=gnu11 -ggdb

SRC	:= i2c_example.c
OBJ	:= $(SRC:.c=.o)

PROG	:= i2c_example

all: $(PROG)

$(PROG): $(OBJ)
	$(CC) -static $^ -o $@

clean:
	$(RM) $(PROG) $(OBJ)
