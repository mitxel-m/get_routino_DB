:: Script to build a routino database
:: It downloads the necessary .pbf files from geofabrik,  
:: compiles, and deletes the temporary files
:: The list of links to the files to download
:: can be customised in this script
:: mitxel-m 2021-10-20
:: ============================================================================
@echo off
:: VARIABLES YOU CAN EDIT

:: DB prefix: Use a descriptive name of the region. ( Eg: CANARIAS)
:: The year and month number is added automatically.

SET region=IBERIA

:: number of simultaneous processes for planetsplitter (max. processor cores x 2)
:: more processes reduces compile time but needs more memory

SET nthreads=2

::  Qmapshack root folder, where the script will find planetsplitter.exe

SET root="C:\Program Files\QMapShack"

::  download links 
:: ( you can edit and put the link you need between echo and >>)

echo http://download.geofabrik.de/europe/andorra-latest.osm.pbf>>lista_%region%.txt
echo http://download.geofabrik.de/europe/spain-latest.osm.pbf>>lista_%region%.txt
echo http://download.geofabrik.de/europe/portugal-latest.osm.pbf>>lista_%region%.txt 
echo http://download.geofabrik.de/europe/france/aquitaine-latest.osm.pbf>>lista_%region%.txt
echo http://download.geofabrik.de/europe/france/midi-pyrenees-latest.osm.pbf>>lista_%region%.txt
echo http://download.geofabrik.de/europe/france/languedoc-roussillon-latest.osm.pbf>>lista_%region%.txt

:: ==========================================


::  SCRIPT START- No edit is necessary

@echo off
set lista=lista_%region%.txt  
if %date:~0,4% gtr 31 (SET name=%region%_%date:~0,4%%date:~5,2%) else (SET name=%region%_%date:~6,4%%date:~3,2%)
SET tempfolder=_temp_%name%
cd ..
if not exist %CD%\%tempfolder% mkdir %CD%\%tempfolder%
chdir %tempfolder%
move %~dp0\%lista% > nul


echo ================================================================================
echo/
echo You are going to create %name%.* database for routino and QMS.
echo/
echo The script will download all the stuff, compile, and clean temporary files.
echo It could take more than an hour, but if all works fine it will done in one go.
echo/
echo Let it run until you see   -  END  -"
echo ================================================================================
pause

:: DOWNLOAD 

FOR /F  %%I in (%lista%) do ( echo/ & echo DOWNLOAD: %%~nxI & %root%\curl %%I -o %%~nxI )

:: Build routino DB

set/pfirst=<%lista%
FOR %%A in (%first%) do ( %root%\planetsplitter --prefix=%name% --tagging=%root%\routino-xml\tagging.xml --sort-threads=%nthreads% --parse-only %%~nxA )

FOR /F "skip=1"  %%B in (%lista%) do ( %root%\planetsplitter --prefix=%name% --tagging=%root%\routino-xml\tagging.xml --sort-threads=%nthreads% --parse-only --append %%~nxB )

%root%\planetsplitter --prefix=%name% --tagging=%root%\routino-xml\tagging.xml --sort-threads=%nthreads% --process-only

:: Move and clean

chdir ..
move %tempfolder%\*.mem
rd /S /q %tempfolder%

:fin

@CHCP 65001
@echo ================================================================================
@echo/
@echo .                   .oO( THE END )Oo.
@echo/
@echo If everything has worked fine, the routing files are in
@echo %CD%
@echo There are 4 files named %name%*.mem
@echo The numbers are the year and month of creation.
@echo You can delete previous versions once you have tested this one
@echo =================================================================================
pause
:bye
exit
