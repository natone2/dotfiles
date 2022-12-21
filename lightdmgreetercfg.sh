#!/bin/bash

# Make sure that lightdm is installed
if ! dpkg -s lightdm > /dev/null 2>&1; then
  echo -e "\e[31mlightdm is not installed. Installing lightdm...\e[0m"
  apt-get update
  apt-get install lightdm
else
  echo -e "\e[32mlightdm is installed.\e[0m"
fi

# Make sure that lightdm is enabled and running
systemctl enable lightdm
systemctl start lightdm
echo -e "\e[32mlightdm is enabled and running.\e[0m"

# Make sure that makepkg is installed
if ! dpkg -s makepkg > /dev/null 2>&1; then
  echo -e "\e[31mmakepkg is not installed. Installing makepkg...\e[0m"
  apt-get install makepkg
else
  echo -e "\e[32mmakepkg is installed.\e[0m"
fi

# Make sure that git is installed
if ! dpkg -s git > /dev/null 2>&1; then
  echo -e "\e[31mgit is not installed. Installing git...\e[0m"
  apt-get install git
else
  echo -e "\e[32mgit is installed.\e[0m"
fi

# Clone the lightdm-webkit2-theme-glorious repository and build the theme using makepkg
git clone https://aur.archlinux.org/lightdm-webkit2-theme-glorious.git
cd lightdm-webkit2-theme-glorious
makepkg -sri

# Or download and extract the latest stable release of the theme
# and copy it to the lightdm-webkit theme folder
wget https://github.com/zagortenay333/lightdm-webkit2-theme-glorious/releases/download/v1.3.1/lightdm-webkit2-theme-glorious-1.3.1.tar.gz
tar -xvzf lightdm-webkit2-theme-glorious-1.3.1.tar.gz
cp -r lightdm-webkit2-theme-glorious /usr/share/lightdm-webkit/themes/glorious

# Set default lightdm greeter to lightdm-webkit2-greeter
sed -i 's/^\(#?
