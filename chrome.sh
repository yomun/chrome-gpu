#!/usr/bin/env bash

#
# https://jasonmun.blogspot.my
# https://github.com/yomun
# 
# Copyright (C) 2017 Jason Mun
# 
#
##################################################################################
# x-www-browser 'chrome://gpu'
##################################################################################
# Graphics Feature Status
# CheckerImaging: Enabled
# Native GpuMemoryBuffers: Hardware accelerated
# Rasterization: Hardware accelerated
# Video Decode: Hardware accelerated
# Video Encode: Hardware accelerated
##################################################################################

if [ -f "/usr/bin/google-chrome-stable" ]
then

	FILE="/usr/share/applications/google-chrome.desktop"

	LINE_NUM=`grep -Fn 'Exec=/usr/bin/google-chrome-stable %U' ${FILE} | sed 's/:.*//g'`

	array=("--ignore-gpu-blacklist" "--enable-gpu-rasterization" "--enable-native-gpu-memory-buffers" "--enable-features=\"CheckerImaging\"")

	for ix in ${!array[*]} 
	do
		NUM_EXIST=`grep -Fn '${array[$ix]}' ${FILE} | sed 's/:.*//g'`

		if [ "${NUM_EXIST}" = "" ]
		then
			NEW="Exec=\/usr\/bin\/google-chrome-stable %U --ignore-gpu-blacklist --enable-gpu-rasterization --enable-native-gpu-memory-buffers --enable-features=\"CheckerImaging\""
			sed -i "${LINE_NUM}s/.*/${NEW}/" ${FILE}
			xdg-settings set default-web-browser google-chrome.desktop
			exit
		fi
	done

else
	xdg-open https://www.google.com/chrome/browser/desktop/
fi
