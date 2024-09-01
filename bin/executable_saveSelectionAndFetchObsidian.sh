#!/bin/bash
mouseAtScriptStart=$(xdotool getmouselocation)
x=$(echo $mouseAtScriptStart | awk '{print $1}' | cut -d":" -f2)
y=$(echo $mouseAtScriptStart | awk '{print $2}' | cut -d":" -f2)
# focus vivaldi so click will register 
xdotool focusWindow 27262989 
xdotool mousemove --sync 1636 1582;
# right click to open context menu
xdotool click --clearmodifiers 3;
sleep .6;
# move to omnivore save and click
xdotool mousemove --sync 1636 1896;
xdotool click --clearmodifiers 1;
xdotool mousemove --sync 1568 1256;
sleep .4;
xdotool click --clearmodifiers  1;
xdotool mousemove --sync 1463 1380;
xdotool click --clearmodifiers 1;
xdotool mousemove --sync 1814 1269;
xdotool click --clearmodifiers 1;
i3-msg 'workspace 6:NoteTaking'
xdotool windowfocus 46137347;
xdotool mousemove 74 425;
xdotool mousemove --sync "$x" "$y"
xdotool focusWindow 27262989 
xdotool key Escape
