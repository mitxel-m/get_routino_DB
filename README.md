# Script to get routing files for QMapShack-Routino

*(Leeme [en castellano](Leeme.md) )* 

This script downloads the necessary .pbf files from geofabrik, compiles them, and places the output files in your routino folder, ready to be used the next time you start QMS.

Of course, QMS already has a wizard to create the routing database, but first you have to download some files manually, and then go to QMS. It's easy, but if you have to do it frequently it's not fun. 

Since the process is always the same, the idea is to put it in an unattended script that only needs a double-click, and can also be called from a CLI, or even as a scheduled task.

The scripts provided here are intended to get a DB covering IBERIA (Portugal, Spain, Andorra, and South of France), and CANARIAS,  but they can be customized to any region of your convenience.


## How to use
#### Install
1. Place the scripts in a subfolder, inside  the folder you have configured in QMS for routino (eg. `/CARTO/ROUTINO/Scripts`).
2. (Only for linux) Make the scripts executable: `chmod +x get_routino_CANARIAS.sh && chmod +x get_routino_IBERIA.sh`    
#### Run
1. Double click on the script, and let it run.

Note that for a large region the process may take more than an hour or two, and at some point it may seem to freeze. Be patient, you won't have to do anything else than let it run, and you can go for a walk. An information message will be displayed when finished. 

## How to customize

There are some editable variables in the script. Follow the comments to adapt it to your needs. Basically you should modify a few things:

#### Output name

The output routing database will take a name like `MyRegion_202201*.mem`. You can set the name of the region by editing a variable in the script. The final numbers that indicate the year and month of creation will be added automatically by the script. So, once you have tested the new database, you can delete the previous versions.

#### Links to the .pbf files

Edit the list of links to the files that will be downloaded from Geofabrik.

- If you want to build a routing DB that just needs to download a single file from Geofabrik, you can take `get_routino_CANARIAS.*` as a template.
- If you want to build a routing DB for a cross-border region that needs to download and combine multiple files, it is a good idea to edit `get_routino_IBERIA.*`, which downloads and combines 6 files from different regions to complete IBERIA.

#### Threads
Optionally you can also set the number of threads to be used by planetsplitter when compiling. More threads reduces the compilation time but needs more memory.

## Download

|Comments|Linux|Windows
|---|---|---|
|English|[get_routinoDB_linux.zip](https://github.com/mitxel-m/get_routino_DB/releases/download/1.0/get_routinoDB_linux.zip)|[get_routinoDB_win.zip](https://github.com/mitxel-m/get_routino_DB/releases/download/1.0/get_routinoDB_win.zip)|
|Spanish|[crea_routinoDB_linux.zip](https://github.com/mitxel-m/get_routino_DB/releases/download/1.0/crea_routinoDB_linux.zip)|[crea_routinoDB_win.zip](https://github.com/mitxel-m/get_routino_DB/releases/download/1.0/crea_routinoDB_win.zip)|

## References
- [Routino](http://routino.org)
- [QMapShack](https://github.com/Maproom/qmapshack)
- [Geofabrik](http://download.geofabrik.de)
