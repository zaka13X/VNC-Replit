#!/bin/bash
set -e

mkdir -p /root/.vnc
printf 'novnc\nnovnc\n' | tigervncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd

vncserver :1 -geometry 1280x800 -depth 24

exec websockify --web /usr/share/novnc/ 6080 localhost:5901
