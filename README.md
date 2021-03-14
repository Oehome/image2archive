# image2archive

simple service to move images to a destination directory (YYYY/MM/DD) based on their exif data.

A Python script is tigered via mqtt and starts a simple shell script that executes the command via the exiftool

The whole thing is running here in a container on a QNAP