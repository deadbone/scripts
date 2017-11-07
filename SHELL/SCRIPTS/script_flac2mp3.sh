#!/bin/sh

REP=$1

# This is needed to handle spaces in file names
OLDIFS=$IFS
IFS=$(echo -en "\n\b")

# Base directory where MP3 files will be created
# MP3 bitrate in bits
bitrate=320000

# Overwrite existing MP3 files (-y for yes, blank for no)
overwrite=-y

# Iterate on albums

cd $REP
    echo $PWD
          # Iterate ofn tracks
for i in *.flac
	do
		newname=`basename $i flac`mp3
               ffmpeg  $overwrite -i $i -ab $bitrate -acodec mp3 $newname >& /dev/null
               	echo "    "$newname
		chmod 666 $newname
	done
                             
IFS=$OLDIFS