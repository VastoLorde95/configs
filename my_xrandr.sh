#!/bin/bash

# use arandr to configure and then save the settings
# then copy them over here using some kind of condition

if xrandr | grep "DP-4 connected" 
then 
    # Home setup with 42" LG
    xrandr --output eDP-1 --off --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output DP-3 --off --output DP-4 --primary --mode 3840x2160 --pos 0x0 --rotate normal
else
    # Default
    xrandr --auto
fi
