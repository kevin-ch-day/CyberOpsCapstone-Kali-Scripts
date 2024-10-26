#!/bin/bash
# Android Malware Lab Setup
# Last updated: 08/09/2022

apt update -y
apt upgrade -y
apt install git -y
git config --global user.email "kevin.ch.day@gmail.com"
git config --global user.name "Kevin Day"

#apt install kali-grant-root -y
#dpkg-reconfigure kali-grant-root -y

apt install apktool -y

# For Ubutunu
apt install openjdk-7-jre -y
apt install openjdk-17-jre -y

apt install dex2jar -y


apt install jd-gui -y
apt install p7zip-full p7zip-rar -y
apt install python3-pip -y
apt install python3-venv -y
#apt install virtualbox virtualbox-ext-pack -y

pip3 install mysql-connector-python
apt install python3 -y
apt install python3-pip -y
apt install python3.10-venv -y

#git clone https://github.com/MobSF/Mobile-Security-Framework-MobSF.git
#cd /Mobile-Security-Framework-MobSF
# ./setup.sh # Install Mobsf
# ./run.sh # Run Mobsf

