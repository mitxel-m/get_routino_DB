# Script para crear ficheros de enrutamiento para Qmapshack-Routino

*(Go to [english ReadMe](README.md) )* 

Este script descarga los archivos .pbf necesarios de Geofabrik, los compila y coloca los archivos de salida en tu carpeta de routino, de forma que estarán listos para usar la próxima vez que inicies QMS.

Por supuesto, QMS ya tiene un asistente para crear la base de datos, pero primero hay que descargar los archivos manualmente, y luego ir a QMS. Es fácil, pero si tienes que hacerlo con frecuencia es aburrido. 

Como el proceso es siempre el mismo, la idea es ponerlo en un script desatendido que sólo necesite un doble clic, y que también pueda ser llamado desde una linea de comandos, o incluso como una tarea programada.

Los scripts compartidos aquí están pensados para crear una base de datos que cubra IBERIA (Portugal, España, Andorra y el sur de Francia), y CANARIAS, porque es lo que más uso, pero se pueden personalizar para cualquier región que te interese.


## Cómo se usa

1. Pon los scripts en una subcarpeta, dentro de la carpeta que tienes configurada en QMS para routino (ej: `/CARTO/ROUTINO/Scripts`). Esto lo harás una sola vez.

2. Haz doble clic en el script y dejalo correr.

 
Ten en cuenta que para una región grande el proceso puede tardar más de una hora o dos, y en algún momento puede parecer que se congela. Ten paciencia, no tendrás que hacer nada más que dejarlo correr, y mientras tu tambien puedes aprovechar para correr un rato o dar un paseo. Cuando el proceso termine aparecerá un mensaje de aviso. 


## Cómo se personaliza

Al inicio del script hay unas variables editables que puedes modificar con un editor de texto. Básicamente se trata de cambiar  dos o tres cosas:

#### Nombre

Los archivos de enrutamiento resultantes tienen un nombre como `IBERIA_202201*.mem`. El nombre de la región lo eliges tú, editando una variable en el script, y los numeros que indican el año y el mes de creación se añaden automáticamente.  Así, una vez que hayas probado la nueva base de datos, puedes borrar las versiones anteriores.

#### Enlaces a los archivos .pbf

Edita la lista de enlaces a los archivos que se necesitan descargar de Geofabrik.

- Si quieres crear una BD de enrutamineto que sólo necesite descargar un único archivo de Geofabrik, puedes usar como plantilla `crea_routino_CANARIAS.*`
- Si quieres crear una BD de enrutamiento para una región transfronteriza que necesita descargar y combinar múltiples archivos, es una buena idea editar `crea_routino_IBERIA.*` . En ese ejemplo se descargan y combinan 6 ficheros de diferentes regiones para completar IBERIA.

#### Procesos
Opcionalmente se puede establecer el número de procesos simultaneos (threads) a utilizar por planetsplitter al compilar. Un mayor número de threads reduce el tiempo de compilación pero necesita más memoria.

## Descargar

|Comentarios|Linux|Windows|
|---|---|---|
|English|[get_routinoDB_linux.zip](https://github.com/mitxel-m/get_routino_DB/releases/download/1.0/get_routinoDB_linux.zip)|[get_routinoDB_win.zip](https://github.com/mitxel-m/get_routino_DB/releases/download/1.0/get_routinoDB_win.zip)|
|Castellano|[crea_routinoDB_linux.zip](https://github.com/mitxel-m/get_routino_DB/releases/download/1.0/crea_routinoDB_linux.zip)|[crea_routinoDB_win.zip](https://github.com/mitxel-m/get_routino_DB/releases/download/1.0/crea_routinoDB_win.zip)|

## Referencias
- [Routino](http://routino.org)
- [QMapShack](https://github.com/Maproom/qmapshack)
- [Geofabrik](http://download.geofabrik.de)

