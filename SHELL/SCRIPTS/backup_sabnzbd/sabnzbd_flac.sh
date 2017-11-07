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
 	
  #Si le resultat du job est en erreur, on sort, rien a faire donc
  if [ "$JOB_RESULT" -ne 0 ] 
  then
  	echo "$JOB_TITLE en erreur"
		exit 1
	fi
        
	NB_FLAC=`compterElement "$JOB_REP" "*.flac"`
	
	if [ $NB_FLAC -ne 0  ]
		then
		#MP3 donc on va deplacer
	#	mv "$JOB_REP" "$REP_MP3"
	

			cd $REP_SCRIPT
			envoyerNotification $PUSHTOKEN_SABNZBD "$JOB_TITLE conversion Flac demandee" "$DATE" 
			./script_flac2mp3.sh "$REP_MP3/$JOB_TITLE"
			envoyerNotification $PUSHTOKEN_SABNZBD "$JOB_TITLE conversion Flac terminee" "$DATE" 
		
		exit 0
	fi
	
	
	
