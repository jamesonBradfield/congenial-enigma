#!/bin/bash
    
function main {
    # If the argument is empty then run both functions else only run provided function as argument $1.
    [ -z "$1" ] && { get; set; } || $1     
}

function get {
	mapfile X < lastWorkspace
	echo "${X[@]}"
	for var in "${X[@]}"
    do
    echo "$var"
    i3 workspace "$var"
    sleep 1;
  done  
}

function set {    
  echo "$(i3-msg -t get_workspaces | jq -r '.[] | select(.visible == true).name')" > lastWorkspace
}
    
    
main "$@"



