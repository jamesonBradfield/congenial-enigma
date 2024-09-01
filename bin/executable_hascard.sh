#!/bin/zsh
if [ x"$@" = x"quit" ]
then
    exit 0
fi

if [ x"$@" = x"Write Flashcards" ]
then
	coproc ( alacritty -T 'HasCardWrite' -e nvim "/home/jamie/zettelkasten/HasCard/$(ls "/home/jamie/zettelkasten/HasCard/" | rofi -dmenu)" +"set filetype=HasCard"  > /dev/null 2>&1 )
	exit 0	
fi
if [ x"$@" = x"Review Flashcards" ]
then
	coproc ( alacritty -T 'HasCardReview' -e hascard run -s "/home/jamie/zettelkasten/HasCard/$(ls "/home/jamie/zettelkasten/HasCard/" | rofi -dmenu)" > /dev/null 2>&1 )
	exit 0
fi

echo "Write Flashcards"
echo "Review Flashcards"
echo "quit"
