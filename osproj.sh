#!/bin/sh

# Color specific variables
RED='\033[0;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
WHITE='\033[1;37m'

# Dependencies => figlet, htop, neofetch, speedtest-cli, net-tools
bash resdep.sh figlet
bash resdep.sh nmap
bash resdep.sh macchanger
bash resdep.sh aircrack-ng
bash resdep.sh netdiscover
bash resdep.sh links
bash resdep.sh youtube-dl
#bash resdep.sh mailutils
bash resdep.sh net-tools

# Clear screen
clear

# Banner
figlet "Hacker Script" -c

# echo $0
# Wish the user
printf "${WHITE}Hello ${YELLOW}"$LOGNAME
printf "!\n"

# Show Last read file
printf "${WHITE}Last opened: `stat -c '%x' ./osproj.sh`\n"
echo 

# Main while loop starts
while :
printf "${GREEN}--------------------------------------------\n"
printf "${WHITE}Select what you want to Do:\n"
printf "${GREEN} \n"
echo "1 - Show all Mac-addresses and Wifi Access points around me"
echo "2 - Change My mac-address"
echo "3 - Get info of all devices on my Network"
echo "4 - Get the all open ports and OS details"
echo "e - To run the downloading script"
echo "f - to quit"
printf "${GREEN}--------------------------------------------\n"
printf ">${YELLOW} " 
do
  read INPUT_STRING
  case $INPUT_STRING in

	1)	echo 
		echo "The output will be available in outputmacs.txt file"
		echo 
		gnome-terminal -e "bash -c 'bash getallMacIds.sh && bash turnoffMonitormode.sh && column -s, -t < outputmacs.txt-01.csv'"
		#printf "Total number of processes running currently: "
		#ps -aux | wc -l
		echo 
		;;

	2)	echo 
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
				;;
		esac
		;;

	3)	echo 
		iname=`iw dev | awk '$1=="Interface"{print $2}'`
		gnome-terminal -e "sudo netdiscover -i $iname"
		echo 
		;;

	4)	echo 
		echo "a) of Specific ip"
		echo "b) of devices on my Network"
		printf "Choose an option: "
		read opt
		echo 
		case $opt in
			a) 	printf "Enter an ip address: "
				read ip
				command="sudo nmap -sS $ip"
				printf "Enable fast scan?(y/n): "
				read fast_bool
				if [ "$fast_bool" = "y" ]
				then
					command="$command -F"
				fi
				printf "Enable OS Detection?(y/n): "
				read os_bool
				if [ "$os_bool" = "y" ]
				then
					command="$command -O"
				fi
				printf "Enable Verbose output?(y/n): "
				read v_bool
				if [ "$v_bool" = "y" ]
				then
					command="$command -v"
				fi
				$command
				;;
			
			b)	ip=`hostname -I | awk '{$1=$1;print}'`
				# Trim trailing white space
				#ip="$(echo -e "${ip}" | sed -e 's/[[:space:]]*$//')"
				command="sudo nmap -sS "
				echo "Choose type of network: "
				echo "1) /8"
				echo "2) /16"
				echo "3) /24"
				read type
				printf "Enable Fast scan?(y/n): "
				read fast_bool
				if [ "$fast_bool" = "y" ]
				then
					command="$command -F"
				fi
				printf "Enable OS Detection?(y/n): "
				read os_bool
				if [ "$os_bool" = "y" ]
				then
					command="$command -O"
				fi
				printf "Enable Verbose output?(y/n): "
				read v_bool
				if [ "$v_bool" = "y" ]
				then
					command="$command -v"
				fi
				case $type in
					1) 	command="$command $ip/8"
						$command
						;;

					2)	command="$command $ip/16"
						$command
						;;

					3)	command="$command $ip/24"
						$command
						;;
				esac
				;;

			*)  echo "Wrong Option! Try agian!!"
				;;
		esac
		;;

	e)	echo 
		gnome-terminal -- bash project.sh
		;;

	f)  echo "See you again!"
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


