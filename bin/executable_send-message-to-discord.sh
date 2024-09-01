~/bin/getCurrentWorkspacesAndMove.sh set
quick_switcher_input=$(tac /home/jamie/bin/lastDiscordMessage | grep -P "\(\#{1}\w*[^,]*" | rofi -dmenu -p "Choose Who To reply to:")
message_input=$(echo "" | rofi -dmenu -p "enter message:");
[ message_input == "" | quick_switcher_input == "" ] && exit 0
discordWorkspace=$(~/bin/getWorkspaceWithProgram.sh discord)
i3 workspace $discordWorkspace
xdotool windowFocus 62914570
i3 fullscreen toggle
sleep .3
xdotool key --window 62914570 ctrl+k
xdotool type --window 62914570  --clearmodifiers "${quick_switcher_input}"
sleep .2
xdotool type --window 62914570  --clearmodifiers "${message_input}"
xdotool key Return
i3 fullscreen toggle
echo "${oldclip}" | xclip -selection clipboard
~/bin/getCurrentWorkspacesAndMove.sh get
