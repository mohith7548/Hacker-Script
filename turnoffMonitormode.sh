# !/bin/bash

#val=`ifconfig | grep flags | grep PROMISC | awk -F ":" '{print $1}'`
val=`iw dev | awk '$1=="Interface"{print $2}'`
sudo ifconfig $val down
sudo iwconfig $val mode managed
sudo ifconfig $val up
sudo service NetworkManager restart
