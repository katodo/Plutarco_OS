#!/bin/bash  
DIR="/home/plutarco"
#PIC=$(ls $DIR/* | shuf -n1)
#PIC=$DIR/ip.jpg
PIC="/home/plutarco/ip.jpg"
export DISPLAY=:0.0  
# Create white background image
convert -size 480x800 xc:gray base.jpg

# Create IP image
convert base.jpg -pointsize 30 -fill lime -draw "text 70,100 'IPv4 eth0: $(ip -4 a s eth0 | grep -Eo 'inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | awk '{print $2}')'" -fill blue -draw "text 70,150 'IPv4 wlan2: $(ip -4 a s wlan2 | grep -Eo 'inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | awk '{print $2}')'" -fill black -draw "text 70,200 'Hostname: $(uname -n)'" -pointsize 15 -draw "text 100,500 'Date $(date)'" ip.jpg 

# Uncomment this one if you're not using gnome:  
# feh --bg-scale ./3.jpg  
# and place a # (hash) for the following rule:   
# gconftool-2  -t string -s /desktop/gnome/background/picture_filename ./ip.jpg 

gsettings set com.canonical.unity-greeter draw-user-backgrounds true
gsettings set org.gnome.settings-daemon.plugins.background active true
gsettings set org.gnome.desktop.background picture-uri "file:///home/plutarco/ip.jpg"

