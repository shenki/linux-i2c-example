# Simple Linux i2c example

This is a simple program to read a byte from an i2c client under Linux. It is
provided as example code; if you want a real program use
[i2cget](https://linux.die.net/man/8/i2cget) from the
[i2c-tools](https://github.com/groeck/i2c-tools) package.

It assumes the i2c client does not have a driver bound to it. If you have a
driver bound, it might look like this:

```
# i2c_example /dev/i2c-9 0x4a 0
i2c_example: Tried to set device address '0x4a': Device or resource busy
```

To unbind, use sysfs:

```
# ls /sys/bus/i2c/drivers/lm75
9-004a  bind    uevent  unbind
# echo 9-004a > /sys/bus/i2c/drivers/lm75/unbind
```

If you want to go in to expert mode, change `I2C_SLAVE` to `I2C_SLAVE_FORCE`
in the `ioctl` which will let you read from the client even with a driver
bound. If you do this you get to keep both pieces.

## Building

The program assumes you have a GCC called `arm-linux-gnueabi-gcc` in your path.
On Ubuntu, this can be installed with `apt-get install gcc-arm-linux-gnueabi`.

If you obtain your compiler through different means, update the `CROSS_COMPILE`
prefix in `Makefile` with the prefix of your compiler.

If you want to compile natively, unset the `CROSS_COMPILE` variable.


```
$ make
arm-linux-gnueabi-gcc -Wall -std=gnu11 -ggdb   -c -o i2c_example.o i2c_example.c
arm-linux-gnueabi-gcc -static i2c_example.o -o i2c_example
```

This builds a statically linked program that you can then copy to the target machine.

## Usage

```
# i2c_example
i2c_example: path [i2c address] [register]

# i2c_example /dev/i2c-3 0x76 0x1
/dev/i2c-3: device 0x76 at address 0x01: 0x00
```
