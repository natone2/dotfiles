#!/bin/bash

# Habilitar el servicio lightdm
systemctl enable lightdm

# Instalar el tema Glorious
git clone https://aur.archlinux.org/lightdm-webkit2-theme-glorious.git
cd lightdm-webkit2-theme-glorious
makepkg -sri

# Configurar lightdm para usar el greeter webkit2
sed -i 's/^\(#?greeter\)-session\s*=\s*\(.*\)/greeter-session = lightdm-webkit2-greeter #\1/ #\2g' /etc/lightdm/lightdm.conf

# Configurar el tema Glorious como el tema predeterminado de lightdm-webkit2 y habilitar el modo de depuración
sed -i 's/^webkit_theme\s*=\s*\(.*\)/webkit_theme = glorious #\1/g' /etc/lightdm/lightdm-webkit2-greeter.conf
sed -i 's/^debug_mode\s*=\s*\(.*\)/debug_mode = true #\1/g' /etc/lightdm/lightdm-webkit2-gree

# Reiniciar lightdm para aplicar los cambios
systemctl restart lightdm
