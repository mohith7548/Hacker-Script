
#!/bin/bash
figlet "Welcome to Video Downloader"
echo "please choose the following 1. For Videos(Youtube) 2. For files"
read choice
if [ $choice -eq 1 ]
then
   gnome-terminal -- links www.youtube.com
fi
echo "Please Enter the userid/Category to login"
read usid
echo $usid
echo "Paste the URL Here:(CTRL+SHIFT+V)"
read urL
echo $urL
cd $usid
if [ $choice -eq 1 ]
then
   youtube-dl $urL
else
   wget $urL
fi



