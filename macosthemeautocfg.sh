#!/bin/bash

# Comprobamos si Git está instalado
if [ -x "$(command -v git)" ]; then
  echo "Git ya está instalado"
else
  # Instalamos Git
  sudo apt update
  sudo apt install git
  echo "Git instalado"
fi

# Comprobamos si ya está instalado WhiteSur GTK Theme
if [ -d /usr/share/themes/WhiteSur ]; then
  echo "WhiteSur GTK Theme ya está instalado"
else
  # Instalamos WhiteSur GTK Theme desde GitHub
  git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
  cp -r WhiteSur-gtk-theme/WhiteSur /usr/share/themes/
fi

# Comprobamos si ya está instalado WhiteSur GTK Icons
if [ -d /usr/share/icons/WhiteSur ]; then
  echo "WhiteSur GTK Icons ya está instalado"
else
  # Instalamos WhiteSur GTK Icons desde GitHub
  git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
  cp -r WhiteSur-icon-theme/WhiteSur /usr/share/icons/
fi

# Comprobamos si ya está instalado WhiteSur GTK Cursors
if [ -d /usr/share/icons/WhiteSur-cursors ]; then
  echo "WhiteSur GTK Cursors ya está instalado"
else
  # Instalamos WhiteSur GTK Cursors desde GitHub
  git clone https://github.com/vinceliuice/WhiteSur-cursors.git
  cp -r WhiteSur-cursors/WhiteSur /usr/share/icons/
fi

# Comprobamos si ya está instalado Vala Panel AppMenu
if [ -d /usr/lib/vala-panel-appmenu ]; then
  echo "Vala Panel AppMenu ya está instalado"
else
  # Instalamos Vala Panel AppMenu desde GitHub
  git clone https://github.com/rilian-la-te/vala-panel-appmenu.git
  cd vala-panel-appmenu
  sudo make install
  cd ..
fi

# Comprobamos si ya está instalado LightDM Webkit2 Theme Glorious
if [ -d /usr/share/lightdm-webkit/themes/glorious ]; then
  echo "LightDM Webkit2 Theme Glorious ya está instalado"
else
  # Descargamos LightDM Webkit2 Theme Glorious
  wget https://github.com/manilarome/lightdm-webkit2-theme-glorious/archive/master.zip
  unzip master.zip
  cp -r lightdm-webkit2-theme-glorious-master/lightdm-webkit2-theme-glorious /usr/share/lightdm-webkit/themes/
  rm -rf lightdm-webkit2-theme-glorious-master
  rm master.zip
fi

# Configuramos LightDM Webkit2 Theme Glorious
sudo sed -i 's/^\(#?greeter\)-session\s*=\s*\(.*\)/greeter-session = lightdm-webkit2-greeter #\1/ #\2g' /etc/lightdm/
sudo sed -i 's/^\(#?greeter\)-session\s*=\s*\(.*\)/greeter-session = lightdm-webkit2-greeter #\1/ #\2g' /etc/lightdm/lightdm.conf
sudo sed -i 's/^webkit_theme\s*=\s*\(.*\)/webkit_theme = glorious #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf
sudo sed -i 's/^debug_mode\s*=\s*\(.*\)/debug_mode = true #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf

# Comprobamos si ya está instalado Xpple Menu
if [ -d /usr/share/xpple-menu ]; then
  echo "Xpple Menu ya está instalado"
else
  # Descargamos Xpple Menu
  wget https://www.pling.com/p/1529470/ -O xpple-menu.deb
  # Instalamos Xpple Menu
  sudo dpkg -i xpple-menu.deb
  rm xpple-menu.deb
fi

# Comprobamos si ya está instalado Plank Menu
if [ -x "$(command -v rofi)" ]; then
  echo "Plank Menu ya está instalado"
else
  # Instalamos Plank Menu
  sudo apt install rofi
fi

# Configuramos Plank Menu
cp configuracion_plank.conf ~/.config/plank/dock1/settings

# Comprobamos si ya está instalado LightDM Webkit2 Greeter
if [ -x "$(command -v lightdm-webkit2-greeter)" ]; then
  echo "LightDM Webkit2 Greeter ya está instalado"
else
  # Instalamos LightDM Webkit2 Greeter
  sudo apt install lightdm-webkit2-greeter
fi

# Comprobamos si ya está instalado Comice Control Center V2
if [ -d /usr/share/comice-control-center-v2 ]; then
  echo "Comice Control Center V2 ya está instalado"
else
  # Instalamos Comice Control Center V2 desde GitHub
  git clone https://github.com/natone2/comice-control-center-v2.git
  cd comice-control-center-v2
  chmod +x comice-control-center
  ./comice-control-center
  cd ..
fi
