#!/bin/sh
# Prepare to build the FTDI module for LT4 21.4 on the NVIDIA Jetson TK1
if [ $(id -u) != 0 ]; then
   echo "This script requires root permissions"
   echo "$ sudo "$0""
   exit
fi
# Get the kernel source for LT4 21.4
cd /usr/src/
wget http://developer.download.nvidia.com/embedded/L4T/r21_Release_v5.0/source/kernel_src.tbz2
# Decompress
tar -xvf kernel_src.tbz2
cd kernel
# Get the kernel configuration file
zcat /proc/config.gz > .config

# Enable FTDI compilation
sudo sed -i 's/# CONFIG_USB_SERIAL_FTDI_SIO is not set/CONFIG_USB_SERIAL_FTDI_SIO=m/' .config

# Enable CP210X compilation
sudo sed -i 's/# CONFIG_USB_SERIAL_CP210X is not set/CONFIG_USB_SERIAL_CP210X=m/' .config


# Make sure that the local kernel version is set
LOCALVERSION=$(uname -r)
# vodoo incantation; This removes everything from the beginning to the last occurrence of "-"
# of the local version string i.e. 3.10.40 is removed
release="${LOCALVERSION##*-}"
CONFIGVERSION="CONFIG_LOCALVERSION=\"-$release\""
# Replace the empty local version with the local version of this kernel
sudo sed -i 's/CONFIG_LOCALVERSION=""/'$CONFIGVERSION'/' .config
# Prepare the module for compilation
make prepare
make modules_prepare
# Compile the module
make M=drivers/usb/serial/
# After compilation, copy the compiled module to the system area
cp drivers/usb/serial/ftdi_sio.ko /lib/modules/$(uname -r)/kernel
cp drivers/usb/serial/cp210x.ko /lib/modules/$(uname -r)/kernel

depmod -a
/bin/echo -e "\e[1;32mFTDI Driver Module Installed.\e[0m"
/bin/echo -e "\e[1;32mCP210X Driver Module Installed.\e[0m"

