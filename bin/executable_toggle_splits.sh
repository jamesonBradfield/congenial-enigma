# This shell script is PUBLIC DOMAIN. You may do whatever you want with it.

TOGGLE=$HOME/bin/toggle/.toggle_splits

if [ ! -e $TOGGLE ]; then
    touch $TOGGLE
    i3 split h
else
    rm $TOGGLE
		i3 split v
fi
