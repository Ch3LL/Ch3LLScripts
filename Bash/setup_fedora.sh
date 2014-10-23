#!/bin/bash

#This is a really rough script of all hte programs and setup for a fedora machcine that i use. Like i said super rough 


#Add user to wheel group
read -p "What user do you want to add to the wheel group" USER
usermod -aG wheel $USER

#
#Install qemu virtualization software for virtualizing windows8
yum -y install qemu-kvm qemu-img

#Create a qemu-img
read -p "What directory do you want to save your .img in" DIRECTORY
cd $DIRECTORY

#I want to add more here. so it auto populates another script that will runt he vm with bridged networking.
read -p "What do you want to name your .img" NAME
read -p "How big do you want your image. (GB)" GB
read -p "How much ram do you want to give your VM" RAM
read -p "Where is your ISO located? Please specify entire path" ISO

qemu-img create $NAME.img $GB
qemu-kvm -m $RAM -hda $NAME.img -cdrom $ISO

#Install Virtuo drivers on qemu vm.
echo "In order to install the virtio drivers go to http://alt.fedoraproject.org/pub/alt/virtio-win/latest/images/ . Download appropriate driver. On the qemu machine go to compat_monitor0 (under view). Type 'info block'. Type 'change idel-cd0 /tmnp/virtio.iso"

#Install VNC viewer client
yum install tigervnc #I think. need ot test and run this

#Add the rpmfusion repo
su -c 'yum localinstall --nogpgcheck http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'

#Add Adobe repo/Install Flash
sudo yum install http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm -y 

sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux 

sudo yum install flash-plugin -y

#Install IM client
yum install pidgin -y

#Install plugin for lync
yum install pidgin-sipe -y

#Awesome gnome tool for tweaking various settings
 yum install gnome-tweak-tool -y

#install nvidia drivers
yum install kmod-nvidia -y

#install steam nad install 32bit nvidia driver for steam games
yum install xorg-x11-drv-nvidia-libs-331.49-1.fc20.i686  -y

#Setup mysql workbench
yum localinstall mysql-community-release-fc20-5.noarch -y
yum install mysql-workbench-community.x86_64 -y
