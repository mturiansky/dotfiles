#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then


    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then


    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


sxhkd &
urxvtd -q -f -o &
xsetroot -cursor_name left_ptr &
xset -b &
compton &

# if [ "$(xrandr | grep HDMI-1 | awk '{print $2}')" = "connected" ]; then
# 	xrandr --output eDP-1 --auto
# 	xrandr --output HDMI-1 --auto --left-of LVDS1 --primary
# else
# 	xrandr --output eDP-1 --auto --primary
# 	xrandr --output HDMI-1 --off
# fi

sh .fehbg &
exec bspwm
