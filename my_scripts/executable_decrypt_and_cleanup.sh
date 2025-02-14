#!/bin/bash

# Verificar que se haya proporcionado un archivo .gpg como argumento
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 archivo_cifrado.gpg"
    exit 1
fi

ARCHIVO_CIFRADO="$1"

# Verificar si el archivo tiene extensión .gpg
if [[ "$ARCHIVO_CIFRADO" != *.gpg ]]; then
    echo "Error: El archivo debe tener extensión .gpg"
    exit 1
fi

# Descifrar el archivo
ARCHIVO_DESCIFRADO="${ARCHIVO_CIFRADO%.gpg}"
gpg --output "$ARCHIVO_DESCIFRADO" --decrypt "$ARCHIVO_CIFRADO"

if [ $? -ne 0 ]; then
    echo "Error al descifrar el archivo."
    exit 1
fi

# Verificar si el archivo descifrado es un ZIP válido
if unzip -tq "$ARCHIVO_DESCIFRADO" &>/dev/null; then
    # Descomprimir el ZIP
    unzip -q "$ARCHIVO_DESCIFRADO"
    
    if [ $? -eq 0 ]; then
        # Eliminar el archivo ZIP descifrado y el archivo .gpg
        rm "$ARCHIVO_DESCIFRADO"
        rm -f "$ARCHIVO_CIFRADO"
        echo "Directorio desencriptado y extraído."
    else
        echo "Error al descomprimir el archivo ZIP."
        exit 1
    fi
else
    # Si no es un ZIP, eliminar el archivo .gpg después de descifrar
    rm -f "$ARCHIVO_CIFRADO"
    echo "Archivo desencriptado: $ARCHIVO_DESCIFRADO"
fi

# Reiniciar gpg-agent
gpgconf --kill gpg-agent
echo "gpg-agent reiniciado."
