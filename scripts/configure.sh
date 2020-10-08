#!/bin/bash
# Reverse Linux VNC by PANCHO7532
# This script is executed when GitHub actions is initialized.
# Prepares dependencies, ngrok, and vnc stuff

# First, install required packages
sudo apt update
sudo apt install -y xfce4 xfce4-goodies tightvncserver xfonts-base xubuntu-icon-theme xubuntu-wallpapers gnome-icon-theme x11-apps x11-common x11-session-utils x11-utils x11-xserver-utils x11-xkb-utils dbus-user-session dbus-x11 gnome-system-monitor gnome-control-center

# Second, download ngrok
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
chmod +x ngrok

# Third, generate and copy passwd file and xstartup script

mkdir $HOME/.vnc
cp ./resources/xstartup $HOME/.vnc/xstartup
echo $VNC_PASSWORD | vncpasswd -f > $HOME/.vnc/passwd
chmod 0600 $HOME/.vnc/passwd

# Fourth and last, set up auth token from argument
./ngrok authtoken $NGROK_AUTH_TOKEN
exit