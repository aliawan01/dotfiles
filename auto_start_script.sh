#!/bin/bash

setxkbmap -option ctrl:swapcaps
xmodmap -e "keycode 51 = numbersign asciitilde numbersign asciitilde backslash bar"


