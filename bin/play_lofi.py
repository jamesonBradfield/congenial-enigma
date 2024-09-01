from rofi import Rofi
import os, random
# TODO: write project manager script to jump between directories/projects easier
r = Rofi()
options = ['Shuffle Music','Stop', 'Quit']
index, key = r.select('What would you like to do?', options)
if index == 0: 
    os.subprocess.run()
