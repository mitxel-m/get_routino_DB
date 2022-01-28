::  Este script genera una base de datos para routino y QMS
::  el script descarga los archivos .pbf necesarios desde geofabrik a una carpeta temporal
::  la lista de links a los archivos a descargar se puede personalizar
::  mitxel-m 2021-10-20
::  ================================================================
@echo off


::  VARIABLES QUE PUEDES EDITAR:

::  Prefijo de la Base de datos. (Solo el nombre . La cifra del año y mes se añadirá automaticamente) ( Ej: CANARIAS)

SET region=CANARIAS

::  numero de procesos simultaneos al compilar (Maximo = procesadores x 2 ) 
::  mas procesos reduce el tiempo pero  necesita mas memoria, y si te pasas peta. 

SET nthreads=2

::  Directorio raiz de Qmapshack donde se encuentra el ejecutable planetsplitter.exe

SET root="C:\Program Files\QMapShack"

::  links de descarga de geofabrik 
:: ( puedes editar y poner los links que necesites entre echo y >>)

echo http://download.geofabrik.de/africa/canary-islands-latest.osm.pbf>>lista_%region%.txt

:: ================================================================


::  INICIO DEL SCRIPT- No es necesario editar a partir de aqui

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
echo Se van a crear los ficheros de enrutamiento %name%.* para routino y QMS 
echo/
echo El script descarga lo necesario, compila los ficheros, y borra los temporales.   
echo Puede tardar mas de una hora, pero si todo va bien lo hara del tiron.
echo/
echo Dejalo correr hasta que salga  -  FIN  -
echo ================================================================================
pause

:: Descarga 

FOR /F  %%I in (%lista%) do ( echo/ & echo DOWNLOAD: %%~nxI & %root%\curl %%I -o %%~nxI )

:: Moviendo archivos y haciendo limpieza

set/pfirst=<%lista%
FOR %%A in (%first%) do ( %root%\planetsplitter --prefix=%name% --tagging=%root%\routino-xml\tagging.xml --sort-threads=%nthreads% --parse-only %%~nxA )

FOR /F "skip=1"  %%B in (%lista%) do ( %root%\planetsplitter --prefix=%name% --tagging=%root%\routino-xml\tagging.xml --sort-threads=%nthreads% --parse-only --append %%~nxB )

%root%\planetsplitter --prefix=%name% --tagging=%root%\routino-xml\tagging.xml --sort-threads=%nthreads% --process-only

:: Moviendo archivos y haciendo limpieza

chdir ..
move %tempfolder%\*.mem
rd /S /q %tempfolder%

:fin

@CHCP 65001
@echo ================================================================================
@echo/
@echo .             .oO(  FIN  )Oo.
@echo/
@echo Si todo ha ido bien los ficheros de enrutamiento estan en
@echo %CD%
@echo Son 4 archivos de nombre %name%*.mem
@echo Los numeros indican el año y mes de creacion
@echo Despues de probarlo ya puedes borrar versiones anteriores 
@echo =================================================================================
pause
:bye
exit
