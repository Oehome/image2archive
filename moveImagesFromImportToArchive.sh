#!/bin/sh

while true; do
	echo "delete mov files"
	find /import -name "*.mov" -type f -exec rm -rf {} \;
	echo "rename files"
	exiftool '-FileName<${DateTimeOriginal}%-c.%le' -d '%Y%m%d-%H%M%S' -r '/import'
	echo "set time and date of files"
	exiftool '-FileModifyDate<${DateTimeOriginal}' -r '/import'
	echo "move files"
	exiftool '-Directory<${DateTimeOriginal}' -d '/export/%Y/%m/%d' -r '/import'
	echo "next run in 5 minutes"
	sleep 300
done
