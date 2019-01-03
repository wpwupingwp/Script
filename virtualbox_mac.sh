#!/bin/bash

echo 1
VBoxManage modifyvm "mac"--cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff
echo 3
VBoxManage setextradata "mac" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3"
echo 4
VBoxManage setextradata "mac" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0"
echo 5
VBoxManage setextradata "mac" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple"
echo 6
VBoxManage setextradata "mac" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc"
echo 7
VBoxManage setextradata "mac" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1
echo 8
VBoxManage setextradata "mac" "VBoxInternal2/EfiGopMode" 4
