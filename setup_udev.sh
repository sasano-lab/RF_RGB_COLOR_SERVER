#!/bin/sh

cp udev/90-topre-keyboard.rules /etc/udev/rules.d/
cp udev/set_rf_rgb_keyboard.sh /lib/udev/
sudo touch /etc/udev/rules.d/topre_keyboard_kernel
