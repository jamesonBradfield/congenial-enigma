# script to Tiny-launch polybar

#!/usr/bin/zsh

echo "---" | tee -a /tmp/polybar2.log
polybar dropdown --config="~/.config/polybar/config.ini" >> /tmp/polybar2.log 2>&1

~                                                                                                    
~   
