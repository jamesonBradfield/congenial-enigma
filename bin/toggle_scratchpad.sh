#!/usr/bin/zsh
# This shell script is PUBLIC DOMAIN. You may do whatever you want with it.

TOGGLE=$HOME/.toggle

if [ ! -e $TOGGLE ]; then
    touch $TOGGLE
		python ~/.config/rofi/i3-rofi-scratchpad/src/i3ipc_find_scratchpad.py
else
    rm $TOGGLE
		python ~/.config/rofi/i3-rofi-scratchpad/src/i3ipc_hide_all_scratchpad_window.py
fi
