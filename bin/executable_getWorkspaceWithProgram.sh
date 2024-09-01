#!/bin/bash
    
function main {
    # If the argument is empty then run both functions else only run provided function as argument $1.
    # [ -z "$1" ] && { get; set; } || $1     
		[ -z "$1" ] && exit 0 || grep_func "$@"
}

function grep_func {
	echo "$(i3-msg -t get_workspaces | jq -r '.[] | .name' | /usr/bin/grep -o -P ".*.+$1.*")"
}


main "$@"

