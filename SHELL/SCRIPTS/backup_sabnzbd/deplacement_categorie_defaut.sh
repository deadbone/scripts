#!/opt/bin/bash

#1 	The final directory of the job (full path)
#2 	The original name of the NZB file
#3 	Clean version of the job name (no path info and ".nzb" removed)
#4 	Indexer's report number (if supported)
#5 	User-defined category
#6 	Group that the NZB was posted in e.g. alt.binaries.x
#7 	Status of post processing. 0 = OK, 1=failed verification, 2=failed unpack, 3=1+21

#--------------------------------------------
# VARIABLES
#--------------------------------------------
. /volume1/download/SCRIPTS/setEnv.sh
source $REP_SCRIPT/TOOLS.sh

CATUNKNOW="*"
JOB_CAT="$5"
JOB_TITLE="$3"
JOB_RESULT="$7"
JOB_REP="$1"

#--------------------------------------------
# DEBUT DU PROGRAMME
#--------------------------------------------
	DATE=`donnerDate "heure"`
 	
  #Si le resultat du job est en erreur, on sort, rien à faire donc
  if [ "$JOB_RESULT" -ne 0 ] 
  then
  	echo "test job en erreur"
		exit
	fi
        
	#Si categorie differente de unknow, on sort car sabnzbd gere le deplacement.
	if [ "$JOB_CAT" != "$CATUNKNOW" ]
	then
		  	echo "testcat connue"
		  	exit 0
	fi
	
	NB_MP3=`compterElement "$JOB_REP" "*.mp3"`
	NB_FLAC=`compterElement "$JOB_REP" "*.flac"`
	
	NB_ZIK=0
		
	let "NB_ZIK=$NB_MP3+$NB_FLAC"
	
	if [ $NB_ZIK -ne 0  ]
		then
		#MP3 donc on va deplacer
		mv "$JOB_REP" "$REP_MP3"
	
		#synoindex -a "$REP_MP3/$JOB_REP" -t music
		#echo "$JOB_TITLE = MP3"
		envoyerNotification $PUSHTOKEN_SABNZBD "$JOB_TITLE -> MP3" "$DATE"
		
		if [ $NB_FLAC -ne 0 ]
			then
			cd $REP_SCRIPT
			envoyerNotification $PUSHTOKEN_SABNZBD "$JOB_TITLE conversion Flac demandee" "$DATE" 
			./script_flac2mp3.sh "$REP_MP3/$JOB_TITLE"
		fi
		
		exit 0
	fi
	
	NB_AVI=`compterElement "$JOB_REP" "*.avi"`
	NB_MKV=`compterElement "$JOB_REP" "*.mkv"`
	NB_MP4=`compterElement "$JOB_REP" "*.mp4"`

	NB_FILM=0
	
	let "NB_FILM=$NB_AVI+$NB_MKV+$NB_MP4"
		
	if [ $NB_FILM -ne 0  ]
		then

		#video OK mais on teste si serie
		
		if [[ "$JOB_TITLE" =~ [sS]{1}[0-9]{2}[eE]{1}[0-9]{2} ]] 
			then
			mv "$JOB_REP" "$REP_TV"
			envoyerNotification $PUSHTOKEN_SABNZBD "$JOB_TITLE -> TV" "$DATE"

			exit 0	
		else
			#FILM donc on va deplacer
			mv "$JOB_REP" "$REP_FILMS"
			#synoindex -A "$REP_FILMS/$JOB_REP" -t video
			#echo "$JOB_TITLE = FILM"
			envoyerNotification $PUSHTOKEN_SABNZBD "$JOB_TITLE -> FILM" "$DATE"
			exit 0
		fi	
	fi
	
