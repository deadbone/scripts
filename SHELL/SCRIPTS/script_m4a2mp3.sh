#!/bin/sh

REP=$1

# This is needed to handle spaces in file names
OLDIFS=$IFS
IFS=$(echo -en "\n\b")




# Base directory where MP3 files will be created
#newbasedir=/volume1/music/MP3new

# MP3 bitrate in bits
bitrate=320000

# Overwrite existing MP3 files (-y for yes, blank for no)
overwrite=-y

# Iterate on albums
#for j in *
#do
#  cd $j
cd $REP
    echo $PWD
 #     newdir=$newbasedir/`basename $PWD`
 #       mkdir -p $newdir
          # Iterate ofn tracks
for i in *.m4a
	do
		newname=`basename $i m4a`mp3
               ffmpeg  $overwrite -i $i -ab $bitrate -acodec mp3 $newname >& /dev/null
               #ffmpeg  $overwrite -i $i -ab $bitrate -acodec mp3 $newname	
               	echo "    "$newname
		chmod 666 $newname
	done
# cd ..
# done
                              
IFS=$OLDIFS
                              
                              
