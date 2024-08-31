#!/usr/bin/env bash
# Terminate already running bar instances
killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
export KAMI_BACKGROUND="#2A2A37"
export EDGE_LABEL_LEFT="%{T3}%{F$KAMI_BACKGROUND}"
export EDGE_LABEL_RIGHT="%{T3}%{O1}%{F$KAMI_BACKGROUND}"

# Launch bar
polybar kanagawa -r --config='~/.config/polybar/config.ini' > ~/.alacrittylog.txt
