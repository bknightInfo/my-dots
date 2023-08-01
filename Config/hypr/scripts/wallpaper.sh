#!/bin/sh

folder="${HOME}/.config/hypr/wallpapers"
# folder="${HOME}/Pictures"
pic=$(ls $folder/* | shuf -n1)

swww img -t any --transition-fps 90 $pic & &>/dev/null
sleep 1
