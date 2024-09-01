#!/bin/bash

# Function to animate the window movement
animate_window() {
  WINDOW_ID=$1
  START_X=$2
  START_Y=$3
  END_X=$4
  END_Y=$5

  STEPS=100        # Number of steps for the animation
  DURATION=2       # Duration of the animation in seconds
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

  for i in $(seq 0 $STEPS); do
    t=$(echo "$i * $DURATION / $STEPS" | bc -l)

    CURRENT_X=$(ease_in_out_quad "$t" "$START_X" "$END_X" "$DURATION")
    CURRENT_Y=$(ease_in_out_quad "$t" "$START_Y" "$END_Y" "$DURATION")

    xdotool windowmove "$WINDOW_ID" "$(printf "%.0f" "$CURRENT_X")" "$(printf "%.0f" "$CURRENT_Y")"
    sleep "$SLEEP_TIME"
  done
}

# Main loop to monitor and animate Dunst notifications
while true; do
  # Search for the Dunst notification window
  WINDOW_ID=$(xdotool search --class "Dunst")

  # If a Dunst window is found, animate it
  if [ ! -z "$WINDOW_ID" ]; then
    START_X=1920
    START_Y=50
    END_X=1600
    END_Y=50

    animate_window "$WINDOW_ID" "$START_X" "$START_Y" "$END_X" "$END_Y"

    # Wait for the window to disappear before continuing
    while xdotool search --class "Dunst" &>/dev/null; do
      sleep 0.1
    done
  fi

  # Small delay to prevent high CPU usage
  sleep 0.1
done
