#!/bin/zsh
# this is all hardcoded garbage, on brave with i3 padding of 60 outer, and 75% zoom in brave browser 
prefix=$(rofi -dmenu -p "Enter Prefix")
suffix=$(rofi -dmenu -p "Enter Suffix")
# prefix="nf-md-alpha_"
# suffix="_box"
search_bar_location_x=1070
search_bar_location_y=538
click_location_x=160
click_location_y=600

clear_search_bar_and_enter_info() {
  xdotool mousemove --sync $search_bar_location_x $search_bar_location_y
	xdotool click 1
	xdotool click 1
	xdotool click 1
  xdotool type --delay 10 "$prefix $suffix"
}

if test -f /home/jamie/projects/aesthetic_text/icons/$prefix$suffix.lua; then
	dunstify "File $prefix$suffix.lua already exists, you should check if it has the correct content, and if not delete it"
else
	clear_search_bar_and_enter_info
	echo "return {" >> /home/jamie/projects/aesthetic_text/icons/$prefix$suffix.lua
	for letter in {a..z} ; do
		sleep .1
		xdotool mousemove --sync $click_location_x $click_location_y
		# dunstify "Mouse Moved to ${click_location_x} ${click_location_y}"
		xdotool click 1
		echo "${letter}='$(xclip -o -sel clip)'," >> /home/jamie/projects/aesthetic_text/icons/$prefix$suffix.lua
		click_location_x=$((click_location_x+117))
		if [[ "$click_location_x" -ge 1860 ]]; then
			click_location_y=723
			click_location_x=160
		fi
	done
	echo "}" >> /home/jamie/projects/aesthetic_text/icons/$prefix$suffix.lua
fi
# for number in {1..10} ; do
# 	xdotool type --delay 10 "${prefix} ${number} ${suffix}"
# 	sleep 0.5
# 	xdotool key Return
# 	sleep 0.5
# 	xdotool click 1 ${click_location_x} ${click_location_y}
# 	xclip -o -sel clip
# done
