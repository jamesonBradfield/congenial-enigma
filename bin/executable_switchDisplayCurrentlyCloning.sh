#!/bin/bash
currentCloned=$(xrandr --listmonitors |grep -P -o '1080\s+\w*.*')
echo "$currentCloned"
if [[ "$currentCloned"=="1080  DisplayPort-1\n" ]];then
	xrandr --output HDMI-A-0 --same-as DisplayPort-1
fi

if [[ "$currentCloned"=="1080  DisplayPort-1\n1080  HDMI-A-0" ]];then
	xrandr --output HDMI-A-0 --same-as DisplayPort-2
fi



#NOTE: xrandr --listmonitors outputs the same position in the last number for cloned monitors, you can compare which lines are output/share that number to tell what monitor is currently cloned.
