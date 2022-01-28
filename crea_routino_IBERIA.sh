#!/bin/bash
# Script para generar una base de datos para routino
# el script descarga los archivos .pbf necesarios desde geofabrik
# compila y borra los temporales
# La lista de links a los archivos a descargar
# se puede personalizar en este script o usar wget -i Lista.txt
# mitxel-m 2021-10-20
# ============================================================================

# VARIABLES QUE PUEDES EDITAR

# Prefijo de la BD: Usa un nombre descriptivo de la region. ( Ej: CANARIAS)
# La cifra del año y mes se añade automaticamente

region="IBERIA"

# numero de procesos simultaneos al compilar (max. nucleos de procesador x 2)
# mas procesos reduce el tiempo al compilar pero necesita mas memoria

nthreads=2

# Archivos a descargar: La lista se puede editar mas abajo ( ver # DESCARGA )

# ============================================================================

# INICIO DEL SCRIPT

name=$region"_"$(date +%Y)$(date +%m)
tempfolder="_TEMP_"$name
if [ ! -d "$tempfolder" ]; then mkdir $tempfolder; fi
cd $tempfolder

# Confirmar inicio

echo
echo "Se van a crear los ficheros de enrutamiento" $name "para routino y QMS"
echo
echo "El script descarga lo necesario, compila, y borra los temporales."
echo "Puede tardar mas de una hora, pero si todo va bien lo hara del tiron."
echo
echo "Dejalo correr hasta que salga  -  FIN  -"
echo "========================================================================"
echo
read -n 1 -r -s -p "Pulsa cualquier tecla para continuar..."


# DESCARGA

wget http://download.geofabrik.de/europe/andorra-latest.osm.pbf
wget http://download.geofabrik.de/europe/spain-latest.osm.pbf
wget http://download.geofabrik.de/europe/portugal-latest.osm.pbf
wget http://download.geofabrik.de/europe/france/aquitaine-latest.osm.pbf
wget http://download.geofabrik.de/europe/france/midi-pyrenees-latest.osm.pbf
wget http://download.geofabrik.de/europe/france/languedoc-roussillon-latest.osm.pbf

# Genera BD routino

planetsplitter --prefix=$name  --sort-threads=$nthreads --parse-only *.pbf
planetsplitter --prefix=$name  --sort-threads=$nthreads --process-only

# mover y limpiar

mv *.mem ../../
cd ../
rm -rf $tempfolder
cd ../

echo "==========================================================="
echo "                  .oO(  FIN  )Oo."
echo
echo "Si todo ha ido bien los ficheros de enrutamiento estan en"
echo
pwd
echo
echo "Son 4 archivos de nombre" $name"*.mem"
echo "Los numeros indican el año y mes de creacion"
echo "Despues de probarlo ya puedes borrar versiones anteriores"
echo "==========================================================="

read -n 1 -r -s -p "Pulsa cualquier tecla para cerrar..."

