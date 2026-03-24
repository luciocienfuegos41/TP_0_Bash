#!/bin/bash

ENTRADA="$1"
SALIDA="$2"
PROCESADO="$3"

OUTPUT="$SALIDA/$FILENAME.txt"

touch "$OUTPUT"

while true; do
    for file in "$ENTRADA"/*.txt; do
        [ -e "$file" ] || continue

        cat "$file" >> "$OUTPUT"
        mv "$file" "$PROCESADO"
    done

    sleep 5
done

