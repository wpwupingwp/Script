#!/bin/bash

sudo mv /usr/lib/xorg/modules/extensions/libglx.so /usr/lib/xorg/modules/extensions/libglx.so.bak
sudo cp /usr/lib/nvidia/current/libglx.so /usr/lib/xorg/modules/extensions/libglx.so 
