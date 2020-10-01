#!/bin/bash
# Reverse Linux VNC by PANCHO7532
# This script is executed when GitHub actions is initialized.
# Prepares dependencies, ngrok, and vnc stuff
# $1 - NGROK AUTH TOKEN
# $2 - VNC PASSWORD
# $3 - HOME DIRECTORY

echo $(env)

# First, install required packages
sudo apt update
sudo apt install -y xfce4 xfce4-goodies tightvncserver xfonts-base xubuntu-icon-theme xubuntu-wallpapers gnome-icon-theme x11-apps x11-common x11-session-utils x11-utils x11-xserver-utils x11-xkb-utils dbus-user-session dbus-x11 gnome-system-monitor gnome-control-center

# Second, download ngrok
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
chmod +x ngrok

# Third, generate and copy passwd file and xstartup script
# Alright, script is executing on: (example, ignore if your repo name isn't the same)
# /home/runner/work/reverse-linux-vnc/reverse-linux-vnc/scripts/configure.sh
# but, in the yaml i specified the execution so it can stay on the main directory
# /home/runner/work/reverse-linux-vnc/reverse-linux-vnc
# Home is /home/runner

mkdir $3/.vnc
cp ./resources/xstartup $3/.vnc
echo -e "$2" > data.dat
vncpasswd -f < data.dat > output.dat
cp ./output.dat $3/.vnc/passwd
rm data.dat
cat $3/.vnc/passwd

# Alright, pre generated passwd file until i figure what the actual goddamn fuck is wrong with the passwd generation on this shit
# When login into the machine, especify: "runner" as username (if it's required) and "password" as the VNC password, and you should be good to go.

# wget http://boompancho.p7com.net/vnc-resources.zip
# unzip vnc-resources.zip
# mkdir $3/.vnc
# cp passwd $3/.vnc
# cp xstartup $3/.vnc

# Fourth and last, set up auth token from argument
./ngrok authtoken $1
exit