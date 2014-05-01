CROSS_COMPILE = arm-linux-gnueabi-
CC = $(CROSS_COMPILE)gcc

CFLAGS = -march=armv7-a -mtune=cortex-a8 -mfpu=neon -ftree-vectorize -ffast-math -mfloat-abi=softfp

all:
	$(CC) $(CFLAGS) neon.c -o basic-neon

asm:
	$(CC) -S neon.c

clean:
	rm -f *.o basic-neon
