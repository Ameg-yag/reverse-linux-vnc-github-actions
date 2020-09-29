#!/bin/bash
# Reverse Linux VNC by PANCHO7532
# This script is executed when GitHub actions is initialized.
# Prepares dependencies, ngrok, and vnc stuff

echo $(env)

# First, install required packages
sudo apt update
sudo apt install -y xfce4 xfce4-goodies tightvncserver xfonts-base xubuntu-icon-theme xubuntu-wallpapers gnome-icon-theme x11-apps x11-common x11-session-utils x11-utils x11-xserver-utils x11-xkb-utils dbus-user-session dbus-x11 gnome-system-monitor gnome-control-center

# Second, download ngrok
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
chmod +x ngrok
mv ngrok $3

# Third, generate and copy passwd file and xstartup script
mkdir $3/.vnc
cp ./resources/xstartup $3/.vnc
echo -e "$2\r\n$2" > data.dat
vncpasswd -f < ./data.dat > passwd
cp ./passwd $3/.vnc
chmod -R 0777 $3/.vnc
rm data.dat
ls -la
ls $3/.vnc

# Fourth and last, set up auth token from argument
cd $3
./ngrok authtoken $1
exit