#!/bin/sh

export RF_RGB_KERNEL="$1:1.0"
echo -n "$1" > /etc/udev/rules.d/topre_keyboard_kernel
exit 0
