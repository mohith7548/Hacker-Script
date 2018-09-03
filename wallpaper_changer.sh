# !/bin/bash

#PID=$(pgrep gnome-session)
#PID=$(pgrep -o gnome-shell)
#echo $PID
#export DBUS_SESSION_BUS_ADDRESS
#DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

fl=$(find /proc -maxdepth 2 -user "$LOGNAME" -name environ -print -quit)
for i in {1..5}
do
  fl=$(find /proc -maxdepth 2 -user "$LOGNAME" -name environ -newer "$fl" -print -quit)
done

export DBUS_SESSION_BUS_ADDRESS
DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS "$fl" | cut -d= -f2-)

DIR="$HOME/Downloads/Pexels-wallpapers"
PIC=$(ls $DIR/* | shuf -n1)
gsettings set org.gnome.desktop.background picture-uri "file://$PIC"

