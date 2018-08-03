#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
setxkbmap gb
xrdb -merge ~/.Xresources
xsetroot -cursor_name left_ptr &
sh /home/night/.fehbg &

sxhkd &
exec bspwm

compton -c -b &
~/.userscripts/bar.sh | bar -p -g 1280x15 -B "#FFEEEEEE" -F "#FF222222" -f "-*-terminus-*-*-*-*-*-*-*-*-*-*-*-*" &
