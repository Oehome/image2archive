#!/bin/sh
echo "delete mov files"
find /import -name "*.mov" -type f -exec rm -rf {} \;
echo "rename files"
exiftool '-FileName<${DateTimeOriginal}%-c.%le' -d '%Y%m%d-%H%M%S' -r '/import'
echo "set time and date of files"
exiftool '-FileModifyDate<${DateTimeOriginal}' -r '/Multimedia/FotoArchiv/import'
echo "move files"
exiftool '-Directory<${DateTimeOriginal}' -d '/export/%Y/%m/%d' -r '/import'
