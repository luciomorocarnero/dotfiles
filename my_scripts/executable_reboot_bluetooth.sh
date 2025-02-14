#!/bin/bash

# Función para manejar errores
function check_error {
  if [ $? -ne 0 ]; then
    echo "Error en el paso: $1. El script se detiene."
    exit 1
  fi
}

# Desbloquear Bluetooth si está bloqueado
echo "Desbloqueando Bluetooth..."
sudo rfkill unblock bluetooth
check_error "Desbloquear Bluetooth"

# Detener el servicio Bluetooth
echo "Deteniendo el servicio Bluetooth..."
sudo systemctl stop bluetooth
check_error "Detener el servicio Bluetooth"

# Mostrar el estado actual del servicio Bluetooth
echo "Mostrando el estado actual del servicio Bluetooth..."
sudo systemctl status bluetooth
check_error "Mostrar el estado del servicio Bluetooth"

# Reiniciar el servicio Bluetooth
echo "Reiniciando el servicio Bluetooth..."
sudo systemctl restart bluetooth
check_error "Reiniciar el servicio Bluetooth"

# Verificar si el servicio se reinició correctamente
echo "Verificando el estado del servicio Bluetooth después de reiniciar..."
sudo systemctl status bluetooth
check_error "Verificar el estado después de reiniciar"

echo "El script ha finalizado exitosamente."
