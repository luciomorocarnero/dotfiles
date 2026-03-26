#!/bin/bash

# 1. Seleccionar Destino
dest_options="󰅍  Solo Portapapeles\n󰅌  Guardar Archivo (+ Clip)"
dest_choice=$(echo -e "$dest_options" | rofi -dmenu -i -p "Destino:" -config ~/.config/rofi/config.rasi)

# Definir bandera de Hyprshot según la elección
if [[ "$dest_choice" == *"Solo Portapapeles"* ]]; then
    CLIP_FLAG="--clipboard-only"
else
    CLIP_FLAG=""
fi

# Si se cancela el primer menú, salir
[ -z "$dest_choice" ] && exit 0

# 2. Seleccionar Modo de Captura
mode_options="󰹑  Pantalla Completa\n󱂬  Ventana Activa\n󰒅  Región Seleccionada"
mode_choice=$(echo -e "$mode_options" | rofi -dmenu -i -p "Modo:" -config ~/.config/rofi/config.rasi)

# Ejecutar según la elección y la bandera previa
case "$mode_choice" in
    *Pantalla*)
        hyprshot -m output $CLIP_FLAG
        ;;
    *Ventana*)
        hyprshot -m window $CLIP_FLAG
        ;;
    *Región*)
        hyprshot -m region $CLIP_FLAG
        ;;
esac
