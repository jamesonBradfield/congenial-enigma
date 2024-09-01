#!/home/jamie/bin/gsudo.sh /bin/zsh
#NOTE: we are using the gsudo shebang for reasons unknown to me here is the link (https://superuser.com/questions/1320081/sudo-session-behavior-in-graphical-environment) I believe we are just using rofi to print stdin to stout. (that doesn't bode well for remote code execution)
#
# This shell script is PUBLIC DOMAIN. You may do whatever you want with it.

TOGGLE=/home/jamie/bin/toggle/.mullvadtoggle
# TODO: would like to scrape /etc/wireguard/ for all file names that end with .conf and display them with rofi
# NOTE: the problem is /etc/wireguard/ is read write protected so I need to sudo into it.
# HACK: as a workaround I will probably just scrape a file with all the filenames currently existing and use that. (we have a command that will scape that folder it just doesn't work in this script)
#
# touch /home/jamie/.filenames
# for filename in /etc/wireguard/* ; $(echo "$filename") >> /home/jamie/.filenames; done

if [ ! -e $TOGGLE ]; then
    touch $TOGGLE
		echo $(cat /home/jamie/.filenames | rofi -dmenu) >> $TOGGLE
		sudo -u "$SUDO_USER" dunstify -r 126 -i "~/bin/images/mullvad_minimal_transparent.png" "connecting to $(cat $TOGGLE)"
		wg-quick up /etc/wireguard/$(cat $TOGGLE);
		sleep .3
		sudo -u "$SUDO_USER" dunstify -r 126 -i "~/bin/images/mullvad_minimal_transparent.png" "$(curl https://am.i.mullvad.net/connected)"
else
		output=$(cat $TOGGLE)
    rm $TOGGLE
		wg-quick down /etc/wireguard/$output;
		sleep .3
		sudo -u "$SUDO_USER" dunstify -r 126 -i "~/bin/images/mullvad_minimal_transparent.png" "$(curl https://am.i.mullvad.net/connected)"
fi
