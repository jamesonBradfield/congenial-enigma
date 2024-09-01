from rofi import Rofi
from os import system
from subprocess import run,PIPE
r = Rofi()
options = ['Write Flashcards', 'Review Flashcards', 'Quit']
index, key = r.select('What would you like to do?', options)
if index == 1:
    options  = str.splitlines(run(["ls", "/home/jamie/zettelkasten/HasCard/"],stdout=PIPE).stdout.decode('utf-8'))
    index, key = r.select('What would you like to study?', options)
    print("/bin/bash -c \"" + "alacritty -T 'HasCardReview' -e hascard run -s /home/jamie/zettelkasten/HasCard/{0}".format(options[index]) + "\"")
    system("/bin/bash -c \"" + "alacritty -T 'HasCardReview' -e hascard run -s /home/jamie/zettelkasten/HasCard/{0}".format(options[index]) + "\"") 
elif index == 0:
    system("/bin/bash -c \"" + "alacritty -T 'HasCardWrite' -e nvim '/home/jamie/zettelkasten/HasCard/' +'set filetype=HasCard'" + "\"") 
else:
    exit(0)
