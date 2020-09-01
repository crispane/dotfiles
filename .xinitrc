#!/bin/sh

eval $(/usr/bin/killall ssh-agent; /usr/bin/ssh-agent)
eval $(/usr/bin/killall gpg-agent; /usr/bin/gpg-agent --daemon)

## launch dropbox, if installed
[ -x ~/.dropbox-dist/dropboxd & ]
[ -x /usr/bin/redshift & ]
[ -x /usr/bin/udiskie & ]

## set Desktop background
#[ -f ~/.fehbg ] && sh ~/.fehbg &
[ ! -f ~/.gehbg ] && feh --bg-scale /home/f3nix/Dropbox/Wallpapers/nordarch.png

## set status bar output
while true; do
    xsetroot -name "$(uptime -p) | $(date "+%Y %b %d (%a) %I:%M%p")"
    # xsetroot -name "$(iwconfig enp6s0 | sed 's/ /\n/g' | grep ESSID) | $(iwconfig enp6s0 | sed 's/ /\n/g' | grep Quality) | $(uptime | sed 's/.*://; s/,//g') | $(date "+%F %R") |"
    sleep 1m
done &

## fix intellij idea grey screen
export _JAVA_AWT_WM_NONREPARENTING=1
export AWT_TOOLKIT=MToolkit
wmname LG3D

## start applications
udiskie &
redshift &
sxhkd &
## discord &
## transmission-gtk &

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

##twm &
##xclock -geometry 50x50-1+1 &
##xterm -geometry 80x50+494+51 &
##xterm -geometry 80x20+494-0 &
##exec xterm -geometry 80x66+0+0 -name login

wal -i "Dropbox/Wallpapers/nordarch.jpg" &
## launch dwm
exec dwm
