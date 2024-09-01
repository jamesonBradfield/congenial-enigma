ok, so we need to be able to grab our line, find which column we're on, and every keystroke we need to edit the normal text out of our line, and reinsert it into the buffer.

we need a way to edit the text out of the buffer, I believe an array should be created every time mode is changed into insert mode. and we add our keystroke to that array. We can then string.match that array to replace the text with our icons

ok, we can also live update our line by grabbing our row parsing where our cursor is and replacing that row with our new line.
## this will require a couple things
    - being able to iterate through a string one character at a time (counting \t as one character)
    - using said iterator to grab what we are typing and replace it with our icon
    - and sticking the line back in the buffer.
