#!/bin/bash

MIC=${MIC_ID:-@DEFAULT_AUDIO_SOURCE@}

# Obtenemos el estado del micorfono
STATE=$(wpctl get-volume "$MIC")

if [[ $STATE == *"MUTED"* ]]; then
    # Si está muteado, mandamos el ícono de tachado y una clase "muted"
    echo '{"text": "", "class": "muted", "tooltip": "Mic Interno: Silenciado"}'
else
    # Si está activo, ícono de mic y clase "active"
    echo '{"text": "", "class": "active", "tooltip": "Mic Interno: Activo"}'
fi
