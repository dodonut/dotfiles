#!/bin/bash
str1=`xrandr | grep HDMI-1 | grep disconnected`


if (test -n "$str1"); then
    xrandr --output HDMI-2 --off --output HDMI-1 --off --output DP-1 --off --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-2 --off
else
    xrandr --output HDMI-2 --off --output HDMI-1 --mode 1920x1080 \
        --pos 0x0 --rotate normal --output DP-1 --off \
        --output eDP-1 --off --output DP-2 --off
fi
