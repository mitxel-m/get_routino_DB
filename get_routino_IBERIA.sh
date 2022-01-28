#!/bin/bash
# Script to build a routino database
# It downloads the necessary .pbf files from geofabrik,  
# compiles, and deletes the temporary files
# The list of links to the files to download
# can be customised in this script or use wget -i List.txt
# mitxel-m 2021-10-20
# ============================================================================

# VARIABLES YOU CAN EDIT

# DB prefix: Use a descriptive name of the region. ( Eg: CANARIAS)
# The year and month number is added automatically.

region="IBERIA"

# number of simultaneous processes for planetsplitter (max. processor cores x 2)
# more processes reduces compile time but needs more memory

nthreads=2

# files to download: go to # DOWNLOAD below to edit the list

# ============================================================================

# SCRIPT START

name=$region"_"$(date +%Y)$(date +%m)
tempfolder="_TEMP_"$name
if [ ! -d "$tempfolder" ]; then mkdir $tempfolder; fi
cd $tempfolder

# confirm start

echo
echo "You are going to create" $name "database for routino and QMS."
echo
echo "The script will download all the stuff, compile, and clean temporary files."
echo "It could take more than an hour, but if all works fine it will done in one go."
echo
echo "Let it run until you see   -  END  -"
echo ========================================================================
echo
read -n 1 -r -s -p "Press any key to go..."


# DOWNLOAD

wget http://download.geofabrik.de/europe/andorra-latest.osm.pbf
wget http://download.geofabrik.de/europe/spain-latest.osm.pbf
wget http://download.geofabrik.de/europe/portugal-latest.osm.pbf
wget http://download.geofabrik.de/europe/france/aquitaine-latest.osm.pbf
wget http://download.geofabrik.de/europe/france/midi-pyrenees-latest.osm.pbf
wget http://download.geofabrik.de/europe/france/languedoc-roussillon-latest.osm.pbf

# Build routino DB

planetsplitter --prefix=$name  --sort-threads=$nthreads --parse-only *.pbf
planetsplitter --prefix=$name  --sort-threads=$nthreads --process-only

# Move and clean

mv *.mem ../../
cd ../
rm -rf $tempfolder
cd ../

echo "==========================================================="
echo "                  .oO( THE END )Oo."
echo
echo "If everything has worked fine, the routing files are in"
echo
pwd
echo
echo "There are 4 files named" $name"*.mem"
echo "The numbers are the year and month of creation."
echo "You can delete previous versions once you have tested this one"
echo "==========================================================="

read -n 1 -r -s -p "Press any key to close..."

