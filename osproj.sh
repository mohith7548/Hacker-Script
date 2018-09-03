#!/bin/sh

# Color specific variables
RED='\033[0;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'

# Dependencies => figlet, htop, neofetch, speedtest-cli, net-tools
bash resdep.sh figlet
bash resdep.sh htop
bash resdep.sh neofetch
bash resdep.sh speedtest-cli
bash resdep.sh net-tools
bash resdep.sh redshift

# Clear screen
clear

# Banner
figlet "Hacker Script" -c

# Wish the user
printf "${WHITE}Hello ${YELLOW}"$LOGNAME
printf "!\n"

# Show Last read file
printf "${WHITE}Last opened: `stat -c '%x' ~/bash-scripts/os-project/osproj.sh`\n"
echo 

# Main while loop starts
while :
printf "${GREEN}--------------------------------------------\n"
printf "${WHITE}Select what you want to Do:\n"
printf "${GREEN} \n"
echo "0 - Tell me about this machine"
echo "1 - Bring up eye filter"
echo "2 - Show all Mac-addresses and Wifi Access points around me"
echo "3 - Change My mac-address"
echo "4 - Get info of all devices on my Network"
echo "e - To exit"
printf "${GREEN}--------------------------------------------\n"
printf ">${YELLOW} " 
do
  read INPUT_STRING
  case $INPUT_STRING in

	0)	echo 
		neofetch
		echo 
		;;

	1)	echo 
		#free -h | grep Mem | awk '{printf "RAM status: %sB/%sB\n", $3, $2}'
		printf "Enter a val between 1000 - 25000: "
		read val
		redshift -O $val
		echo 
		;;

	2)	echo 
		gnome-terminal -e "bash -c 'bash getallMacIds.sh && bash turnoffMonitormode.sh'"
		#printf "Total number of processes running currently: "
		#ps -aux | wc -l
		echo 
		;;

	3)	echo 
		echo "a - Get a Random mac-address"
		echo "b - Assign a specific mac-address"
		echo "c - Reset mac-address"
		printf "Enter an option: "
		read opt
		iname=`iw dev | awk '$1=="Interface"{print $2}'`
		case $opt in
			a)	sudo ifconfig $iname down
				sudo macchanger -r $iname
				sudo ifconfig $iname up
				;;

			b)	printf "Enter a mac address: "
				read random_mac_address
				sudo ifconfig $iname down
				sudo macchanger -m $random_mac_address $iname
				sudo ifconfig $iname up
				;;

			c)	sudo ifconfig $iname down
				sudo macchanger -p $iname
				sudo ifconfig $iname up
				sudo service NetworkManager restart
				;;
			*) 	echo "Wrong Option! Try agian!!"
		esac
		;;

	4)	echo 
		iname=`iw dev | awk '$1=="Interface"{print $2}'`
		gnome-terminal -e "sudo netdiscover -i $iname"
		echo 
		;;

	e)	echo "See you again!"
		echo 
		break
		;;

	*)	echo "Sorry, I don't understand"
		echo 
		;;

  esac
done
echo 
echo "That's all folks!"


