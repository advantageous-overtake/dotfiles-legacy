#!/bin/sh

xrandr --dpi 84

${1:-i3} > /dev/null