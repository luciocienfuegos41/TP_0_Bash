#!/bin/bash
RUTA_BASE="$HOME/EPNro1"

ENTRADA="$RUTA_BASE/entrada"
SALIDA="$RUTA_BASE/salida"
PROCESADO="$RUTA_BASE/procesado"

OUTPUT="$SALIDA/$FILENAME.txt"

validar_archivo_salida() {
    if [ -z "$FILENAME" ]; then
        echo "❌ FILENAME no está definido"
        echo "Definilo antes de usar esta opción. Ejemplo: export FILENAME=consolidado"
        return 1
    fi

    if [ ! -d "$SALIDA" ]; then
        echo "❌ No existe el entorno. Elegí la opción 1 para crearlo."
        return 1
    fi

    if [ ! -e "$OUTPUT" ]; then
        echo "❌ No existe el archivo $FILENAME.txt. Elegí la opción 2 para crearlo."
        return 1
    fi

    if [ ! -s "$OUTPUT" ]; then
        echo "❌ El archivo $FILENAME.txt está vacío. Carga archivos en la carpeta $ENTRADA para visualizar los datos."
        return 1
    fi

    return 0
}

cargando() {
    for j in {1..3}; do
        for i in {1..3}; do
            printf "."
            sleep 0.06
        done
        sleep 0.08
        clear
    done

    clear
}

clear

if [ "$1" == "-d" ]; then
    cargando

    pkill -f consolidar.sh 2>/dev/null
    rm -rf "$RUTA_BASE"

    echo "✅ Entorno eliminado correctamente"
    exit 0
fi

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

            mkdir -p "$ENTRADA"
            mkdir -p "$SALIDA"
            mkdir -p "$PROCESADO"

            echo "✅ Entorno creado correctamente"
            echo "📁 Ruta: $RUTA_BASE"

            echo "📂 Carpetas dentro de $RUTA_BASE:"
            ls "$RUTA_BASE"
        ;;
        2)
            cargando

            if [ -z "$FILENAME" ] || [ ! -d "$ENTRADA" ] || [ ! -d "$SALIDA" ]; then
                echo "❌ FILENAME no está definido o no creaste el entorno (opción 1)"
            else
                sh consolidar.sh "$ENTRADA" "$SALIDA" "$PROCESADO" &
                echo "✅ Proceso de consolidación iniciado en background"
            fi
        ;;
        3)
            cargando
            if validar_archivo_salida; then
                echo "Alumnos ordenados por numero de padron: "
                sort -n "$OUTPUT"
            fi
        ;;
        4)  
            cargando
            if validar_archivo_salida; then
                echo "Las 10 notas mas altas del listado son las siguientes: " 
                sort  -k5  -nr  "$OUTPUT" | head
            fi
        ;;
        5)  
            cargando
            read -p "Ingresa un numero de padron: " numero_de_padron
            
            if validar_archivo_salida; then
                datos=$(grep "^$numero_de_padron " "$OUTPUT")
    
                if [ -z "$datos" ]; then
                    echo "❌ No se encontró alumno con ese número de padrón"
                else
                    echo "Los datos del alumno son los siguientes: "
                    echo "$datos"
                fi
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
