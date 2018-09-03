#!/bin/bash

dpkg -s $1 &> /dev/null

if [ $? -eq 0 ]; then
	echo "Package  is installed!"
else
	echo "Package  is NOT installed!"
	sudo apt-get install $1 -y
fi
