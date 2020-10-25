#!/bin/sh
echo "lösche alle mov dateien"
find /import -name "*.mov" -type f -exec rm -rf {} \;
echo "umbenennen der Dateien"
exiftool '-FileName<${DateTimeOriginal}%-c.%le' -d '%Y%m%d-%H%M%S' -r '/import'
echo "setzten des Dateialters"
exiftool '-FileModifyDate<${DateTimeOriginal}' -r '/Multimedia/FotoArchiv/import'
echo "verschieben in Archiv"
exiftool '-Directory<${DateTimeOriginal}' -d '/export/%Y/%m/%d' -r '/import'
