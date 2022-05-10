#!/bin/bash

# He creado este scrip para poder desinstalar anonym8 rápido

echo -e "El script está desinstalando anonym8...\n"
sleep 1
rm -rf /opt/anonym8
rm -rf /usr/share/applications/anonym8.desktop
rm -rf /etc/init.d/anonym8.sh
rm -rf /usr/bin/anonym8
rm -rf /usr/bin/anON
rm -rf /usr/bin/anOFF
apt-get remove tor macchanger resolvconf dnsmasq polipo privoxy tor-arm libnotify-bin curl bleachbit
rm -rf /etc/polipo/config
rm -rf /etc/privoxy/config
rm -rf /etc/tor/torrc
echo -e "\nDesinstalado anonym8 y todas sus dependencias"
