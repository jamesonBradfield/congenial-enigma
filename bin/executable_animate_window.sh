#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 5 ]; then
  echo "Usage: $0 <window_id> <start_x> <start_y> <end_x> <end_y>"
  exit 1
fi

# Parameters
WINDOW_ID=$1
START_X=$2
START_Y=$3
END_X=$4
END_Y=$5

# Animation parameters
STEPS=100        # Number of steps for the animation
DURATION=1       # Duration of the animation in seconds
SLEEP_TIME=$(echo "$DURATION / $STEPS" | bc -l)

# Easing function (simple quadratic ease-in-out)
ease_in_out_quad() {
  t=$1
  b=$2
  c=$3
  d=$4

  t=$(echo "$t / ($d / 2)" | bc -l)
  if (( $(echo "$t < 1" | bc -l) )); then
    echo "$b + $c / 2 * $t^2" | bc -l
  else
    t=$(echo "$t - 1" | bc -l)
    echo "$b - $c / 2 * (t * (t - 2) - 1)" | bc -l
  fi
}

# Move the window with easing
for i in $(seq 0 $STEPS); do
  t=$(echo "$i * $DURATION / $STEPS" | bc -l)
  
  CURRENT_X=$(ease_in_out_quad "$t" "$START_X" "$END_X" "$DURATION")
  CURRENT_Y=$(ease_in_out_quad "$t" "$START_Y" "$END_Y" "$DURATION")

  xdotool windowmove "$WINDOW_ID" "$(printf "%.0f" "$CURRENT_X")" "$(printf "%.0f" "$CURRENT_Y")"
  sleep "$SLEEP_TIME"
done
