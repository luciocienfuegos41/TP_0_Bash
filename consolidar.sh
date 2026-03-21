#!/bin/bash

BASE="EPNro1"
ENTRADA="$BASE/entrada"
PROCESADO="$BASE/procesado"
SALIDA="$BASE/salida"

OUTPUT="$SALIDA/$FILENAME.txt"

if [ -z "$FILENAME" ]; then
    echo "❌ FILENAME no está definido"
    exit 1
fi

if [ ! -d "$ENTRADA" ] || [ ! -d "$SALIDA" ]; then
    echo "❌ No existe el entorno. Ejecutá opción 1 primero"
    exit 1
fi

touch "$OUTPUT"

for file in "$ENTRADA"/*.txt; do
    [ -e "$file" ] || continue

    echo "Procesando $file..."
    cat "$file" >> "$OUTPUT"
    mv $file $PROCESADO
done

echo "✅ Consolidación terminada en $OUTPUT"