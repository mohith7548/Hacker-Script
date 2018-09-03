# !/bin/bash

#val=`ifconfig | grep flags | grep PROMISC | awk -F ":" '{print $1}'`
val=`iw dev | awk '$1=="Interface"{print $2}'`
echo $val
sudo ifconfig $val down
sudo iwconfig $val mode monitor
sudo ifconfig $val up
sudo airmon-ng check kill wlo1
sudo airodump-ng $val
