#!/bin/bash
export PATH
currentPicturePath=$(/bin/variety --current)
currentPicturePath="${currentPicturePath%/*}/"
if [[ "$currentPicturePath" == "/home/jamie/.config/variety/Fetched/" ]]; then
  variety --set-option fetched_folder "~/Pictures/Homework/ecchi"
  variety -n
  dunstify "variety dir is LEWD"
else
  variety --set-option fetched_folder "~/.config/variety/Fetched/"
  variety -n
  dunstify "variety dir is SFW"
fi
variety --preferences
i3 workspace number 10
sleep 1
i3 fullscreen enable
xdotool mousemove --sync 79 261
# sleep 1
xdotool click --clearmodifiers --window Variety 1
xdotool mousemove --sync 1843 375
sleep 1
xdotool click --clearmodifiers --window Variety 1
sleep .01
variety -n
xdotool key Super_L+Shift+q

