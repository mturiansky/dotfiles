#!/bin/bash

export DISPLAY=:0
export BSPWM_SOCKET=/tmp/bspwm_0_0-socket
export XDG_RUNTIME_DIR=/run/user/1000

# trying to fix panel
# export GTK2_RC_FILES=/home/mark/.config/gtkrc-2.0
# export XAUTHORITY=/home/mark/.Xauthority
# export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

if [[ ! -S $BSPWM_SOCKET ]]; then
    echo "no socket no X, bye"
    exit 0
fi

if xrandr | grep "HDMI-1 connected" > /dev/null; then
    echo "hdmi"
    if pgrep panel > /dev/null; then killall panel; fi
    if pgrep keepassxc > /dev/null; then kill $(pgrep keepassxc); fi
    xrandr --output HDMI-1 --primary --auto --right-of eDP-1
    bspc monitor HDMI-1 -n 1 -d VI VII VIII IX X
    td=($(bspc query -D -m 1)); c=0
    for d in $(bspc query -D -m 0); do bspc desktop $d -s ${td[$c]}; ((c=c+1)); done
    bspc monitor 0 -s 1
    bspc config -m 0 top_padding 0
    /home/mark/.fehbg &
    /home/mark/.panel/panel &
else
    echo "no hdmi"
    if pgrep panel > /dev/null; then killall panel; fi
    if pgrep keepassxc > /dev/null; then kill $(pgrep keepassxc); fi
    td=($(bspc query -D -m 1)); c=0
    for d in $(bspc query -D -m 0); do bspc desktop $d -s ${td[$c]}; ((c=c+1)); done
    bspc monitor 1 -r
    bspc config -m 0 top_padding 35
    bspc wm -o
    bspc desktop ^1 -n I
    xrandr --output HDMI-1 --off
    xrandr --output eDP-1 --primary
    /home/mark/.fehbg &
    /home/mark/.panel/panel &
fi
