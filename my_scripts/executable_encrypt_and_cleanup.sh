#!/bin/bash

# Verificar que se haya proporcionado un archivo o directorio como argumento
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 archivo_o_directorio_a_cifrar"
    exit 1
fi

OBJETO="$1"

# Verificar si es un archivo
if [ -f "$OBJETO" ]; then
    ARCHIVO="$OBJETO"
    
    # Cifrar el archivo
    gpg -c "$ARCHIVO"

    # Verificar si el cifrado fue exitoso
    if [ $? -eq 0 ]; then
        # Eliminar el archivo original
        rm "$ARCHIVO"
        echo "Archivo cifrado y original eliminado."

    else
        echo "Error al cifrar el archivo."
        exit 1
    fi

# Verificar si es un directorio
elif [ -d "$OBJETO" ]; then
    DIRECTORIO="$OBJETO"

    # Crear un archivo comprimido en formato .zip del directorio
    ZIP_ARCHIVO="${DIRECTORIO%/}.zip"
    zip -r "$ZIP_ARCHIVO" "$DIRECTORIO"

    # Cifrar el archivo comprimido
    gpg -c "$ZIP_ARCHIVO"

    # Verificar si el cifrado fue exitoso
    if [ $? -eq 0 ]; then
        # Eliminar el archivo comprimido original
        rm "$ZIP_ARCHIVO"
        rm -rf "$DIRECTORIO"
        echo "Directorio cifrado y original eliminado."

    else
        echo "Error al cifrar el directorio."
        exit 1
    fi

else
    echo "El argumento proporcionado no es ni un archivo ni un directorio válido."
    exit 1
fi

# Reiniciar gpg-agent
gpgconf --kill gpg-agent
echo "gpg-agent reiniciado."

