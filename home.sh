#!/bin/bash
RUTA_BASE="EPNro1"
OUTPUT="$RUTA_BASE/salida/$FILENAME.txt"


cargando() {
    for j in {1..3}; do
        for i in {1..3}; do
            printf "."
            sleep 0.08
        done
        sleep 0.1
        clear
    done

    clear
}

clear

opcion=0

while [ $opcion -ne 6 ]; do
    echo "====== MENÚ ======"
    echo "1) Crear entorno"
    echo "2) Correr proceso"
    echo "3) Listar alumnos ordenados"
    echo "4) Top 10 notas"
    echo "5) Buscar por padrón"
    echo "6) Salir"
    echo "=================="

    read -p "Elegí una opción: " opcion

    clear

    case $opcion in
        1)
            cargando
            BASE="EPNro1"

            mkdir -p "$BASE/entrada"
            mkdir -p "$BASE/salida"
            mkdir -p "$BASE/procesado"

            echo "✅ Entorno creado correctamente"
            echo "📁 Ruta: $(pwd)/$BASE"

            echo "📂 Carpetas dentro de $BASE:"
            ls "$BASE"
        ;;
        2)
            cargando
            sh consolidar.sh
        ;;
        3)
            if [ -e $OUTPUT ];then
                echo "Alumnos ordenados por su padron"
                sort -n "$OUTPUT"
            else
                echo "❌ No existe el archivo $FILENAME. Elegir la opcion 1 y luego la opcion 2 para crearlo."
            fi
        ;;
        4)
            if [ -e $OUTPUT ];then
                echo "Si existe"
            else
                echo "❌ No existe el archivo $FILENAME"
            fi
        ;;
        5)
            if [ -e $OUTPUT ];then
                echo "Si existe"
            else
                echo "❌ No existe el archivo $FILENAME"
            fi
        ;;
        6)
            echo "Sesion finalizada"
        ;;
        *)
            echo "❌ Opción inválida"
        ;;
    esac

    echo ""
done

