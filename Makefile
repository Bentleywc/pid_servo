CC          = gcc -c
LINK        = gcc
#CCFLAGS     = -O2 -Wall -std=gnu99 -Iinclude/ -g
CCFLAGS     = -O2 -Wall -I. -Iinclude/ -g
TARGET      = pid_servo
TARGETC     = pid_servo.c
#LDFLAGS     = -lpthread -lm -lact_util -Llib/ -l2600 -levent -lhiredis -lnidaqmxbase
LDFLAGS     = -lpthread -lmccusb -lm -static -lconfig
SERVO_FLAGS =

HEADERS     = pmd.h usb-1208FS.h circular_buffer.h usb-1608FS.h read_temp.h \
              servo_temp.h

OBJS        = circular_buffer.o read_temp.o servo_temp.o

all: $(TARGET)

$(TARGET): $(TARGETC) $(OBJS) $(HEADERS) Makefile $(LIB)
	$(LINK) $(CCFLAGS) $(SERVO_FLAGS) -o $(TARGET) $(TARGETC) $(OBJS) $(LDFLAGS)

%.o: %.c $(HEADERS) Makefile
	$(CC) $(CCFLAGS) $(SERVO_FLAGS) -c $<

again: clean all

.PHONY: clean
clean:
	-rm -f *~ $(OBJS) $(TARGET)